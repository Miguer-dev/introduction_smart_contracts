// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";   


contract ERC20BurnablePausable is ERC20, ERC20Burnable, ERC20Pausable, Ownable {

    constructor() ERC20("Random Token","RDM") Ownable(_msgSender())  {        
        _mint(msg.sender, 10000);
    }

    function burn(uint256 value) public override onlyOwner {
        super.burn(value);
    }

    function burnFrom(address account, uint256 value) public override onlyOwner{
        super.burnFrom(account,value);
    }

    function pause() public onlyOwner{
        _pause();
    }

    function unpause() public onlyOwner{
        _unpause();
    }

    function _update(address from, address to, uint256 value) internal override(ERC20,ERC20Pausable) whenNotPaused {
        super._update(from, to, value);
    }   

}