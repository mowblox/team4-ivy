// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Donate {
    // create organization
    address public owner;
    event DonationMade(address donor, uint amount);
    event WithdrawalMade(address indexed recipient, uint amount, uint timestamp);
    
    struct Organization {
        address creator;
        string name;
        string about;
        uint goalAmount;
        uint currentAmount;
        uint createdTimestamp;
    }

    Organization[] public organizations;

    constructor() {
        owner = msg.sender;
    }

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
    function makeDonation(uint organizationIndex) public payable {
        require(msg.value > 0, "Donation amount must be greater than 0");
        require(organizationIndex < organizations.length, "Invalid organization index");
        
        Organization storage org = organizations[organizationIndex];
        require(org.currentAmount + msg.value <= org.goalAmount, "Donation exceeds goal amount");

        org.currentAmount += msg.value;
        emit DonationMade(msg.sender, msg.value);
    
}

    // Track tokens received
    function trackTokensReceived() public {}

    // Withdraw tokens
    function withdrawTokens(uint organizationIndex) public {
        require(organizationIndex < organizations.length, "Invalid organization index");

        Organization storage org = organizations[organizationIndex];
        require(org.creator == msg.sender, "Only the organization creator can withdraw tokens");

        uint amountToWithdraw = org.currentAmount;
        org.currentAmount = 0;

        payable(org.creator).transfer(amountToWithdraw);

        // Emit an event to indicate Ether has been withdrawn
        emit WithdrawalMade(org.creator, amountToWithdraw, block.timestamp);}
        
    // Get all received tokens
    function receivedTokens() public {}

    // Get all withdrawn tokens
    function withdrawnTokens() public {}

}