// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyTokenERC721 is ERC721("Random Token NF", "RNF") {

    constructor() {
        _mint(msg.sender, 1); //token ID = 1
    }
}