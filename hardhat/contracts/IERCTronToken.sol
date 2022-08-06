// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IERCTronToken is IERC20 {
    function mintAirdrop(address[] calldata holders, uint amount) external;
}
