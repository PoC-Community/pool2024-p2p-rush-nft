// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IERC721Metadata.sol";
import "./PetNFT.sol";

contract PetNFTMetadata is IERC721Metadata, PetNFT {
    string public name;
    string public symbol;
    function tokenURI(uint256 tokenId) public pure override
    returns (string memory)
    {
        return string(abi.encodePacked("ipfs://QmbWR3hjvruEXMgjUy36cXguPUXVCA1gpbaBCdaMVY6cJ4/", tokenId));
    }
    function supportsInterface(bytes4 interfaceId) public pure
    returns (bool)
    {
        return interfaceId == type(IERC721).interfaceId || interfaceId == type(IERC721Metadata).interfaceId;
    }
}
