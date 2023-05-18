// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract CrowdFunding {
    enum State { OPEN, CLOSE}
    
    string public name;
    string public description;
    mapping(address => uint) public balances;    
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

    modifier isOwner(){
        require(msg.sender == owner, "Only the owner can do this action");
        _;
    }

    modifier isNotOwner(){
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

    modifier ceroFunds(){
        require(msg.value != 0, "Contributions must be greater than 0.");              
        _;
    }    

    event addedFunds(
        uint amount,
        address wallet,
        uint date      
    );

    event changedState(
        State newState,
        uint date
     ); 

    function fundProject () public  payable maxFundsReach closeFunding isNotOwner ceroFunds{        

        fundsWallet.transfer(msg.value);
        emit addedFunds(msg.value, msg.sender, block.timestamp);
        balances[msg.sender] += msg.value;
        
        if(getFunds() > maxFunds){
                currentState = State.CLOSE;
                emit changedState(currentState, block.timestamp);
        }     
    }    

    function changeProjectState(State newState) public isOwner{

        require(newState != currentState, "The current state is the same as the one you want to change to.");  
        currentState = newState;
        emit changedState(currentState, block.timestamp);
    }

    function getState() public view  returns (State) {        
        return currentState;
    }    

    //saldo en wei (ether * 10^18)
    function getFunds() public view  returns (uint){
        return fundsWallet.balance / 10**18;
    }
}
    
