import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web3/ethers.dart';
import 'package:nftrenter/screen/utils/nft_metadata.dart';

import '../nft_mockups.dart';
import 'utils/TokenUtils.dart';
import 'utils/interfaces.dart';

class GaveNFTPopup extends StatefulWidget {
  String tag;
  int index;
  Map nft;
  GaveNFTPopup(
      {Key? key, required this.tag, required this.index, required this.nft})
      : super(key: key);

  @override
  State<GaveNFTPopup> createState() => _GaveNFTPopupState();
}

class _GaveNFTPopupState extends State<GaveNFTPopup> {
  Mockups mock = Mockups();
  int rentperiod = 0;
  String rentamount = "0.0";
  Interfaces inter = Interfaces();
  NFTMetadata ni = NFTMetadata();
  Map nftdata = {};

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Hero(
        tag: widget.tag,
        // createRectTween: (begin, end){
        //   return CustomRectTween(begin: begin!, end: end!);
        // },
        child: Material(
          // color: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SingleChildScrollView(
            child: Container(
              height: 600,
              width: 1100,
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 600,
                    width: 700,
                    // alignment: Alignment,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.green,
                          Colors.yellow,
                          Colors.green,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: FutureBuilder<Map>(
                        future: ni.getMetadataFromUrl(widget.nft["uri"]),
                        builder: (context, snapshot) {
                          WidgetsBinding.instance
                              ?.addPostFrameCallback((timeStamp) {
                            setState(() {
                              nftdata = snapshot.data!;
                            });
                          });
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.memory(
                                    snapshot.data!["png"],
                                    width: 650,
                                    height: 550,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 600,
                      width: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: FutureBuilder<Map>(
                          future: mock.royalties(widget.nft["rightid"]),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(widget.nft["name"]),
                                    nftdata["name"] == null ? Container(): Text(
                                      nftdata["name"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          "Confirmed Royalties: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        // this information need to be taken from the network
                                        Text(
                                          EthUtils.formatEther(snapshot.data!["cr"]) + " Matic",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          "Future Royalties: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        // this information need to be taken from the network
                                        Text(
                                          EthUtils.formatEther(snapshot.data!["ur"]) + " Matic",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40),
                                    Container(
                                      height: 55.0,
                                      width: 300,
                                      child: RaisedButton(
                                        onPressed: () async {
                                          var tx = await inter
                                              .canary()
                                              .send("withdrawRoyalties", [
                                            widget.nft["ERC721"],
                                            widget.nft["id"],
                                            snapshot.data!["dl"],
                                            snapshot.data!["roi"],
                                            snapshot.data!["whri"]
                                          ], TransactionOverride(gasPrice: BigInt.from(6000000)));
                                          print(tx.hash);
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        padding: EdgeInsets.all(0.0),
                                        child: Ink(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Colors.green,
                                                  Colors.yellow,
                                                  Colors.green,
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxWidth: 300, minHeight: 20.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Get Confirmed Royalties",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      height: 55.0,
                                      width: 300,
                                      child: RaisedButton(
                                        onPressed: () async {
                                          final tx = await inter.canary().send(
                                              "withdrawNFT", [
                                            widget.nft["ERC721"],
                                            widget.nft["id"]
                                          ], TransactionOverride(gasPrice: BigInt.from(6000000)));
                                          tx.wait();
                                          print(tx.hash);
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        padding: EdgeInsets.all(0.0),
                                        child: Ink(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Colors.green,
                                                  Colors.yellow,
                                                  Colors.green,
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxWidth: 300, minHeight: 20.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Withdraw NFT",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              );
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
