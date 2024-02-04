// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PetFactory {
    constructor() {
        cooldownTime = 1 minutes;
    }

    struct _myPet {
        string name;
        uint level;
        uint256 toFeed;
    }
    uint8 cooldownTime;
    _myPet[] private myPets;
    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _petCount;
    mapping(uint256 => _myPet) private _pet;
    mapping(uint256 => address) private _approve;
    mapping(address => address) private _approveAll;

    function getOwner(uint256 _petId) public view returns (address) {
        return _owners[_petId];
    }

    function _createPet(string memory _name) internal returns (uint256 value) {
        require(_petCount[msg.sender] < 5, "Input must be less than 5");
        _petCount[msg.sender]++;
        value = _petCount[msg.sender];
        _myPet memory new_pet;
        new_pet.toFeed = block.timestamp;
        new_pet.name = _name;
        new_pet.level = 1;
        _owners[value - 1] = msg.sender;
        _pet[value - 1] = new_pet;
        myPets.push(new_pet);
        return (value - 1);
    }

    function getPetsIdFromAddress(
        address _owner
    ) public view returns (uint256[] memory) {
        uint256[] memory ownedPetIds = new uint256[](_petCount[_owner]);
        uint256 count = 0;
        for (uint256 i = 0; count != _petCount[_owner]; i++) {
            if (_owners[i] == _owner) {
                ownedPetIds[count] = i;
                count++;
            }
        }
        return ownedPetIds;
    }

    function getMyPetsId() public view returns (uint256[] memory) {
        uint256[] memory ownedPetIds = new uint256[](_petCount[msg.sender]);
        uint256 count = 0;
        for (uint256 i = 0; count != _petCount[msg.sender]; i++) {
            if (_owners[i] == msg.sender) {
                ownedPetIds[count] = i;
                count++;
            }
        }
        return ownedPetIds;
    }

    function getMyPet(
        uint256 _petId
    ) public view returns (_myPet memory myPet) {
        require(_owners[_petId] == msg.sender, "sender is not the owner");
        myPet = _pet[_petId];
        return myPet;
    }

    function setMyPet(uint256 _petId, _myPet memory _newPet) public {
        require(_owners[_petId] == msg.sender, "sender is not the owner");
        _pet[_petId] = _newPet;
    }

    function getCount(address _owner) public view returns (uint256) {
        return _petCount[_owner];
    }

    function getCount() public view returns (uint256) {
        return _petCount[msg.sender];
    }

    function setCount(uint256 new_value) internal {
        _petCount[msg.sender] = new_value;
    }

    function setOwner(uint256 _petId, address _newOwner) internal {
        require(_owners[_petId] == msg.sender, "sender is not the owner");
        _owners[_petId] = _newOwner;
    }

    function set_Approve(uint256 _petId, address _newOwner) internal {
        require(_owners[_petId] == msg.sender, "sender is not the owner");
        _approve[_petId] = _newOwner;
    }

    function get_Approve(uint256 _petId) public view returns (address) {
        return _approve[_petId];
    }

    function get_approveAll(address _owner) public view returns (address) {
        return _approveAll[_owner];
    }

    function removeFrom_approveAll(address _owner) internal {
        delete _approveAll[_owner];
    }

    function set_approveAll(address _owner, address _operator) internal {
        _approveAll[_operator] = _owner;
    }

    function levelUpPet(uint256 _petId) internal {
        _pet[_petId].level++;
    }
}
