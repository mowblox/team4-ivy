// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Donate {
    // create organization
    address public owner;
    uint public targetAmount;
    uint public currentAmount;

    constructor(uint _targetAmount) {
        owner = msg.sender;
        targetAmount = _targetAmount;
    }
    
    struct Organization {
        address creator;
        string name;
        string about;
        uint goalAmount;
        uint currentAmount;
        uint createdTimestamp;
    }

    Organization[] public organizations;

    function createOrganization(string memory _name, string memory _about, uint _goalAmount) public {
        Organization memory newOrganization = Organization({
            creator: owner,
            name: _name,
            about: _about,
            goalAmount: _goalAmount,
            currentAmount: 0,
            createdTimestamp: block.timestamp
        });
        organizations.push(newOrganization);
    }

    
    // get organisations count
    function getOrganiationsCount() public view returns (uint) {
        return organizations.length;
    }

    // get single organisation
    function getOrganization(uint index) public view returns (Organization memory) {
        require(index < organizations.length, "Invalid index");
        Organization memory org = organizations[index];
        return (org);
    }

   // Get all organisations
    function getAllOrganizations() public view returns (Organization[] memory) {
        return organizations;
    }

    // Send tokens
    function makeDonation(uint amount, address add) public {}

    // Track tokens received
    function trackTokensReceived() public {}

    // Withdraw tokens
    function withdrawTokens() private {}

    // Get all received tokens
    function receivedTokens() public {}

    // Get all withdrawn tokens
    function withdrawnTokens() public {}

    // Get donation link
    function getDonationLink() public {}
}