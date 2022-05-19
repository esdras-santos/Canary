// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./governance_contracts/Governor.sol";
import "./governance_contracts/extensions/GovernorSettings.sol";
import "./governance_contracts/extensions/GovernorCountingSimple.sol";
import "./governance_contracts/extensions/GovernorVotes.sol";
import "./governance_contracts/extensions/GovernorTimelockControl.sol";


/// @custom:security-contact esantoz@protonmail.com
contract GovernorContract is Governor, GovernorSettings, GovernorCountingSimple, GovernorVotes, GovernorTimelockControl {
    

    constructor(IVotes _token, TimelockController _timelock)
        Governor("GovernorContract")
        GovernorSettings(1 /* 1 block */, 7 days , 1e18)
        GovernorVotes(_token)
        GovernorTimelockControl(_timelock)
    {}

    
    function votingDelay()
        public
        view
        override(IGovernor, GovernorSettings)
        returns (uint256)
    {
        return super.votingDelay();
    }

    function execute(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        bytes32 descriptionHash
    ) public payable override(Governor, IGovernor) returns (uint256 proposalId){
        uint256 proposalid = super.hashProposal(targets, values, calldatas, descriptionHash);
        require(_voteSucceeded(proposalid));
        super.execute(targets,values,calldatas,descriptionHash);
    }

    
    function votingPeriod()
        public
        view
        override(IGovernor, GovernorSettings)
        returns (uint256)
    {
        return super.votingPeriod();
    }


    function state(uint256 proposalId)
        public
        view
        override(Governor, GovernorTimelockControl)
        returns (ProposalState)
    {
        return super.state(proposalId);
    }

    function propose(address[] memory targets, uint256[] memory values, bytes[] memory calldatas, string memory description)
        public
        override(Governor, IGovernor)
        returns (uint256)
    {
        return super.propose(targets, values, calldatas, description);
    }

    function proposalThreshold()
        public
        view
        override(Governor, GovernorSettings)
        returns (uint256)
    {
        return super.proposalThreshold();
    }

    function _execute(uint256 proposalId, address[] memory targets, uint256[] memory values, bytes[] memory calldatas, bytes32 descriptionHash)
        internal
        override(Governor, GovernorTimelockControl)
    {
        super._execute(proposalId, targets, values, calldatas, descriptionHash);
    }

    function _cancel(address[] memory targets, uint256[] memory values, bytes[] memory calldatas, bytes32 descriptionHash)
        internal
        override(Governor, GovernorTimelockControl)
        returns (uint256)
    {
        return super._cancel(targets, values, calldatas, descriptionHash);
    }

    function _executor()
        internal
        view
        override(Governor, GovernorTimelockControl)
        returns (address)
    {
        return super._executor();
    }

    
}