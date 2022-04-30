import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nftrenter/screen/utils/nft_metadata.dart';

import '../nft_mockups.dart';

class ShowNFTPopup extends StatefulWidget {
  String tag;
  int index;
  Map nft;
  ShowNFTPopup(
      {Key? key, required this.tag, required this.index, required this.nft})
      : super(key: key);

  @override
  State<ShowNFTPopup> createState() => _ShowNFTPopupState();
}

class _ShowNFTPopupState extends State<ShowNFTPopup> {
  Mockups mock = Mockups();
  int rentperiod = 0;
  String rentamount = "0.0";
  NFTMetadata ni = NFTMetadata();
  Map nftdata = {};

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    width: 800,
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
                          if (snapshot.hasData) {
                            WidgetsBinding.instance
                                ?.addPostFrameCallback((timeStamp) {
                              setState(() {
                                nftdata = snapshot.data!;
                              });
                            });
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.memory(
                                    snapshot.data!["png"],
                                    width: 750,
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
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text("Owner: "),
                                Text(widget.nft["owner"].substring(0, 6) +
                                    "..." +
                                    widget.nft["owner"].substring(37, 42)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text("ERC721: "),
                                Text(widget.nft["ERC721"].substring(0, 6) +
                                    "..." +
                                    widget.nft["ERC721"].substring(37, 42)),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(widget.nft["name"]),
                            Text(
                              nftdata["name"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Text(mock.nfts[widget.index]["description"]),
                          ],
                        ),
                      ),
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
