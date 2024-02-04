// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./PetFactory.sol";

contract PetFeeding is PetFactory {
    constructor() PetFactory() {
        contractOwner = msg.sender;
    }

    address contractOwner;
    uint256 public levelFee = 0.000001 ether;
    modifier onlyPetOwner(uint256 _petId) {
        require(msg.sender == getOwner(_petId), "Not the pet owner");
        _;
    }

    function feedMe(uint256 _petId) external payable onlyPetOwner(_petId) {
        require(
            block.timestamp >= getMyPet(_petId).toFeed + 1 minutes,
            "Pet can't be fed yet"
        );
        require(msg.sender.balance < levelFee, "Pet can't be feed");
        levelUpPet(_petId);
    }

    modifier onlyContractOwner() {
        require(msg.sender == contractOwner);
        _;
    }

    function setPrice(uint256 _levelFee) external onlyContractOwner {
        levelFee = _levelFee;
    }

    function getPrice() external payable returns (uint256 price) {
        price = levelFee;
    }
}
