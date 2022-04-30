import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nftrenter/screen/gave_rights.dart';
import 'package:nftrenter/screen/get_rights.dart';
import 'package:nftrenter/screen/give_rights.dart';
import 'package:nftrenter/screen/have_rights.dart';
import 'package:nftrenter/screen/utils/metamask.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget form = GetRights();
  String formstate = "getrights";
  bool loadwallet = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MetaMaskProvider()..init(),
        builder: (context, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Center(
                          child: shader("Canary",
                              TextStyle(fontSize: 65, letterSpacing: .5))),
                      Positioned(
                          top: 25,
                          right: 50,
                          child: Consumer<MetaMaskProvider>(
                              builder: (context, provider, child) {
                            if (provider.isEnabled &&
                                provider.currentAddress.isEmpty) {
                              context.read<MetaMaskProvider>().connect();
                            }
                            if (provider.currentAddress.isNotEmpty) {
                              WidgetsBinding.instance
                                  ?.addPostFrameCallback((timeStamp) {
                                setState(() {
                                  loadwallet = true;
                                });
                              });

                              return Container(
                                width: 200,
                                height: 55,
                                // margin: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(5.0,
                                          5.0), // shadow direction: bottom right
                                    )
                                  ],
                                ),
                                child: Container(
                                  width: 195,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        provider.currentAddress
                                                .substring(0, 7) +
                                            "..." +
                                            provider.currentAddress
                                                .substring(37, 42),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(Icons.circle, color: Colors.green)
                                    ],
                                  ),
                                ),
                              );
                            } else if (!provider.isConnected) {
                              return Container(
                                height: 55.0,
                                width: 200,
                                child: RaisedButton(
                                  onPressed: () => context
                                      .read<MetaMaskProvider>()
                                      .connect(),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: 200, minHeight: 20.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Connect to MetaMask",
                                        // textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Text("Use a Web3 browser");
                          }))
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(width: 550,),
                          InkWell(
                            onTap: () {
                              setState(() {
                                formstate = "getrights";
                                form = GetRights();
                              });
                            },
                            child: Center(
                              child: Container(
                                child: Text("Get Rights",
                                    style: formstate == "getrights"
                                        ? TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            letterSpacing: .5)
                                        : TextStyle(fontSize: 18)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                formstate = "giverights";
                                form = GiveRights();
                              });
                            },
                            child: Center(
                              child: Container(
                                child: Text("Give Rights",
                                    style: formstate == "giverights"
                                        ? TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            letterSpacing: .5)
                                        : TextStyle(fontSize: 18)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                formstate = "gaverights";
                                form = GaveRights();
                              });
                            },
                            child: Center(
                              child: Container(
                                child: Text("You Gave Rights",
                                    style: formstate == "gaverights"
                                        ? TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            letterSpacing: .5)
                                        : TextStyle(fontSize: 18)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                formstate = "haverights";
                                form = HaveRights();
                              });
                            },
                            child: Center(
                              child: Container(
                                child: Text("You Have Rights",
                                    style: formstate == "haverights"
                                        ? TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            letterSpacing: .5)
                                        : TextStyle(fontSize: 18)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  loadwallet ? form : Container()
                ],
              ),
            ),
          );
        });
  }

  Widget shader(String text, TextStyle style) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.green,
          Colors.yellow,
          Colors.green,
        ],
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        style: GoogleFonts.pacifico(
          textStyle: style,
        ),
      ),
    );
  }
}
