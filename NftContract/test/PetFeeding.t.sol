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

    function setUp() public {
        petFeeding = new PetFeedingHelper();
    }

    function testFeedMeFail() public {
        vm.startPrank(testAddress);
        petFeeding.createPet("Pet 1");
        vm.expectRevert();
        petFeeding.feedMe(0);
    }

    // Success test require to edit TimeStamp
    // function testFeedMeSuccess() public {
    //     vm.startPrank(testAddress);
    //     petFeeding.createPet("Pet 1");
    //     petFeeding.feedMe(0);
    //     assertEq(petFeeding.getMyPet(0).level, 2);
    // }

    function testGetPrice() public {
        assertEq(petFeeding.getPrice(), 0.000001 ether);
    }

    function testSetPrice() public {
        petFeeding.setPrice(0.000004 ether);
        assertEq(petFeeding.getPrice(), 0.000004 ether);
    }
}
