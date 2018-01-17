pragma solidity ^0.4.6;


contract HoneyPot {
    mapping (address => uint) public balances;

    function HoneyPot() payable {
        put();
    }

    function put() 
        public
        payable
    {
        balances[msg.sender] = msg.value;
    }

    function get() {
        require(msg.sender.call.value(balances[msg.sender])());
        balances[msg.sender] = 0;
    }

    function() {
        revert();
    }
}