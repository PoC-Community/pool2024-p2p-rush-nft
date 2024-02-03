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
    _myPet[] myPets;
    mapping (uint256 => address) _owners;
    mapping (address => uint256) _petCount;
    mapping (uint256 => _myPet) _pet;
    mapping (uint256 => address) _approve;
    mapping (address => address) _approveAll;
    function _createPet(string memory _name) internal 
        returns (uint256 value) {
            require(_petCount[msg.sender] < 5, "Input must be less than 5");
            _petCount[msg.sender]++;
            value = _petCount[msg.sender];
            _myPet memory new_pet;
            new_pet.toFeed = block.timestamp;
            new_pet.name = _name;
            new_pet.level = 1;
            _owners[value] = msg.sender;
            _pet[value] = new_pet;
            myPets[value] = new_pet;
            return value;
        }
    function getPetsIdFromAddress(address _owner) public view 
        returns (uint256[] memory) {
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
    function getMyPetsId() public view 
    returns (uint256[] memory) {
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
    function getMyPet(uint256 _petId) public view 
    returns (_myPet memory myPet) {
        require(_owners[_petId] == msg.sender, "sender is not the owner");
        myPet = _pet[_petId];
        return myPet;
    }
}