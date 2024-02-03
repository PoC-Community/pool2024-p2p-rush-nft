// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IERC721.sol";
import "./PetFeeding.sol";

contract PetNFT is IERC721, PetFeeding {
    function mint(string memory name) public
    returns (uint256 value) {
        require(_petCount[msg.sender] < 5, "Input must be less than 5");
        value = _petCount[msg.sender];
        _myPet memory new_pet;
        new_pet.toFeed = block.timestamp;
        new_pet.name = name;
        new_pet.level = 1;
        _owners[value] = msg.sender;
        _petCount[msg.sender]++;
        _pet[value] = new_pet;
        emit Transfer(address(0x0), msg.sender, value);
        return value;
    }
    function balanceOf(address owner) public override view 
    returns (uint256)
    {
        return _petCount[owner];
    }
    function ownerOf(uint256 tokenId) public override view 
    returns (address)
    {
        require(_owners[tokenId] != address(0x0), "token dont exist");
        return _owners[tokenId];
    }

    function transferFrom(address from, address to, uint256 tokenId) public override
    {
        require(_owners[tokenId] != address(0x0), "token dont exist");
        require(_owners[tokenId] == from, "token not oned by from");
        if (msg.sender != from) {
            require(_approve[tokenId] == from && _approveAll[from] != address(0x0), "from not approved");
            _owners[tokenId] = to;
        } else {
            _owners[tokenId] = to;
        }
        emit Transfer(from, to, tokenId);
    }

    function approve(address to, uint256 tokenId) public override
    {
        require(_owners[tokenId] != address(0x0), "token dont exist");
        require(msg.sender == _owners[tokenId]);
        _approve[tokenId] = to;
        emit Approval(msg.sender , to, tokenId);
    }

    function setApprovalForAll(address operator, bool approved) public override
    {
        require(operator != address(0x0));
        if (approved == true) {
            _approveAll[operator] = msg.sender;
            emit ApprovalForAll(msg.sender, operator, approved);
        } else {
            delete _approveAll[operator];
        }
    }

    function getApproved(uint256 tokenId) public override view 
    returns (address)
    {
        require(_owners[tokenId] != address(0x0), "token dont exist");
        return _approve[tokenId];          
    }

    function isApprovedForAll(address owner, address operator) public override view 
    returns (bool)
    {
        require(operator != address(0x0));
        if (_approveAll[operator] == owner) {
            return true;
        } else {
            return false;
        }
    }
    function getAllNFTs() external view returns(_myPet[] memory) {
        uint256 count = 0;
        _myPet[] memory pets = new _myPet[](_petCount[msg.sender]);
        while (count != _petCount[msg.sender]) {
            pets[count] = _pet[count];
            count++;
        }
        return pets;
    }
} 