// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract TokenERC721 {

    string private name;
    string private symbol;

    //tokenID => owner
    mapping(uint256 => address) private owners;
    //owner => amount
    mapping(address => uint) private balances;
    //tokenID => operator    
    mapping(uint => address) private tokenApprovals;
    //owner => operator => approved
    mapping(address => mapping(address => bool)) private operatorApprovals;

    constructor(string memory name_, string memory symbol_) {
        name = name_;
        symbol = symbol_;
    }

    event Transfer(
        address indexed from, 
        address indexed to, 
        uint indexed tokenId
    );

    event Approval(
        address indexed owner, 
        address indexed approved, 
        uint indexed tokenId
    );

    event ApprovalForAll(
        address indexed owner, 
        address indexed operator,
        bool approved
    );

    function getName() public view returns (string memory){
        return name;
    }

    function getSymbol() public view returns (string memory){
        return symbol;
    }

    function balanceOf(address _owner) public view returns (uint){
        return balances[_owner];
    }

    function ownerOf(uint _tokenId) public view returns (address){
        return owners[_tokenId];
    }

    function getApproved(uint _tokenId) public view returns (address){
        return tokenApprovals[_tokenId];
    }

    function isApprovedForAll(address _owner, address _operator) public view returns (bool){
        return operatorApprovals[_owner][_operator];
    }

    function transferFrom(address _from, address _to, uint _tokenId) public payable{
        require( 
            owners[_tokenId] == _from &&
            msg.sender == _from || 
            tokenApprovals[_tokenId] == msg.sender ||
            operatorApprovals[_from][msg.sender]            
            , "You must be the owner of the token or be approved to transfer it"
        );

        owners[_tokenId] = _to;
        balances[_from] -= 1;
        balances[_to] += 1;

        emit Transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint _tokenId) public payable{
       require( 
            owners[_tokenId] == msg.sender || 
            operatorApprovals[owners[_tokenId]][msg.sender]            
            , "You must be the owner of the token or be approved to transfer it"
        );       
       require(_approved != owners[_tokenId], "Cannot approve current token owner"); 

       tokenApprovals[_tokenId] = _approved;

       emit Approval (owners[_tokenId], _approved, _tokenId);
    }

    function setApprovalForAll(address _operator, bool _approved) public{
        require(msg.sender != _operator, "Not need to approve");

        operatorApprovals[msg.sender][_operator] = _approved;

        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

}