pragma solidity ^0.4.13;
contract SimpleBank {

    mapping (address => uint) private balances;
    
    mapping (address => bool) public enrolled;

    address public owner;

    event LogEnrolled(address accountAddress);
    event LogDepositMade(address accountAddress, uint amount);
    event LogWithdrawal(address accountAddress, uint withdrawalAmount, uint newBalance);

    constructor() public {
        owner = msg.sender;
    }

    function enroll() public returns (bool){

        enrolled[msg.sender] = true;
        
        emit LogEnrolled(msg.sender);

        return enrolled[msg.sender];
    }

    function deposit() public payable returns (uint) {

        balances[msg.sender] += msg.value;
        
        emit LogDepositMade(msg.sender, msg.value);
        
        return balances[msg.sender];
    }

    function withdraw(uint256 withdrawalAmount) public returns (uint remainingBal) {

        if( balances[msg.sender] < withdrawalAmount ) { revert(); }

        msg.sender.transfer(withdrawalAmount);

        balances[msg.sender] -= withdrawalAmount;

        emit LogWithdrawal(msg.sender, withdrawalAmount, balances[msg.sender]);

        return balances[msg.sender];
    }


    function balance() public constant returns (uint) {
        return balances[msg.sender];
    }


    function() public {
        revert();
    }
}
