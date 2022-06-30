async function deployCanaryToken(diamondAddress) {
    const accounts = await ethers.getSigners()
    const contractOwner = accounts[0]

    const Dungeon = await ethers.getContractFactory('CAT')
    const dungeon = await Dungeon.deploy(diamondAddress)
    await dungeon.deployed()
    
    return dungeon.address
}

exports.deployCanaryToken = deployCanaryToken