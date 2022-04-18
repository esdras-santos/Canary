import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nftrenter/screen/gave_rights.dart';
import 'package:nftrenter/screen/get_rights.dart';
import 'package:nftrenter/screen/give_rights.dart';
import 'package:nftrenter/screen/have_rights.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget form = GetRights();
  String formstate = "getrights";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            shader("Canary", TextStyle(fontSize: 65, letterSpacing: .5)),
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
            form
          ],
        ),
      ),
    );
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
