// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IERC721.sol";
import "./PetFeeding.sol";

contract PetNFT is IERC721, PetFeeding {
    function mint(string memory name) public returns (uint256 value) {
        require(getCount() < 5, "Input must be less than 5");
        value = getCount();
        _myPet memory new_pet;
        new_pet.toFeed = block.timestamp;
        new_pet.name = name;
        new_pet.level = 1;
        setOwner(value, msg.sender);
        setCount(getCount() + 1);
        setMyPet(value, new_pet);
        emit Transfer(address(0x0), msg.sender, value);
        return value;
    }

    function balanceOf(address owner) public view override returns (uint256) {
        return getCount(owner);
    }

    function ownerOf(uint256 tokenId) public view override returns (address) {
        require(getOwner(tokenId) != address(0x0), "token dont exist");
        return getOwner(tokenId);
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override {
        require(getOwner(tokenId) != address(0x0), "token dont exist");
        require(getOwner(tokenId) == from, "token not oned by from");
        if (msg.sender != from) {
            require(
                get_Approve(tokenId) == from &&
                    get_approveAll(from) != address(0x0),
                "from not approved"
            );
            setOwner(tokenId, to);
        } else {
            setOwner(tokenId, to);
        }
        emit Transfer(from, to, tokenId);
    }

    function approve(address to, uint256 tokenId) public override {
        require(getOwner(tokenId) != address(0x0), "token dont exist");
        require(msg.sender == getOwner(tokenId));
        setOwner(tokenId, to);
        emit Approval(msg.sender, to, tokenId);
    }

    function setApprovalForAll(
        address operator,
        bool approved
    ) public override {
        require(operator != address(0x0));
        if (approved == true) {
            set_approveAll(operator, msg.sender);
            emit ApprovalForAll(msg.sender, operator, approved);
        } else {
            removeFrom_approveAll(operator);
        }
    }

    function getApproved(
        uint256 tokenId
    ) public view override returns (address) {
        require(getOwner(tokenId) != address(0x0), "token dont exist");
        return get_Approve(tokenId);
    }

    function isApprovedForAll(
        address owner,
        address operator
    ) public view override returns (bool) {
        require(operator != address(0x0));
        if (get_approveAll(operator) == owner) {
            return true;
        } else {
            return false;
        }
    }

    function getAllNFTs() external view returns (_myPet[] memory) {
        _myPet[] memory pets = new _myPet[](5);
        for (uint256 count = 0; count < 5; count++) {
            if (count < getCount()) pets[count] = getMyPet(count);
            else pets[count] = _myPet({toFeed: 0, name: "", level: 0});
        }
        return pets;
    }
}
