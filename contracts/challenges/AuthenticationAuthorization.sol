// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract AuthenticationAuthorization {

    string private privateInfo;
    string private superSecretInfo;
    address public contractOwner;

    mapping(address => bool) private usersAuthentication;    
    mapping(address => bool) private rolePrivate;
    mapping(address => bool) private roleSuperSecret;

    enum UserRole {PRIVATE, SUPERSECRET}

    error Unauthorized(
        address user,
        UserRole necessaryRole,
        uint date
    );

    modifier authenticatedUser() {
        require(usersAuthentication[msg.sender] == true, "You must be authenticated to perform this action");
        _;
    }

    modifier authorizedUser(UserRole role) {
        if (msg.sender == contractOwner) {
             _;
        } else if ((role == UserRole.PRIVATE && rolePrivate[msg.sender]) || 
                   (role == UserRole.SUPERSECRET && roleSuperSecret[msg.sender])) {
            _;
        } else {
            revert Unauthorized(msg.sender, role, block.timestamp);
        }
    }

    modifier onlyOwner(){
        require(msg.sender == contractOwner, "Only the owner can perform this action");
        _;
    }    

    constructor (){
        contractOwner = msg.sender;
    }
    
    function authenticate() public {
        usersAuthentication[msg.sender] = true;
    }

    function deauthenticate() public {
        usersAuthentication[msg.sender] = false;
    }    

    function setRole (address user, UserRole role, bool assign) public onlyOwner{
        if (role == UserRole.PRIVATE) {
            rolePrivate[user] = assign;
        } else if (role == UserRole.SUPERSECRET){
            roleSuperSecret[user] = assign;
        }
    }

    function getPrivateInfo () public view authenticatedUser authorizedUser(UserRole.PRIVATE) returns (string memory){
        return privateInfo;
    }

    function getSuperSecretInfo () public view authenticatedUser authorizedUser(UserRole.SUPERSECRET) returns (string memory){
        return superSecretInfo;
    }

    function setPrivateInfo (string calldata data) public onlyOwner{
        privateInfo = data;
    }

    function setSuperSecretInfo (string calldata data) public onlyOwner{
        superSecretInfo = data;
    }

}