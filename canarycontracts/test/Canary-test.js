const {assert, expect} = require('chai')
const { deployDiamond } = require('../scripts/deploy')
const { deployCollection } = require('../scripts/deployCollection')

describe('Canary protocol test', async function(){
    let diamondAddress
    let collectionAddress
    let canaryFacet
    let collection
    let owner

    before(async function(){
        diamondAddress = await deployDiamond()
        canaryFacet = await ethers.getContractAt('CanaryFacet', diamondAddress)
        collectionAddress = await deployCollection()
        collection = await ethers.getContractAt('Dungeon', collectionAddress)
        let accounts = await ethers.getSigners()
        owner = accounts[0]
        let tx
        
        tx = await collection.createCollectible("ipfs://bafkreihxwh3yekjq2bakdje4okxpdlsdqlua4jur4iogv2kbyzr6lnawkm")
        await tx.wait()

        tx = await collection.createCollectible("ipfs://bafkreihps5wq65dnaqxs4tgefoqy3qceqm7yl6x3cc7m4ztdqvrflskg2e")
        await tx.wait()

        tx = await collection.createCollectible("ipfs://bafkreiagwvhiyoo3hmoglboczeexmphmnrelrh4dvbfh6agjm3oqewfoya")
        await tx.wait()

        tx = await collection.approve(diamondAddress, '0')
        await tx.wait()
        tx = await collection.approve(diamondAddress, '1')
        await tx.wait()
        tx = await collection.approve(diamondAddress, '2')
        await tx.wait()

        tx = await canaryFacet.depositNFT(collectionAddress, '0', '3000000000000000', '30', '10')
        await tx.wait()
        tx = await canaryFacet.depositNFT(collectionAddress, '1', '9000000000000000', '30', '10')
        await tx.wait()
        tx = await canaryFacet.depositNFT(collectionAddress, '2', '20000000000000000', '30', '1')
        await tx.wait()
    })

    it('should test the deposit of NFTs into the protocol', async function(){
        let rights
        let NFTOwner
        rights = await canaryFacet.getAvailableNFTs()
        assert.equal(rights.length, 3)
        NFTOwner = await canaryFacet.ownerOf(rights[0])        
        assert.equal(NFTOwner, owner.address)
        NFTOwner = await canaryFacet.ownerOf(rights[1])        
        assert.equal(NFTOwner, owner.address)
        NFTOwner = await canaryFacet.ownerOf(rights[2])        
        assert.equal(NFTOwner, owner.address)

        let availableRights
        availableRights = await canaryFacet.availableRightsOf(rights[0])
        assert.equal(availableRights, 10)
        availableRights = await canaryFacet.availableRightsOf(rights[1])
        assert.equal(availableRights, 10)
        availableRights = await canaryFacet.availableRightsOf(rights[2])
        assert.equal(availableRights, 1)

        let rightsPrice
        rightsPrice = await canaryFacet.dailyPriceOf(rights[0])
        assert.equal(rightsPrice, '3000000000000000')
        rightsPrice = await canaryFacet.dailyPriceOf(rights[1])
        assert.equal(rightsPrice, '9000000000000000')
        rightsPrice = await canaryFacet.dailyPriceOf(rights[2])
        assert.equal(rightsPrice, '20000000000000000')     
        
        let maxPeriod
        maxPeriod = await canaryFacet.maxPeriodOf(rights[0])
        assert.equal(maxPeriod, 30)
        maxPeriod = await canaryFacet.maxPeriodOf(rights[1])
        assert.equal(maxPeriod, 30)
        maxPeriod = await canaryFacet.maxPeriodOf(rights[2])
        assert.equal(maxPeriod, 30)

        let origin = []
        origin = await canaryFacet.originOf(rights[0])
        assert.equal('0x'+origin[0].substring(26), collectionAddress.toLowerCase())
        assert.equal(Number(origin[1]), 0)
        origin = await canaryFacet.originOf(rights[1])
        assert.equal('0x'+origin[0].substring(26), collectionAddress.toLowerCase())
        assert.equal(Number(origin[1]), 1)
        origin = await canaryFacet.originOf(rights[2])
        assert.equal('0x'+origin[0].substring(26), collectionAddress.toLowerCase())
        assert.equal(Number(origin[1]), 2)
    })

    it('should test the getRights method', async function(){
        let rights
        let tx
        let dailyPrice
        rights = await canaryFacet.getAvailableNFTs()
        await expect(
            canaryFacet.getRights('00000000000000000000000000000000000000000000000000000000000000000000', '10', {value: '0'})
        ).to.be.revertedWith('NFT is not available')
        dailyPrice = await canaryFacet.dailyPriceOf(rights[0])
        await expect(
            canaryFacet.getRights(rights[0], '31', {value: `${dailyPrice*31}`})
        ).to.be.revertedWith('period is above the max period')
        await expect(
            canaryFacet.getRights(rights[0], '10', {value: `${dailyPrice*9}`})
        ).to.be.revertedWith('value is less than the required')

        dailyPrice = await canaryFacet.dailyPriceOf(rights[2])
        tx = await canaryFacet.getRights(rights[2], '30', {value: `${Number(dailyPrice)*30}`})
        await tx.wait()

        // await expect(
        //     canaryFacet.getRights(rights[2], '30', {value: `${Number(dailyPrice)*30}`})
        // ).to.be.revertedWith('limit of right holders reached')
    })
})