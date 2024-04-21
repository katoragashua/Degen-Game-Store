// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    enum GameItems { Vests, Shield, Grenades, Drone }
    mapping(GameItems => uint256) public itemPrices;

    constructor() ERC20("Degen", "DGN")Ownable(msg.sender) {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function transferDegen(address _to, uint256 _amount) external returns(bool success) {
        require(_amount <= balanceOf(msg.sender), "Degen Token not enough");
        success = transfer(_to, _amount);
    }

    function burn(uint256 _amount) external {
        require(_amount <= balanceOf(msg.sender), "Degen Token not enough");
        _burn(msg.sender, _amount);
    }

    function setItemPrices() external onlyOwner {
        itemPrices[GameItems.Vests] = 5e18;
        itemPrices[GameItems.Shield] = 4e18;
        itemPrices[GameItems.Grenades] = 3e18;
        itemPrices[GameItems.Drone] = 2e18;
    }

    function purchaseItem(GameItems item) external {
        require(itemPrices[item] > 0, "Invalid item");
        require(itemPrices[item] <= balanceOf(msg.sender), "Degen Token not enough");
        
        _transfer(msg.sender, address(this), itemPrices[item]);
    }

    function withdrawFunds() external onlyOwner {
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

    function vaultBalance() external view onlyOwner returns(uint) {
        return address(this).balance;
    }

    function getPlayerBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }
}
