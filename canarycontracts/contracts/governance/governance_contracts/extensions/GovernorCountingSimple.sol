// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.6.0) (governance/extensions/GovernorCountingSimple.sol)

pragma solidity ^0.8.0;

import "../Governor.sol";

/**
 * @dev Extension of {Governor} for simple, 3 options, vote counting.
 *
 * _Available since v4.3._
 */
abstract contract GovernorCountingSimple is Governor {
    /**
     * @dev Supported vote types. Matches Governor Bravo ordering.
     */
    enum VoteType {
        Against,
        For,
        Abstain
    }

    struct ProposalVote {
        uint256 againstVotes;
        uint256 forVotes;
        uint256 abstainVotes;
        uint256 againstPower;
        uint256 forPower;
        uint256[] forWeights;
        uint256[] againstWeights;
        address[] forVoters;
        address[] againstVoters;
        mapping(address => bool) hasVoted;
    }

    mapping(uint256 => ProposalVote) private _proposalVotes;

    /**
     * @dev See {IGovernor-COUNTING_MODE}.
     */
    // solhint-disable-next-line func-name-mixedcase
    function COUNTING_MODE() public pure virtual override returns (string memory) {
        return "support=bravo&quorum=for,abstain";
    }

    /**
     * @dev See {IGovernor-hasVoted}.
     */
    function hasVoted(uint256 proposalId, address account) public view virtual override returns (bool) {
        return _proposalVotes[proposalId].hasVoted[account];
    }

    /**
     * @dev Accessor to the internal vote counts.
     */
    function proposalVotes(uint256 proposalId)
        public
        view
        virtual
        returns (
            uint256 againstVotes,
            uint256 forVotes,
            uint256 abstainVotes
        )
    {
        ProposalVote storage proposalvote = _proposalVotes[proposalId];
        return (proposalvote.againstVotes, proposalvote.forVotes, proposalvote.abstainVotes);
    }

    /**
     * @dev See {Governor-_voteSucceeded}. In this module, the forVotes must be strictly over the againstVotes.
     */
    function _voteSucceeded(uint256 proposalId) internal view virtual override returns (bool) {
        ProposalVote storage proposalvote = _proposalVotes[proposalId];

        return proposalvote.forVotes > proposalvote.againstVotes;
    }

    /**
     * @dev See {Governor-_countVote}. In this module, the support follows the `VoteType` enum (from Governor Bravo).
     */
    function _countVote(
        uint256 proposalId,
        address account,
        uint8 support,
        uint256 weight,
        bytes memory // params
    ) internal virtual override {
        ProposalVote storage proposalvote = _proposalVotes[proposalId];

        require(!proposalvote.hasVoted[account], "GovernorVotingSimple: vote already cast");
        proposalvote.hasVoted[account] = true;
        

        if (support == uint8(VoteType.Against)) {
            proposalvote.againstVoters.push(msg.sender);
            proposalvote.againstWeights.push(weight);
            proposalvote.againstPower += weight;
            proposalvote.againstVotes += 1;
        } else if (support == uint8(VoteType.For)) {
            proposalvote.forVoters.push(msg.sender);
            proposalvote.forWeights.push(weight);
            proposalvote.forPower += weight;
            proposalvote.forVotes += 1;
        } else if (support == uint8(VoteType.Abstain)) {
            proposalvote.abstainVotes += 1;
        } else {
            revert("GovernorVotingSimple: invalid value for enum VoteType");
        }
    }


    function getForVoters(uint256 proposalId) external view returns(address[] memory){
        ProposalVote storage proposalvote = _proposalVotes[proposalId];
        return proposalvote.forVoters;        
    }

    function getAgainstVoters(uint256 proposalId) external view returns(address[] memory){
        ProposalVote storage proposalvote = _proposalVotes[proposalId];
        return proposalvote.againstVoters;        
    }

    function againstWeights(uint256 proposalId) external view returns(uint256[] memory){
        ProposalVote storage proposalvote = _proposalVotes[proposalId];
        return proposalvote.againstWeights;        
    }

    function forWeights(uint256 proposalId) external view returns(uint256[] memory){
        ProposalVote storage proposalvote = _proposalVotes[proposalId];
        return proposalvote.forWeights;        
    }

    function forPower(uint256 proposalId) external view returns(uint256){
        ProposalVote storage proposalvote = _proposalVotes[proposalId];
        return proposalvote.forPower;        
    }

    function againstPower(uint256 proposalId) external view returns(uint256){
        ProposalVote storage proposalvote = _proposalVotes[proposalId];
        return proposalvote.againstPower;        
    }
}
