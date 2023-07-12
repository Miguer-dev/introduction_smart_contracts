// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/AccessControl.sol";   

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage is AccessControl {

    bytes32 public constant ROL_Admin = keccak256("ROL_Admin");
    bytes32 public constant ROL_Writer = keccak256("ROL_Writer");

    uint256 number;

    constructor() {
        _grantRole(ROL_Admin, msg.sender);
        _setRoleAdmin(ROL_Writer, ROL_Admin);
    }

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function store(uint256 num) public onlyRole(ROL_Writer){
        number = num;
    }

    /**
     * @dev Return value 
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256){
        return number;
    }
}