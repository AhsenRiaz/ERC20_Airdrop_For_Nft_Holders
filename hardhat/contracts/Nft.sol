// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Nft is ERC721Enumerable, Ownable {
    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
    {}

    function mint(address to, uint amount) external {
        uint256 _totalSupply = totalSupply();
        require(to != address(0));
        require(amount > 0);

        for (uint i = 0; i < amount; i++) {
            _mint(to, _totalSupply + 1);
        }
    }
}
