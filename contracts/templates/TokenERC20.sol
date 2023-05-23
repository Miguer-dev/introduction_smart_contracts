// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract TokenERC20 {

    string private name;
    string private symbol;
    uint8 private decimals;
    uint private totalSupply;

    mapping(address => uint) private balances;    
    mapping(address => mapping(address => uint)) private allowances;

    constructor (string memory _name, string memory _symbol, uint8 _decimals, uint _totalSupply){
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        balances[msg.sender] = _totalSupply;
    }

    event Transfer(
        address indexed from, 
        address indexed to, 
        uint value
    );
    
    event Approval(
        address indexed owner, 
        address indexed spender, 
        uint value
    );

    function getName() public view returns (string memory){
        return name;
    }

    function getSymbol() public view returns (string memory){
        return symbol;
    }

    function getDecimals() public view returns (uint8){
        return decimals;
    }

    function getTotalSupply() public  view  returns (uint){
        return totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint){
        return balances[_owner];
    }

    function allowance(address _owner, address _spender) public view returns (uint){
        return allowances[_owner][_spender];
    }

    function transfer(address payable  _to, uint _value) public payable returns (bool success){
        require(balances[msg.sender] >= _value, "Insufficient tokens");
       
        balances[msg.sender] -= _value;
        balances[_to] += _value;

        emit Transfer(msg.sender, _to, _value); 
        
        success = true;
    }

    function approve(address _spender, uint _value) public returns (bool success){
        allowances[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value); 

        success = true;
    }  

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(balances[_from] >= _value, "Insufficient tokens");
        require(allowances[_from][msg.sender] >= _value, "You do not have permission to move this amount of tokens");
        
        balances[_from] -= _value;
        balances[_to] += _value;

        emit Transfer(_from, _to, _value); 
        
        success = true;
    }

}