const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();
  
    console.log("Deploying contracts with the account:", deployer.address);
  
    console.log("Account balance:", (await deployer.getBalance()).toString());
  
    const Contract = await ethers.getContractFactory("HTLC_seller");

    const hash = "Some random phrase";

    const dest = "0x1b675750AbedBD8EaEd0A7B5364da87Fd069E2E9";

    const timeLimit = 48;

    const htlc = await Contract.deploy(hash, dest, timeLimit);
  
    console.log("Contract address:", htlc.address);
  }
  
  main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });