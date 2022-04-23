import 'package:flutter/material.dart';
import 'package:nftrenter/nft_mockups.dart';
import 'package:nftrenter/screen/get_nft_popup.dart';
import 'package:nftrenter/screen/utils/hero_dialog_route.dart';
import 'package:nftrenter/screen/utils/nft_image.dart';

class GetRights extends StatefulWidget {
  const GetRights({Key? key}) : super(key: key);

  @override
  State<GetRights> createState() => _GetRightsState();
}

class _GetRightsState extends State<GetRights> {
  Mockups mock = Mockups();
  List<Map> availableNFTs = [];
  NFTImage ni = NFTImage();

  @override
  void initState() {
    super.initState();
    mock.getAvailablNFTs().then((value) => availableNFTs = value);
  }
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
        shrinkWrap: true,
        children: List.generate(
          availableNFTs.length,
          (index) {
            return nftcard(index);
          },
        ));
  }

  Widget nftcard(int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return GetNFTPopup(tag: availableNFTs[index]["id"], index: index, nft: availableNFTs[index]);
        }));
      },
      child: Hero(
        tag: availableNFTs[index]["id"],
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
                          future: ni.getImageFromToken(availableNFTs[index]["ERC721"], availableNFTs[index]["id"]),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(availableNFTs[index]["name"]),
                              Text(availableNFTs[index]["id"]),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Price"),
                              Text(availableNFTs[index]["dailyprice"]),
                            ],
                          ),
                        ],
                      )
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
