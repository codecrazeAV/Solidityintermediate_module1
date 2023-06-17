// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExceptionHandlingExample {
    mapping(address => uint256) public balances;
    mapping(address => uint256) public tokbalances;
    function deposit(uint _val) public payable {
        // Increase the balance of the sender by the deposited amount
        balances[msg.sender] += _val;
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        // Perform withdrawal logic
    }
    function transfer(address to, uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(to != address(0), "Invalid recipient");

        balances[msg.sender] -= amount;
        balances[to] += amount;
        // Perform transfer logic

        if (amount > 100) {
            revert("Amount exceeds the limit");
        }
    }
     function buyTokens(uint amount) public payable {
        uint256 tokenPrice = 10; // Assume the price of one token is 10 wei

        uint256 totalCost = amount * tokenPrice;

        // Ensure that the sender has sent enough Ether to cover the purchase
        assert(balances[msg.sender] >= totalCost);

        // Perform token transfer logic
        tokbalances[msg.sender] += amount;
        balances[msg.sender] -=totalCost;
    }

    function sellTokens(uint256 amount) public{
        uint256 tokenPrice = 10; // Assume the price of one token is 10 wei

        uint256 totalSaleValue = amount * tokenPrice;

        // Ensure that the sender has enough tokens to sell
        
        assert(tokbalances[msg.sender] >= amount);

        // Perform token transfer logic
        tokbalances[msg.sender] -= amount;

        // Transfer Ether back to the sender as the sale proceeds
        balances[msg.sender]+=totalSaleValue;
    }
}
