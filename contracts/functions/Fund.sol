// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Fund {

    address private ownAdderss = 0x583031D1113aD414F02576BD6afaBfb302140225;

    function sendEthers (address payable receiver) public  payable{
        receiver.transfer(msg.value);
    }
    
}