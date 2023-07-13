// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <9.0.0;  

import "@openzeppelin/contracts/access/Ownable.sol";   

contract MyContract is Ownable{
  
    function publicFunction () public {}
    function privateFunction () public onlyOwner {}

}