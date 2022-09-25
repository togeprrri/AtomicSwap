require("@nomicfoundation/hardhat-toolbox");

const {ALCHEMY_API_KEY, GOERLI_PRIVATE_KEY, INFURA_API_KEY, ROPSTEN_PRIVATE_KEY} = require("./keys.js");

console.log(GOERLI_PRIVATE_KEY);

module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: `https://eth-goerli.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
      accounts: [GOERLI_PRIVATE_KEY]
    },
    ropset: {
      url: `https://ropsten.infura.io/v3/${INFURA_API_KEY}`,
      accounts: [ROPSTEN_PRIVATE_KEY]
    }
  }
};
