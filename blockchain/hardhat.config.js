require("@nomicfoundation/hardhat-toolbox");

import HardhatUserConfig from 'hardhat/config';
import "@nomicfoundation/hardhat-toolbox";
import dotenv from "dotenv";

dotenv.config();

const HardhatUserConfig = {
  solidity: "0.8.19",
  networks: {
    mumbai: {
      url: 'https://rpc-mumbai.maticvigil.com',
      accounts: [process.env.PRIVATE_KEY]
    }
  }
};

export default config;
