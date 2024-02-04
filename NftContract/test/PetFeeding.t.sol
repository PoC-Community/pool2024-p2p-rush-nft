// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {PetFeeding} from "../src/PetFeeding.sol";

contract PetFeedingHelper is PetFeeding {
    function createPet(string memory _name) external returns (uint256 value) {
        return _createPet(_name);
    }
}

contract PetFeedingTest is Test {
    PetFeedingHelper public petFeeding;
    address payable testAddress = payable(address(42));

    // vestingPlatform.createVesting{value: 0.5 ether}(testAddress, endTimestamp);

    function setUp() public {
        petFeeding = new PetFeedingHelper();
    }

    function testFeedMe() public {
        vm.startPrank(testAddress);
        petFeeding.createPet("Pet 1");
        petFeeding.feedMe(0);
        assertTrue(petFeeding.getMyPet(0).level == 2, "Level should be 2");
    }
}