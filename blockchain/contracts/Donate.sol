// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Donate {
    // create organization

    event makeDonationEvent(
        string _name,
        string _about,
        uint256 _goalAmount,
        uint256 _currentAmount,
        uint256 currentTimeStamp
    );

     address public owner;
    uint256 public targetAmount;
    uint256 private totalDonationsAmount;
    uint64 private organizationCount;

    constructor(uint _targetAmount) {
        owner = msg.sender;
        targetAmount = _targetAmount;
    }

    struct Organization {
        string name;
        string about;
        address wallet;  // Wallet address for the organization
        uint goalAmount;
        uint currentAmount;
        uint createdTimestamp;
    }

    Organization[] public organizations;
 
    function createOrganization(
        string memory _name,
        string memory _about,
        uint _goalAmount
    ) public {
        require(organizationCount < organizations.length, "Reached maximum organizations");

        organizations.push(Organization({
            name: _name,
            about: _about,
            wallet: msg.sender, // Use msg.sender as the wallet address
            goalAmount: _goalAmount,
            currentAmount: 0,
            createdTimestamp: block.timestamp
        }));

        organizationCount++; // Increase the organization count
    }

    // get organisations count
    function getOrganiationsCount() public view returns (uint) {
        return organizationCount;
    }

    // get single organisation
    function getOrganization(
        uint _index
    ) public view returns (Organization memory) {
        require(_index < organizations.length, "Invalid index");
        Organization memory org = organizations[_index];
        return (org);
    }

    // Get all organisations
    function getAllOrganizations() public view returns (Organization[] memory) {
        return organizations;
    }

    // Send tokens
    function makeDonation(uint _amount, uint256 _index) public payable {
        // find the organization you want to donate to ..
        require(_index < organizations.length, "Invalid index");
        Organization storage org = organizations[_index];

        require(
            msg.value == _amount,
            "Amount sent doesn't match donation amount"
        );

        org.currentAmount += _amount;
        totalDonationsAmount += _amount;
        payable(address(this)).transfer(_amount);
        emit makeDonationEvent(org.name, org.about, org.goalAmount, org.currentAmount, org.createdTimestamp);
    }

    // Track tokens received
    function trackTokensReceived(uint _index) public view returns(uint256 currentAmount) {
        require(_index < organizations.length, "Invalid index");
        Organization memory org = organizations[_index];
        return org.currentAmount;

        

    }

    // Withdraw tokens
    
    function withdrawTokens() public {

    }

    // Get all received tokens
    function receivedTokens() public view returns(uint256 _totalDonationsAmount) {

        return totalDonationsAmount;
        

    }

    // Get all withdrawn tokens
    function withdrawnTokensFromContract() public {

    }

function toAsciiString(address x) internal pure returns (string memory) {
    bytes memory s = new bytes(40);
    for (uint i = 0; i < 20; i++) {
        bytes1 b = bytes1(uint8(uint(uint160(x)) / (2**(8*(19 - i)))));
        bytes1 hi = bytes1(uint8(b) / 16);
        bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
        s[2*i] = char(hi);
        s[2*i+1] = char(lo);            
    }
    return string(s);
}

function char(bytes1 b) internal pure returns (bytes1 c) {
    if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
    else return bytes1(uint8(b) + 0x57);
}

    // Get donation link
    function getDonationLink(uint _index) public view returns (string memory) {
        require(_index < organizations.length, "Invalid index");
   

        string  memory addressInString = toAsciiString(msg.sender);

        // Create a donation link format: "https://example.com/donate/<organization_address>"
        string memory donationLink = string(abi.encodePacked("https://example.com/donate/", addressInString));

        return donationLink;
    }
}
