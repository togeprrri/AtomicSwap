const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();
  
    console.log("Deploying contracts with the account:", deployer.address);
  
    console.log("Account balance:", (await deployer.getBalance()).toString());
  
    const Contract = await ethers.getContractFactory("HTLC");

    const hash = "383ac258155e8525e1d8cae9591f79598d0651cfad036f93e9947e6124071eb1";

    const dest1 = "0x1b675750AbedBD8EaEd0A7B5364da87Fd069E2E9";
    const dest2 = "0x98aC4b4eB4Ba661da7d3F575E51398498115Acf9";

    const timeLimit = 48;

    const dist = await Contract.deploy(hash, dest2, timeLimit);
  
    console.log("Contract address:", dist.address);
  }
  
  main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });