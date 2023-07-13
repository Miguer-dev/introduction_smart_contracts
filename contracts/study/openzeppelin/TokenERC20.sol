// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyTokenERC20 is ERC20("Random Token", "RDM") {

    constructor() {        
        _mint(msg.sender, 10000); //_totalSupply = 10000 
    }
}