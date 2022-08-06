// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TronToken is ERC20Burnable, Ownable {
    mapping(address => bool) private _controllers;

    constructor(string memory _name, string memory _symbol)
        ERC20(_name, _symbol)
    {}

    function mint(address to, uint256 amount) external {
        require(_controllers[msg.sender] == true);
        require(amount > 0);

        _mint(to, amount);
    }

    function mintAirdrop(address[] calldata holders, uint amount) external {
        require(_controllers[msg.sender] == true);

        for (uint i = 0; i < holders.length; i++) {
            address holder = holders[i];
            _mint(holder, amount);
        }
    }

    function burnFrom(address account, uint256 amount) public virtual override {
        if (_controllers[msg.sender]) {
            _burn(account, amount);
        } else {
            super.burnFrom(account, amount);
        }
    }

    function addController(address controller) external onlyOwner {
        _controllers[controller] = true;
    }

    function removeController(address controller) external onlyOwner {
        _controllers[controller] = false;
    }

    function isController(address controller) external view returns(bool) {
       return _controllers[controller];
    }
}
