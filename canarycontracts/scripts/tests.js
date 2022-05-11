const { ethers } = require("hardhat");

const compiledContract = require('../artifacts/contracts/testcollection/Fruits.sol/Fruits.json')
const tokenAddress = "0xffbaFaFFbd68F00CE7b33A04324aA148B1dBDb28";
async function get() {
    const token = await ethers.getContractAt(compiledContract.abi, tokenAddress);

    const teamAddress = "0x0000000";
    const grantAmount = "10";
    const transferCalldata = token.interface.encodeFunctionData("tokenURI", ["10"]);
    console.log(transferCalldata)
}

get()
