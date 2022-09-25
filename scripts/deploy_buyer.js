const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();
  
    console.log("Deploying contracts with the account:", deployer.address);
  
    console.log("Account balance:", (await deployer.getBalance()).toString());
  
    const Contract = await ethers.getContractFactory("HTLC_buyer");

    const dest = "0x98aC4b4eB4Ba661da7d3F575E51398498115Acf9";

    const timeLimit = 48;

    const htlc = await Contract.deploy(dest, timeLimit);
  
    console.log("Contract address:", htlc.address);
  }
  
  main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });