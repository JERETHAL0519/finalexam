// contracts/PaymentContract.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PaymentContract {
    address public payer;
    address public payee;
    uint public amount;
    uint public expiry;

    event ContractDeployed(address indexed payer, address indexed payee, uint amount, uint expiry);
    event Withdrawal(address indexed payee, uint amount); // 新增 Withdrawal 事件

    modifier onlyPayer() {
        require(msg.sender == payer, "Only payer can execute this");
        _;
    }

    modifier enoughBalance() {
        require(payable(msg.sender).balance >= amount, "Insufficient balance to deploy the contract");
        _;
    }

    modifier contractNotExpired() {
        require(block.timestamp <= expiry, "Contract has expired");
        _;
    }

    constructor(address _payee, uint _amount, uint _expiry) {
        payer = msg.sender;
        payee = _payee;
        require(_amount > 0, "Amount must be greater than 0");
        amount = _amount;
        expiry = block.timestamp + _expiry;

        // 使用 assert 斷言語句
        assert(payer != address(0));
        assert(payee != address(0));
        assert(amount > 0);
        assert(expiry > block.timestamp);

        // Emit the event when the contract is deployed
        emit ContractDeployed(msg.sender, _payee, _amount, _expiry);
    }

    modifier onlyPayee() {
        require(msg.sender == payee, "Only payee can execute this");
        _;
    }

    function updateAmount(uint _newAmount) external onlyPayer {
        amount = _newAmount;
    }

    function makePayment() external payable {
        require(msg.value == amount, "Incorrect payment amount");
        emit Withdrawal(payee, amount);
        payable(payee).transfer(amount);
    }
}
