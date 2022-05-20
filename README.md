# Canary

## Problem 

Imagine you are a singer and you have turned your songs into NFT and you want to sell the copyrights of that song or you are a game designer and in your game the items are NFTs and you want the players to be able to rent the rights to use that item to another player or you have that one piece of NFT art that everybody wants to use but nobody wants to pay the full price for. It would be really nice to make a passive income with that right.

## Solution

Canary is a rights protocol, with canary you can sell the rights to use your NFT to other people just by setting a small daily fee, max number of right hoders and max holding time. "But why would anyone want to buy rights to an NFT?" imagine you are a game developer and the items in that game are NFTs, it would be great if players could sell the rights of their items to other players temporarily or you want to use that cool design in your profile picture on social networks, so instead of paying full price for the NFT, why not just pay a small amount for temporary rights? this protocol could also have a big impact on the music copyright industry and many other applications. "but what happens to the owner of the NFT?" The owner of the NFT will receive the daily rate he has set, i.e. the owner of the NFT will earn from the daily rates and from the appreciation of his item because the more an item sells, the more it will be desired by other collectors. The NFT owner can also define a total number of rights holders and thus create scarcity for the rights to his NFT and of course we will support a parallel rights market where rights holders will be able to sell their rights to other collectors. that way the NFT owners will promote our platform for free because they will earn from the valuation and royalty fees on their NFT.


## How it works?

### The NFT Owner: 
Deposits his Token in the Canary protocol defining the daily price of the right on that NFT, the maximum amount that any holder can hold an NFT right and the maximum number of holders that the NFT can have (to create scarcity).

### Canary Protcol:
Hold the NFT and generate an amount of rights token based on the maximum number of holders that the NFT can have, selling each rights token with a value based on the daily price that the NFT owner has set and the amount of days the right holder has set (Cannot exceed the maximum number of days that the NFT owner has set).

### Right Holder:
Has a rights token that can be used as a proof that he has the right to use the data of that NFT for a certain period of time, for that he needs to define the number of days he wants to use the rights token and pay the respective fee.

# Canary Governance Protocol
Canary Governance Protocol is an incentive based protocol in which all those eligible to vote have equal voting power thus preventing only those with more resources from centralizing power within the governance. "But if everyone has the same voting power why would I buy more governance tokens?", because your reward if you make a good decision is based on your voting power. "But who decides what is a good decision?", the market.

## How Canary Governance Protocol Works?

### Proposal Creation
When a proposal is created, the current value of the governance token is stored (the current value is taken from a Oracles network). The voting period lasts for 1 week.

### Proposal Execution
When the proposal is approved there is a delay of 1 week to see the response of the market and only after this period can be executed, the value of the token is checked again, if the governance token has appreciated in value (current value higher than the value at the time the proposal was created) then the decision is considered a good decision and all those who voted in favor get a part of the treasury as a reward for the good decision, otherwise all those who voted against receive part of the treasury as a reward. After proposal execution there is a delay of 2 weeks, it means that only one proposal can be made per month.

### Reward
the reward is based on your voting power and is calculated as follows:
```solidity
uint256 percent = yourVotingPower * 100 / totalPower;
uint256 reward = (treasury * 70 / 100) * percent / 100;
```
where `totalPower` is the sum of voters that vote for the better decision. This means that the greater your voting power, the greater your reward if you make the decision that most pleases the market.

## Run Project
You can run the project just by clicking in the public link [HERE](https://esdras-santos.github.io/CanaryWebPage/#/) or

1. [Install flutter](https://docs.flutter.dev/get-started/install)

2. Clone this repositore

```shell
git clone https://github.com/esdras-santos/Canary
```

3. Inside the repositore type run: 
```shell
flutter run --release
```

## Canary addresses

### Main address
Diamond Address: [0xF1f2ba31c44bECa971600451ceD0090B11382441](https://mumbai.polygonscan.com/address/0xF1f2ba31c44bECa971600451ceD0090B11382441) 

### Facet addresses
DiamondCut address: [0x9f1303Ca0043875ceb88618f45C6502d471db28D](https://mumbai.polygonscan.com/address/0x9f1303Ca0043875ceb88618f45C6502d471db28D)

DiamondInit address: [0xD71Ff3CBD84888bA5053636570Fd2e8DFC72A36b](https://mumbai.polygonscan.com/address/0xD71Ff3CBD84888bA5053636570Fd2e8DFC72A36b)

Diamond Loupe address: [0x9D4b3A071E7d1A2d59C98A0c93e4BD12E078a8c4](https://mumbai.polygonscan.com/address/0x9D4b3A071E7d1A2d59C98A0c93e4BD12E078a8c4)

Diamond ownership address: [0xb4E366484217C69220a21A8aDF3152b5aCD0F049](https://mumbai.polygonscan.com/address/0xb4E366484217C69220a21A8aDF3152b5aCD0F049)

Canary address: [0x91Faf1dDb5F533beC4A98388057a01e309d635ad](https://mumbai.polygonscan.com/address/0x91Faf1dDb5F533beC4A98388057a01e309d635ad)

treasury address: [0xDC2e7b8AabF9aDB1233771964995310b920A2ec2](https://mumbai.polygonscan.com/address/0xDC2e7b8AabF9aDB1233771964995310b920A2ec2)

## Canary Governance Addresses
Governance Token (CAT) address: [0x9B006894E41541d0e699ceeDF179B14598dbdbD0](https://mumbai.polygonscan.com/address/0x9B006894E41541d0e699ceeDF179B14598dbdbD0)

TimeLock address: [0x1232754302B691cE63D2439d2Af18f7d94Dfb604](https://mumbai.polygonscan.com/address/0x1232754302B691cE63D2439d2Af18f7d94Dfb604)

Governor address: [0xC4f2aAD729960ce8457B6EFb902FC751A3cB5aC1](https://mumbai.polygonscan.com/address/0xC4f2aAD729960ce8457B6EFb902FC751A3cB5aC1)

## Test collection address
Fruit Collection address: [0x2afa0540bA5893A36D45e03725B16c11328e2C8e](https://mumbai.polygonscan.com/address/0x2afa0540bA5893A36D45e03725B16c11328e2C8e)

## Future Roadmap
in the second stage of the Canary when the price of our governance token (CAT) is registered in the price feed we intend to pass the ownership of the Canary protocol to our governance protocol, our governance protocol is an incentive based protocol in which all those eligible to vote have equal voting power thus preventing only those with more resources from centralizing power within the governance. "But if everyone has the same voting power why would I buy more governance tokens?", our incentive system will benefit you if you have more tokens. More details about our protocol read our readme on our github repository.
