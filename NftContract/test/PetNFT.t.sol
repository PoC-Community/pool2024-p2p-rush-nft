// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {PetNFT} from "../src/PetNFT.sol";

contract PetNFTHelper is PetNFT {
    function createPet(string memory _name) external returns (uint256 value) {
        return _createPet(_name);
    }
}

contract PetFeedingTest is Test {
    PetNFTHelper public petNFT;
    address payable testAddress = payable(address(42));

    function setUp() public {
        petNFT = new PetNFTHelper();
    }

    function test_Mint() public {
        assertEq(petNFT.mint("Pet 1"), 0);
        assertEq(petNFT.mint("Pet 2"), 1);
        assertEq(petNFT.mint("Pet 3"), 2);
        assertEq(petNFT.mint("Pet 4"), 3);
        assertEq(petNFT.mint("Pet 5"), 4);
        vm.expectRevert();
        petNFT.mint("Pet 6");
    }

    function test_getAllNFTs() public {
        petNFT.mint("Pet 1");
        petNFT.mint("Pet 2");
        petNFT.mint("Pet 3");
        petNFT.mint("Pet 4");
        assertEq(petNFT.getAllNFTs().length, 5);
        assertEq(petNFT.getAllNFTs()[0].name, "Pet 1");
        assertEq(petNFT.getAllNFTs()[1].name, "Pet 2");
        assertEq(petNFT.getAllNFTs()[2].name, "Pet 3");
        assertEq(petNFT.getAllNFTs()[3].name, "Pet 4");
        assertEq(petNFT.getAllNFTs()[4].name, "");
    }
}
