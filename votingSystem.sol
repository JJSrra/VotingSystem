pragma solidity ^0.4.20;

// Smart contract for a voting system
contract VotingSystem{

    // Voter struct, representing each voter, where:
    // - alreadyVoted is a flag that is active if this voter has already voted
    // - vote is the index of this voter's vote
    struct Voter{
        bool alreadyVoted;
        uint vote;
    }

    // Party struct, representing each party, where:
    // - name represents each party's acronym
    // - votes is the count of the votes each party has received
    struct Party{
        bytes32 name;
        uint votes;
    }

    // Variables that will store all voters and parties
    mapping (address => Voter) public voters;
    Party[] public parties;

    // Constructor function, that receives an array with the name
    // of each party, and creates every necessary slot in "parties" array
    function VotingSystem (bytes32[] partiesNames) public {
        for (uint i=0; i < partiesNames.length; ++i){
            // The party is included in the array
            parties.push(Party({
                name: partiesNames[i],
                votes: 0
            }));
        }
    }

    // Voting function, can only be called once per voter
    function Vote (uint partyVote) public {
        // First the currentVoter has to be located, and it is mandatory
        // to check if they have already voted
        //Voter storage currentVoter = voters[msg.sender];
        require(!voters[msg.sender].alreadyVoted);

        // If they have not already voted, the flag is switched to true,
        // and then the vote is registered
        voters[msg.sender].vote = partyVote;
        voters[msg.sender].alreadyVoted = true;

        // And of course, the vote is added to the party's count
        parties[partyVote].votes++;

    }
}
