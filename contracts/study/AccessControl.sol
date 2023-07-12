// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <9.0.0;  

import "@openzeppelin/contracts/access/AccessControl.sol";   

contract Roles is AccessControl{
  
    bytes32 public constant ROL_MODERADOR = keccak256("ROL_MODERADOR");
    bytes32 public constant ROL_USUARIO = keccak256("ROL_USUARIO");

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function soloAdmin() public view  onlyRole(DEFAULT_ADMIN_ROLE){}

    function soloModerador() public view onlyRole(ROL_MODERADOR){}

    function soloUsuario() public view onlyRole(ROL_USUARIO){}


}