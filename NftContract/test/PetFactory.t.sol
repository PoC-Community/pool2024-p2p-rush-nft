// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {PetFactory} from "../src/PetFactory.sol";

contract PetFactoryHelper is PetFactory {
    function createPet(string memory _name) external returns (uint256 value) {
        return _createPet(_name);
    }
}

contract PetFactoryTest is Test {
    PetFactoryHelper public petFactory;

    function setUp() public {
        petFactory = new PetFactoryHelper();
    }

    function testCreateOnePet() public {
        assertEq(petFactory.createPet("Single pet"), 0);
    }

    function testCreatePetIfCallerHasAlreadyFivePets() public {
        assertEq(petFactory.createPet("Pet 1"), 0);
        assertEq(petFactory.createPet("Pet 2"), 1);
        assertEq(petFactory.createPet("Pet 3"), 2);
        assertEq(petFactory.createPet("Pet 4"), 3);
        assertEq(petFactory.createPet("Pet 5"), 4);
        vm.expectRevert();
        petFactory.createPet("Pet 6");
    }

    function testgetOwner() public {
        petFactory.createPet("Single pet");
        assertEq(petFactory.getOwner(0), address(this));
    }

    function testGetMyPetsId() public {
        uint256 petId = petFactory.createPet("Test Pet");
        uint256[] memory myPetsIds = petFactory.getMyPetsId();

        assertEq(myPetsIds.length, 1, "Failed to create a pet");
        assertEq(myPetsIds[0], petId, "Incorrect pet ID");
    }

    // edit to check addresses
    function testGetPetsIdFromAddress() public {
        petFactory.createPet("Pet 1");
        petFactory.createPet("Pet 2");
        assertEq(petFactory.getPetsIdFromAddress(address(this)).length, 2);
        assertEq(petFactory.getPetsIdFromAddress(address(this))[0], 0);
        assertEq(petFactory.getPetsIdFromAddress(address(this))[1], 1);
    }

    function testGetMyPetIfCallerIsNotTheOwner() public {
        petFactory.createPet("Pet 1");
        petFactory.createPet("Pet 2");
        vm.expectRevert();
        petFactory.getMyPet(42);
    }
}
