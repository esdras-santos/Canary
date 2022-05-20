import 'package:flutter/material.dart';
import 'package:flutter_web3/ethers.dart';
import 'package:nftrenter/screen/utils/metamask.dart';

import 'utils/TokenUtils.dart';
import 'utils/interfaces.dart';

class GiveRights extends StatefulWidget {
  const GiveRights({Key? key}) : super(key: key);

  @override
  State<GiveRights> createState() => _GiveRightsState();
}

class _GiveRightsState extends State<GiveRights> {
  String E721 = "";
  String nftid = "";
  String dailyprice = "";
  String mp = "";
  String mh = "";
  Interfaces inter = Interfaces();
  MetaMaskProvider mm = MetaMaskProvider();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ERC721 address: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            textField("address"),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "NFT ID:        ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            textField("id")
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Daily Price:  ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            textField("dp")
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Max Period (in days):  ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            textField("mp")
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Max Right Holders:  ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            textField("mh")
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          height: 55.0,
          width: 300,
          child: RaisedButton(
            onPressed: () async {
              print(nftid);
              print(E721);
              var owner =
                  await inter.erc721(E721).call<String>("ownerOf", ["0"]);
              print(owner);
              inter.erc721(E721).send(
                "approve",
                [
                  "0xF1f2ba31c44bECa971600451ceD0090B11382441",
                  nftid,
                ],
              ).then((value) {
                value.wait().then((value) {
                  inter
                    .canary()
                    .send(
                        "depositNFT",
                        [
                          E721,
                          nftid,
                          dailyprice,
                          mp,
                          mh,
                        ],)
                    .then((value) {
                  value.wait();
                  print(value.hash);
                  });
                });
                
              });
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
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
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                constraints: BoxConstraints(maxWidth: 300, minHeight: 20.0),
                alignment: Alignment.center,
                child: Text(
                  "Give Rights",
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
    );
  }

  Widget textField(String field) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0),
      width: 360,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
          border: Border.all(color: Colors.black)),
      child: TextFormField(
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        keyboardType: field == "id" || field == "mp"
            ? TextInputType.number
            : TextInputType.text,
        cursorColor: Colors.green,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        onChanged: (value) {
          setState(() {
            if (field == "address") {
              E721 = value;
            } else if (field == "id") {
              nftid = value;
            } else if (field == "dp") {
              dailyprice = toToken(value);
            } else if (field == "mp") {
              mp = value;
            } else if (field == "mh") {
              mh = value;
            }
          });
        },
      ),
    );
  }
}
