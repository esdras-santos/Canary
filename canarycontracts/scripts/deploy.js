const { existsSync } = require('fs');
const Web3 = require('web3');




let compiledContractArtifact = null;
const filenames = [`../artifacts/contracts/facets/CanaryFacet.sol/CanaryFacet.json`, `./Fruits`];
for(const filename of filenames)
{
    if(existsSync(filename))
    {
        console.log(`Found file: ${filename}`);
        compiledContractArtifact = require(filename);
        break;
    }
    else
        console.log(`Checking for file: ${filename}`);
}


const DEPLOYER_PRIVATE_KEY = 'ab3e55fa83f6d5831762643152831eb60444bb05cb1d5e724da41bb5d3e10a4c'; // Replace this with your Ethereum private key with funds on Layer 2.

const web3 = new Web3('https://godwoken-testnet-web3-v1-rpc.ckbapp.dev');

const deployerAccount = web3.eth.accounts.wallet.add(DEPLOYER_PRIVATE_KEY);

(async () => {
    const balance = BigInt(await web3.eth.getBalance(deployerAccount.address));

    if (balance === 0n) {
        console.log(`Insufficient balance. Can't deploy contract. Please deposit funds to your Ethereum address: ${deployerAccount.address}`);
        return;
    }

    console.log(`Deploying contract...`);

    const deployTx = new web3.eth.Contract(compiledContractArtifact.abi).deploy({
        data: getBytecodeFromArtifact(compiledContractArtifact),
        arguments: []
    }).send({
        from: deployerAccount.address,
        gas: 6000000,
    });

    deployTx.on('transactionHash', hash => console.log(`Transaction hash: ${hash}`));

    const contract = await deployTx;

    console.log(`Deployed contract address: ${contract.options.address}`);
})();

function getBytecodeFromArtifact(contractArtifact) {
    return contractArtifact.bytecode || contractArtifact.data?.bytecode?.object
}