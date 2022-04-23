import 'package:flutter/material.dart';
import 'package:nftrenter/screen/show_nft_popup.dart';
import 'package:nftrenter/screen/utils/hero_dialog_route.dart';
import 'package:nftrenter/screen/utils/metamask.dart';
import 'package:nftrenter/screen/utils/nft_image.dart';

import '../nft_mockups.dart';

class HaveRights extends StatefulWidget {
  const HaveRights({Key? key}) : super(key: key);

  @override
  State<HaveRights> createState() => _HaveRightsState();
}

class _HaveRightsState extends State<HaveRights> {
  Mockups mock = Mockups();
  MetaMaskProvider mp = MetaMaskProvider();
  List<Map> rightsOver = [];
  NFTImage ni = NFTImage();

  @override
  void initState() {
    super.initState();
    mock.getRightsOf(mp.currentAddress).then((value) => rightsOver = value);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 1.0,
      mainAxisSpacing: 1.0,
      shrinkWrap: true,
      children: List.generate(
        rightsOver.length,
        (index) {
          return nftcard(index);
        },
      ),
    );
  }

  Widget nftcard(int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return ShowNFTPopup(tag: rightsOver[index]["id"], index: index, nft: rightsOver[index],);
        }));
      },
      child: Hero(
        tag: rightsOver[index]["id"],
        child: Material(
          child: Center(
            child: Container(
              width: 355,
              height: 360,
              // margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(5.0, 5.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: Center(
                child: Container(
                  width: 350,
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: FutureBuilder<Map>(
                          future: ni.getImageFromToken(rightsOver[index]["ERC721"], rightsOver[index]["id"]),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Image.memory(
                                      snapshot.data!["png"],
                                      width: 345,
                                      height: 320,
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
                      Text(rightsOver[index]["name"],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(rightsOver[index]["id"],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
