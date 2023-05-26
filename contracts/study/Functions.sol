// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Numbers {

    uint private number = 1994;

    function getNumber() public view returns (uint){
        return number;        
    }

    function setNumber(uint _number) public {
        number = _number;
    } 

    function nextNumber(uint newNumber) public pure returns (uint){
        return newNumber + 1;
    }

    function nextSaveNumber() public returns (uint){
        number += 1;
        return number;
    }    

}