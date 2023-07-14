// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

library MathLibrary {
    function mult(uint a, uint b) internal pure returns (uint) {
        return a * b;
    }
}

using MathLibrary for uint;


contract Animal {
    string public name;
    uint public age;
    string private id;
    address public owner;

    constructor(string memory _name, uint _age, string memory _id) {
        name = _name;
        age = _age;
        id = _id;
        owner = msg.sender;
    }

    function checkId () public view virtual returns (string memory){
        return id;
    }

    function makeSound() public pure virtual returns (string memory) {
        return "Animal sound";
    }
}

contract Dog is Animal {
    
    constructor(string memory _name, uint _age, string memory _id) Animal(_name,_age,_id) {
    }

    function makeSound() public pure override returns (string memory) {
        return "Woof!";
    }    

    function checkId() public view override returns (string memory) {
        require(owner == msg.sender, "Only the owner can do this action");
        return super.checkId();
    }

    function humanAge() public view returns (uint) {
        return age.mult(7);
    }
}