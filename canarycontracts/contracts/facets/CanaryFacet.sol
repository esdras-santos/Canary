//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import { LibDiamond } from  "../libraries/LibDiamond.sol";

contract CanaryFacet {

    event GetRight(address indexed _erc721, uint256 indexed _nftid, uint256 _period, address indexed _who);
    event DepositedNFT(address indexed _erc721, uint256 indexed _nftid);

    modifier isNFTOwner(address _erc721, uint256 _nftid){
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        require(ds.owner[_erc721][_nftid] == msg.sender);
        _;
    }

    function getRights(address _erc721, uint256 _nftid, uint256 _period) external payable {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        require(_erc721 != address(0),"address is zero");
        require(ds.isAvailable[_erc721][_nftid],"NFT is not available");
        require(ds.maxtime[_erc721][_nftid] >= _period,"period is above the max period");
        require(msg.value >= (ds.dailyPrice[_erc721][_nftid] * _period), "value is less than the required");
        require(ds.maxRightsHolders[_erc721][_nftid] < ds.rightHolders[_erc721][_nftid].length, "limit of right holders reached");
        ds.rightHolders[_erc721][_nftid].push(msg.sender);
        ds.rightsPeriod[_erc721][_nftid][msg.sender] = _period;
        ds.rightsOver[msg.sender].push(bytes32(uint256(uint160(_erc721))));
        ds.rightsOver[msg.sender].push(bytes32(_nftid));
        ds.deadline[_erc721][_nftid][msg.sender] = block.timestamp + (1 days * _period);
        emit GetRight(_erc721, _nftid, _period, msg.sender);
    }

    // need to call approval before calling this function
    function depositNFT(
        address _erc721, 
        uint256 _nftid, 
        uint256 _dailyprice, 
        uint256 _maxperiod,
        uint256 _maxrightbuyers) 
        external 
    {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        require(_erc721 != address(0x00), "collection address is zero");
        ds.availableNFTs.push(bytes32(uint256(uint160(_erc721))));
        ds.availableNFTs.push(bytes32(_nftid));
        ds.properties[msg.sender].push(bytes32(uint256(uint160(_erc721))));
        ds.properties[msg.sender].push(bytes32(_nftid));
        ds.dailyPrice[_erc721][_nftid] = _dailyprice;
        ds.maxtime[_erc721][_nftid] = _maxperiod;
        ds.maxRightsHolders[_erc721][_nftid] = _maxrightbuyers;
        ds.owner[_erc721][_nftid] = msg.sender;
        ds.isAvailable[_erc721][_nftid]  = true;
        IERC721 e721 = IERC721(_erc721);
        e721.transferFrom(msg.sender, address(this), _nftid);
        emit DepositedNFT(_erc721, _nftid);
    }

    function withdrawRoyalties(
        address _erc721, 
        uint256 _nftid, 
        address[] memory _deadlinelist,
        uint256[] memory _roindexes,
        uint256[] memory _whrindexes) 
        external isNFTOwner(_erc721, _nftid)
    {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        uint256 amountToWithdraw = 0;
        
        for(uint256 i; i <= _deadlinelist.length; i++){
            require(ds.deadline[_erc721][_nftid][_deadlinelist[i]] < block.timestamp, "NFT don't surpased the deadline yet");
            require(ds.deadline[_erc721][_nftid][_deadlinelist[i]] > 0, "NFT deadline needs to be above zero");
            bytes32 e721copy = ds.rightsOver[_deadlinelist[i]][_roindexes[i]];
            require(address(uint160(uint256(e721copy))) == _erc721,"wrong index for collection address");
            bytes32 nftidcopy = ds.rightsOver[_deadlinelist[i]][_roindexes[i]+1];
            require(uint256(nftidcopy) == _nftid, "wrong index for NFT id");
            require(ds.rightHolders[_erc721][_nftid][_whrindexes[i]] == _deadlinelist[i],"right holder address and deadline list address is not equal");

            amountToWithdraw += (ds.dailyPrice[_erc721][_nftid] * ds.rightsPeriod[_erc721][_nftid][_deadlinelist[i]]);
            
            ds.rightsOver[_deadlinelist[i]][_roindexes[i]] = ds.rightsOver[_deadlinelist[i]][ds.rightsOver[_deadlinelist[i]].length - 2];
            ds.rightsOver[_deadlinelist[i]][_roindexes[i]+1] = ds.rightsOver[_deadlinelist[i]][ds.rightsOver[_deadlinelist[i]].length - 1];
            ds.rightsOver[_deadlinelist[i]].pop();
            ds.rightsOver[_deadlinelist[i]].pop();
            address ercaux = _erc721;
            uint256 idaux = _nftid;
            ds.rightHolders[ercaux][idaux][_whrindexes[i]] = ds.rightHolders[ercaux][idaux][ds.rightHolders[ercaux][idaux].length -1];
            ds.rightHolders[ercaux][idaux].pop();

            ds.deadline[ercaux][idaux][_deadlinelist[i]] = 0;
            ds.rightsPeriod[ercaux][idaux][_deadlinelist[i]] = 0;

        }
        payable(msg.sender).transfer(amountToWithdraw);
    }

    function withdrawNFT(address _erc721, uint256 _nftid, uint256 _nftIndex) external isNFTOwner(_erc721,_nftid) {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        require(ds.biggerDeadline[_erc721][_nftid] < block.timestamp, "longer NFT deadline should end before withdraw");
        require(ds.isAvailable[_erc721][_nftid] == false, "NFT should be unavailable");
        bytes32 e721copy = ds.properties[msg.sender][_nftIndex]; 
        require(address(uint160(uint256(e721copy))) == _erc721, "wrong index for collection address");
        bytes32 nftidcopy = ds.properties[msg.sender][_nftIndex+1];
        require(uint256(nftidcopy) == _nftid, "wrong index for NFT id");
        ds.properties[msg.sender][_nftIndex] = ds.properties[msg.sender][ds.properties[msg.sender].length - 2];
        ds.properties[msg.sender][_nftIndex+1] = ds.properties[msg.sender][ds.properties[msg.sender].length - 1];
        ds.properties[msg.sender].pop();
        ds.properties[msg.sender].pop();
        ds.dailyPrice[_erc721][_nftid] = 0;
        ds.maxRightsHolders[_erc721][_nftid] = 0;
        ds.maxtime[_erc721][_nftid] = 0;
        ds.biggerDeadline[_erc721][_nftid] = 0;
        ds.owner[_erc721][_nftid] = address(0x00);
        IERC721 e721 = IERC721(_erc721);
        e721.transferFrom(address(this), msg.sender, _nftid);
    }

    function setAvailability(
        address _erc721, 
        uint256 _nftid, 
        bool _available, 
        uint256 _nftindex) 
        external isNFTOwner(_erc721,_nftid) 
    {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        bytes32 e721copy = ds.availableNFTs[_nftindex];
        bytes32 nftidcopy = ds.availableNFTs[_nftindex+1];
        require(address(uint160(uint256(e721copy))) == _erc721, "wrong index for collection address");
        require(uint256(nftidcopy) == _nftid, "wrong index for NFT id");
        if(_available == false){
            ds.availableNFTs[_nftindex] = ds.availableNFTs[ds.availableNFTs.length - 2];
            ds.availableNFTs[_nftindex+1] = ds.availableNFTs[ds.availableNFTs.length - 1];
            ds.availableNFTs.pop();
            ds.availableNFTs.pop();
        } else {
            ds.availableNFTs.push(bytes32(uint256(uint160(_erc721))));
            ds.availableNFTs.push(bytes32(_nftid));
        }
        ds.isAvailable[_erc721][_nftid] = _available;
    }

    function dailyPriceOf(address _erc721, uint256 _nftid) external view returns (uint256) {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        return ds.dailyPrice[_erc721][_nftid];
    }

    function maxRightHoldersOf(address _erc721, uint256 _nftid) external view returns (uint256) {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        return ds.maxRightsHolders[_erc721][_nftid];
    }

    function maxPeriodOf(address _erc721, uint256 _nftid) external view returns (uint256) {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        return ds.maxtime[_erc721][_nftid];
    }

    function biggerDeadlineOf(address _erc721, uint256 _nftid) external view returns (uint256) {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        return ds.biggerDeadline[_erc721][_nftid];
    }

    function rightsPeriodOf(address _erc721, uint256 _nftid, address _holder) external view returns (uint256){
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        return ds.rightsPeriod[_erc721][_nftid][_holder];
    }

    function rightsOf(address _rightsHolder) external view returns (bytes32[] memory) {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        return ds.rightsOver[_rightsHolder];
    }

    function propertiesOf(address _owner) external view returns (bytes32[] memory) {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        return ds.properties[_owner];
    }

    function getAvailableNFTs() external view returns (bytes32[] memory) {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        return ds.availableNFTs;
    }

    function rightHoldersOf(address _erc721, uint256 _nftid) external view returns (address[] memory){
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        return ds.rightHolders[_erc721][_nftid];
    }

    function holderDeadline(address _erc721, uint256 _nftid, address _holder) external view returns (uint256){
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        return ds.deadline[_erc721][_nftid][_holder];
    }

    function ownerOf(address _erc721, uint256 _nftid) external view returns (address){
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        return ds.owner[_erc721][_nftid];
    }

    function availabilityOf(address _erc721, uint256 _nftid) external view returns (bool){
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        return ds.isAvailable[_erc721][_nftid];
    }
}
