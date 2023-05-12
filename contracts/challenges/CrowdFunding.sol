// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract CrowdFunding {
    enum State { OPEN, CLOSE}
    
    string public name;
    string public description;
    address private owner;
    uint private maxFunds; //en ethers
    address payable private fundsWallet;
    State private currentState;

    constructor(string memory _name, string memory _description, uint _maxFunds, address payable _fundWallet) {       
        name = _name;
        description = _description;
        maxFunds = _maxFunds;
        fundsWallet = _fundWallet;
        currentState = State.OPEN;
        owner = msg.sender;
    }   

    modifier onlyOwner(){
        require(msg.sender == owner, "Only the owner can do this action");
        _;
    }

    modifier ownerNotFunding(){
        require(msg.sender != owner, "The owner of the project cannot finance it");
        _;
    }

    modifier maxFundsReach(){
        require(getFunds() < maxFunds, "Thank you for the contribution, we have already reached the funding goal.");              
        _;
    }

    modifier closeFunding(){
        require(currentState == State.OPEN, "Thank you for the contribution, the project has already closed the financing.");              
        _;
    }

    function fundProject () public  payable maxFundsReach closeFunding ownerNotFunding{
        fundsWallet.transfer(msg.value);

        if(getFunds() > maxFunds){
                currentState = State.CLOSE;
        }            
    }    

    function changeProjectState(State newState) public onlyOwner{
        currentState = newState;
    }

    function getState() public view  returns (State) {        
        return currentState;
    }    

    //saldo en wei (ether * 10^18)
    function getFunds() public view  returns (uint){
        return fundsWallet.balance / 10**18;
    }
}
    
