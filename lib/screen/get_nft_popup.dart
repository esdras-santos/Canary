import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../nft_mockups.dart';

class GetNFTPopup extends StatefulWidget {
  String tag;
  int index;
  GetNFTPopup({Key? key, required this.tag, required this.index})
      : super(key: key);

  @override
  State<GetNFTPopup> createState() => _RentNFTPopupState();
}

class _RentNFTPopupState extends State<GetNFTPopup> {
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
                                Text(mock.nfts[widget.index]["lender"]),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text("ERC721: "),
                                Text(mock.nfts[widget.index]["ERC721"]),
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
                            Container(
                              padding: const EdgeInsets.only(left: 8.0),
                              width: 360,
                              child: TextFormField(
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                // keyboardType: TextInputType.number,
                                inputFormatters: [
                                  CurrencyTextInputFormatter(
                                      maxInputValue: double.parse(
                                          mock.nfts[widget.index]
                                              ["maxrentperiod"])),
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
                                    var aux = "${rentperiod * double.parse(mock.nfts[widget.index]["price"])}";
                                    if(aux.split(".")[1].length > 8){
                                      rentamount = (rentperiod * double.parse(mock.nfts[widget.index]["price"])).toStringAsFixed(8);
                                    } else {
                                      rentamount = "${rentperiod * double.parse(mock.nfts[widget.index]["price"])}";
                                    }
                                    
                                  });
                                },
                              ),
                            ),
                            Text(
                                "Max of ${mock.nfts[widget.index]["maxrentperiod"]} days"),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text("Daily Price:     ", style: TextStyle(fontSize: 20)),
                                Text(mock.nfts[widget.index]["price"] + " CKB", style: TextStyle(fontSize: 20)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text("Rent Amount: ", style: TextStyle(fontSize: 20)),
                                Text(rentamount+" CKB", style: TextStyle(fontSize: 20)),
                              ],
                            ),
                            SizedBox(height: 40),
                            Container(
                              height: 55.0,
                              width: size.width * 0.3,
                              child: RaisedButton(
                                onPressed: () {
                                  
                                },
                                shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
                                    constraints:
                                        BoxConstraints(maxWidth: size.width * 0.4, minHeight: 20.0),
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
