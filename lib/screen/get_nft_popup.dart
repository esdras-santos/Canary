import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:nftrenter/screen/utils/canary_abi.dart';
import 'package:nftrenter/screen/utils/metamask.dart';
import 'package:nftrenter/screen/utils/nft_image.dart';

import '../nft_mockups.dart';
import 'utils/interfaces.dart';

class GetNFTPopup extends StatefulWidget {
  String tag;
  int index;
  Map nft;
  GetNFTPopup({Key? key, required this.tag, required this.index, required this.nft})
      : super(key: key);

  @override
  State<GetNFTPopup> createState() => _RentNFTPopupState();
}

class _RentNFTPopupState extends State<GetNFTPopup> {
  Mockups mock = Mockups();
  int rentperiod = 0;
  String rentamount = "0.0";
  CanaryAbi ca = CanaryAbi();
  MetaMaskProvider mm = MetaMaskProvider();
  Interfaces inter = Interfaces();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    NFTImage ni = NFTImage();
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
                    width: 550,
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
                      child:FutureBuilder<Map>(
                        future: ni.getImageFromToken(widget.nft["ERC721"], widget.nft["id"]),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.memory(
                                    snapshot.data!["png"],
                                    width: 500,
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
                      )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 600,
                      width: 550,
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
                                Text(widget.nft["owner"]),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text("ERC721: "),
                                Text(widget.nft["ERC721"]),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(widget.nft["name"]),
                            Text(
                              widget.nft["id"],
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
                            Container(
                              padding: const EdgeInsets.only(left: 8.0),
                              width: 360,
                              child: TextFormField(
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  CurrencyTextInputFormatter(
                                      maxInputValue: double.parse(
                                          widget.nft["maxperiod"])),
                                ],
                                cursorColor: Colors.green,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: Colors.yellow),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: Colors.green),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: "enter the Rent Period in days",
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    print(value);
                                    rentperiod = int.parse(value);
                                    print(rentperiod);
                                    var aux =
                                        "${rentperiod * double.parse(widget.nft["dailyprice"])}";
                                    if (aux.split(".")[1].length > 18) {
                                      rentamount = (rentperiod *
                                              double.parse(widget.nft["dailyprice"]))
                                          .toStringAsFixed(18);
                                    } else {
                                      rentamount =
                                          "${rentperiod * double.parse(widget.nft["dailyprice"])}";
                                    }
                                  });
                                },
                              ),
                            ),
                            Text(
                                "Max of ${widget.nft["maxperiod"]} days"),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text("Daily Price:     ",
                                    style: TextStyle(fontSize: 20)),
                                Text(widget.nft["dailyprice"] + " KAI",
                                    style: TextStyle(fontSize: 20)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text("Right total price: ",
                                    style: TextStyle(fontSize: 20)),
                                Text(rentamount + " KAI",
                                    style: TextStyle(fontSize: 20)),
                              ],
                            ),
                            SizedBox(height: 40),
                            Container(
                              height: 55.0,
                              width: size.width * 0.3,
                              child: RaisedButton(
                                onPressed: () async {
                                  final tx = await inter.canary().send(
                                      "getRights",
                                      [
                                        widget.nft["ERC721"],
                                        widget.nft["id"],
                                        rentperiod
                                      ],
                                      TransactionOverride(
                                          value: BigInt.from(
                                              num.parse(rentamount))));
                                  final receipt = tx.wait();
                                  print(tx.hash);
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
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: size.width * 0.4,
                                        minHeight: 20.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Get Rights Now",
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

class CurrencyTextInputFormatter extends TextInputFormatter {
  final double maxInputValue;

  CurrencyTextInputFormatter({required this.maxInputValue});
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regEx = RegExp(r'^\d*\.?\d*');
    String newString = regEx.stringMatch(newValue.text) ?? '';

    if (maxInputValue != null) {
      if (double.tryParse(newValue.text) == null) {
        return TextEditingValue(
          text: newString,
          selection: newValue.selection,
        );
      }
      if (double.tryParse(newValue.text)! > maxInputValue) {
        newString = maxInputValue.toString();
      }
    }
    return TextEditingValue(text: newString, selection: newValue.selection);
  }
}
