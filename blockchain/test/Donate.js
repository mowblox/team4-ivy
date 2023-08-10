const {
    time,
    loadFixture,
  } = require("@nomicfoundation/hardhat-toolbox/network-helpers");
  const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
  const { expect } = require("chai");

describe("Donate Contract", function () {
  let Donate;
  let donate;
  let owner;

  beforeEach(async function () {
    [owner] = await ethers.getSigners();
    Donate = await ethers.getContractFactory("Donate");
    donate = await Donate.deploy(ethers.parseEther("1000")); // Deploy with a targetAmount of 1000 ETH in wei
    // await donate.deployed();

    // const lock = await Lock.deploy(unlockTime, { value: lockedAmount });

  });

  it("should create an organization", async function () {
    const orgName = "Example Organization";
    const orgAbout = "This is an example organization";
    const orgGoalAmount = ethers.parseEther("100"); // 100 ETH in wei

    await donate.createOrganization(orgName, orgAbout, orgGoalAmount);

    const orgCount = await donate.getOrganiationsCount();
    expect(orgCount).to.equal(1);

    const org = await donate.getOrganization(0);
    expect(org.creator).to.equal(owner.address);
    expect(org.name).to.equal(orgName);
    expect(org.about).to.equal(orgAbout);
    expect(org.goalAmount).to.equal(orgGoalAmount);
    expect(org.currentAmount).to.equal(0); // Initial currentAmount should be zero
  });

  // Add more test cases for other functions
});
