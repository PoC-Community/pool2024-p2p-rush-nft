// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {PetFeeding} from "../src/PetFeeding.sol";

contract PetFeedingHelper is PetFeeding {
    function createPet(string memory _name) external returns (uint256 value) {
        return _createPet(_name);
    }

    function setToFeed(uint256 _petId, uint256 new_value) external {
        _setToFeed(_petId, new_value);
    }
}

contract PetFeedingTest is Test {
    PetFeedingHelper public petFeeding;
    address payable testAddress = payable(address(42));

    function setUp() public {
        petFeeding = new PetFeedingHelper();
    }

    function testFeedMeFail() public {
        vm.startPrank(testAddress);
        petFeeding.createPet("Pet 1");
        vm.expectRevert();
        petFeeding.feedMe(0);
    }

    function testFeedMeSuccess() public {
        vm.startPrank(testAddress);
        petFeeding.createPet("Pet 1");
        petFeeding.setToFeed(0, -1 minutes);
        petFeeding.feedMe(0);
        assertTrue(petFeeding.getMyPet(0).level == 2, "Level should be 2");
    }
}
