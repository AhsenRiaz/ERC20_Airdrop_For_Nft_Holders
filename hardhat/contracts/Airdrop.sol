// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "./IERCTronToken.sol";

contract Airdrop is Ownable, Pausable {
    IERCTronToken private _tronToken;

    
    uint256 private _airDrop = 2 ether;

    constructor(IERCTronToken tronToken) {
        _tronToken = tronToken;
    }

    function airdropTokens(address[] calldata holders) external onlyOwner whenNotPaused {
        _tronToken.mintAirdrop(holders, _airDrop);
    }
}
