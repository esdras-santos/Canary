import 'package:flutter/material.dart';
import 'package:flutter_web3/ethers.dart';

import 'utils/CKBUtils.dart';
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
              inter
                  .erc721(E721)
                  .send(
                      "approve",
                      [
                        "0x34786005489a9BE178Aeb46895Adc800062D143C",
                        nftid,
                      ],
                      TransactionOverride(
                          gasPrice: BigInt.from(6000000)))
                  .then((value) {
                value.wait();
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
                        ],
                        TransactionOverride(gasPrice: BigInt.from(6000000)))
                    .then((value) {
                  value.wait();
                  print(value.hash);
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
              dailyprice = toCKB(value);
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

  String toKAI(String value) {
    var sv = value.split(".");
    if (int.parse(sv[0]) > 0) {
      if (sv[1].length < 18) {
        for (int i = sv[1].length; i <= 18; i++) {
          sv[1] = sv[1] + "0";
        }
      }
      return sv[0] + sv[1];
    } else {
      if (sv[1].length < 18) {
        for (int i = sv[1].length; i <= 18; i++) {
          sv[1] = sv[1] + "0";
        }
      }
      return "${int.parse(sv[1])}";
    }
  }
}
