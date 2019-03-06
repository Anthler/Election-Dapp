pragma solidity >= 0.4.20 < 0.6.0;

contract Election{
    
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public voters;

    event votedEvent(uint indexed _candidateId);

    uint public candidatesCount = 0;
    
    constructor() public  {

        addCandidates("Richard Abambillah");
        addCandidates("James Bervell Mainoo");

    }

    function addCandidates(string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidateId ) public {

        //require that they havent voted before
        require(!voters[msg.sender], "You only cast a single vote sorry");
        //require a valid candidate
        require(_candidateId >0 && _candidateId <= candidatesCount);
        //record that voter has voted
        voters[msg.sender] = true;
        //update candidate votes count
        candidates[_candidateId].voteCount++;

        emit votedEvent(_candidateId);
    }
}
