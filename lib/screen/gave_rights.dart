import 'package:flutter/material.dart';
import 'package:nftrenter/screen/gave_nft_popup.dart';
import 'package:nftrenter/screen/utils/hero_dialog_route.dart';
import 'package:nftrenter/screen/utils/metamask.dart';
import 'package:nftrenter/screen/utils/nft_image.dart';

import '../nft_mockups.dart';

class GaveRights extends StatefulWidget {
  const GaveRights({ Key? key }) : super(key: key);

  @override
  State<GaveRights> createState() => _GaveRightsState();
}

class _GaveRightsState extends State<GaveRights> {
  Mockups mock = Mockups();
  MetaMaskProvider mp = MetaMaskProvider();
  List<Map> properties = [];
  NFTImage ni = NFTImage();

  @override
  void initState() {
    super.initState();
    mock.propertiesOf(mp.currentAddress).then((value) => properties = value);
  }
  
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 1.0,
      mainAxisSpacing: 1.0,
      shrinkWrap: true,
      children: List.generate(
        properties.length,
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
          return GaveNFTPopup(tag: properties[index]["id"], index: index, nft: properties[index],);
        }));
      },
      child: Hero(
        tag: properties[index]["id"],
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
                        child:FutureBuilder<Map>(
                          future: ni.getImageFromToken(properties[index]["ERC721"], properties[index]["id"]),
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
                      Text(properties[index]["name"], style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(properties[index]["id"], style: TextStyle(fontWeight: FontWeight.bold)),
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