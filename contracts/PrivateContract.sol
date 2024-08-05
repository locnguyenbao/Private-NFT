// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract PrivateERC721Token is ERC721, AccessControl {
    uint256 private _currentTokenId;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor() ERC721("PrivateERC721Token", "PVT") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _currentTokenId = 0; // Initialize the token ID counter
    }

    function mint(address to) external onlyRole(MINTER_ROLE) {
        uint256 tokenId = _currentTokenId;
        _currentTokenId++;
        _mint(to, tokenId);
    }

    function grantMinterRole(address account) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _grantRole(MINTER_ROLE, account);
    }

    function revokeMinterRole(address account) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _revokeRole(MINTER_ROLE, account);
    }

    // Override supportsInterface to handle both ERC721 and AccessControl interfaces
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
