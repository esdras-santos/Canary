const Web3 = require('web3');

/**
 * BEFORE USING THIS SCRIPT MAKE SURE TO REPLACE:
 * - <YOUR_CONTRACT_ABI>
 * - <YOUR_CONTRACT_ADDRESS>
 * - CONTRACT_ADDRESS variable value
 * - YOUR_READ_FUNCTION_NAME method name
 * - YOUR_WRITE_FUNCTION_NAME method name
 */

const cut = [
    {
        facetAddress: "0xC38eE280928095597E57758Db1EE02e3b1f0a1Aa", 
        action: 0, 
        functionSelectors: ["0x1d3ae1b2", "0xd21d34f4", "0xc81318c8", "0x3a0196af", "0xe0beb8c0", "0x166bab95", "0x0f265bdd", "0xba987777", "0x3e753d2b", "0x26e07ef6", "0xef3776d7", "0x9a9a4f46", "0xc7c314e0", "0x32702c95", "0xe18138d7", "0x5e4df22c", "0x6352211e", "0x9fe8b786", "0xe6be6db1", "0x794b2a07"]}]

const compiledContract = require('../artifacts/contracts/facets/CanaryFacet.sol/CanaryFacet.json')
const ACCOUNT_PRIVATE_KEY = 'ab3e55fa83f6d5831762643152831eb60444bb05cb1d5e724da41bb5d3e10a4c'; // Replace this with your Ethereum private key with funds on Layer 2.
const CONTRACT_ABI = compiledContract.abi; // this should be an Array []
const CONTRACT_ADDRESS = '0x34786005489a9BE178Aeb46895Adc800062D143C';

const web3 = new Web3('https://godwoken-testnet-web3-v1-rpc.ckbapp.dev');

const account = web3.eth.accounts.wallet.add(ACCOUNT_PRIVATE_KEY);

async function readCall() {
    const contract = new web3.eth.Contract(CONTRACT_ABI, CONTRACT_ADDRESS);

    const callResult = await contract.methods.propertiesOf(account.address).call({
        from: account.address
    });

    console.log(`Read call result: ${callResult}`);
}

// async function writeCall() {
//     const contract = new web3.eth.Contract(CONTRACT_ABI, CONTRACT_ADDRESS);

//     const tx = contract.methods.depositNFT("0x16A2dB28575b5C9973a565AB44A722c44F79B717", "1", "300000", "30", "10").send(
//         {
//             from: account.address,
//             gas: 6000000,
           
//         }
//     );

//     tx.on('transactionHash', hash => console.log(`Write call transaction hash: ${hash}`));

//     const receipt = await tx;

//     console.log('Write call transaction receipt: ', receipt);
// }

(async () => {
    const balance = BigInt(await web3.eth.getBalance(account.address));

    if (balance === 0n) {
        console.log(`Insufficient balance. Can't issue a smart contract call. Please deposit funds to your Ethereum address: ${account.address}`);
        return;
    }

    console.log('Calling contract...');

    // Check smart contract state before state change.
    await readCall();

    // Change smart contract state.
    // await writeCall();

    // Check smart contract state after state change.
    // await readCall();
})();