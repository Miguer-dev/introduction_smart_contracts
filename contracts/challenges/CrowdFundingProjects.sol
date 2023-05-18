// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract CrowdFundingProjects {
    
    enum State { OPEN, CLOSE}

    struct Project {
        string name;
        string description;
        State currentState;
        uint funds;        
        address projectOwner;
        address payable fundWallet;   
        
    }

    struct Contribution {
        address contributor;
        uint amount;
        uint date;
    }

    mapping(string => Contribution[]) public contributions;      
    Project[] public projects;
    address public contractOwner;


    constructor() {
        contractOwner = msg.sender;
    }

    modifier isContractOwner(){
        require(msg.sender == contractOwner, "Only the owner can do this action");
        _;
    }

    modifier ceroFunds(){
        require(msg.value != 0, "Contributions must be greater than 0.");              
        _;
    }  

    event addedFunds(
        string projectName,
        uint amount,
        address wallet,
        uint date      
    );

    event changedState(
        string projectName,
        State newState,
        uint date
     ); 

     function initProject(string calldata _name, string calldata _description, address _projectOwner, address payable _fundWallet) public isContractOwner{
        Project memory newProject = Project (_name,_description,State.OPEN,0,_projectOwner,_fundWallet);    
        projects.push(newProject);
     }

     function fundProject (string calldata projectName) public  payable ceroFunds{       
        bool projectFound = false;

        for (uint i = 0; i < projects.length; i++) 
        {
            if (keccak256(bytes(projects[i].name)) == keccak256(bytes(projectName))) {
                require(projects[i].currentState != State.CLOSE, "Thank you for the contribution, the project has already closed the financing.");

                projects[i].fundWallet.transfer(msg.value);
                projects[i].funds += msg.value;

                Contribution memory newContribution = Contribution(msg.sender,msg.value,block.timestamp);
                contributions[projects[i].name].push(newContribution);
                
                emit addedFunds(projectName,msg.value, msg.sender, block.timestamp);

                projectFound = true;
                break;
            }            
        }

        require(projectFound, "We do not have a registered project with that name.");
    }

    function changeProjectState(string calldata projectName, State newState) public {
        bool projectFound = false;

        for (uint i = 0; i < projects.length; i++) 
        {
            if (keccak256(bytes(projects[i].name)) == keccak256(bytes(projectName))) {
                require(newState != projects[i].currentState, "The current state is the same as the one you want to change to.");   

                projects[i].currentState = newState;

                emit changedState(projectName,projects[i].currentState, block.timestamp);
                             
                projectFound = true;
                break;
            }            
        }

        require(projectFound, "We do not have a registered project with that name.");
    }   


}
    
