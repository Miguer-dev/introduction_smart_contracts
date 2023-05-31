// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Recepcion {
    
    struct Message {
        uint value;
        string note;
    }

    mapping(address => Message) balances;    
    
    receive() external payable {
        balances[msg.sender] = Message( balances[msg.sender].value + msg.value, "");
    }
    
    fallback() external payable {
        
    }
    
    function recibirSaldo(string memory note) public payable {
        balances[msg.sender] = Message( balances[msg.sender].value + msg.value, note);
    }
    
}