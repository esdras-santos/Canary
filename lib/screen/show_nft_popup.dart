import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../nft_mockups.dart';

class ShowNFTPopup extends StatefulWidget {
  String tag;
  int index;
  ShowNFTPopup({Key? key, required this.tag, required this.index})
      : super(key: key);

  @override
  State<ShowNFTPopup> createState() => _ShowNFTPopupState();
}

class _ShowNFTPopupState extends State<ShowNFTPopup> {
  Mockups mock = Mockups();
  int rentperiod = 0;
  String rentamount = "0.0";
  
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
                                Text(mock.nfts[widget.index]["lender"].substring(0,6)+"..."+mock.nfts[widget.index]["lender"].substring(37,42)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text("ERC721: "),
                                Text(mock.nfts[widget.index]["ERC721"].substring(0,6)+"..."+mock.nfts[widget.index]["ERC721"].substring(37,42)),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(mock.nfts[widget.index]["collectionname"]),
                            Text(
                              mock.nfts[widget.index]["id"],
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
                            Text(mock.nfts[widget.index]["description"]),
                            
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

