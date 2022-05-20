import 'package:flutter/material.dart';
import 'package:nftrenter/nft_mockups.dart';
import 'package:nftrenter/screen/get_nft_popup.dart';
import 'package:nftrenter/screen/utils/hero_dialog_route.dart';
import 'package:nftrenter/screen/utils/metamask.dart';
import 'package:nftrenter/screen/utils/nft_metadata.dart';
import 'package:flutter_web3/flutter_web3.dart';

import 'gave_nft_popup.dart';
import 'utils/TokenUtils.dart';

class GaveRights extends StatefulWidget {
  const GaveRights({Key? key}) : super(key: key);

  @override
  State<GaveRights> createState() => _GaveRightsState();
}

class _GaveRightsState extends State<GaveRights> {
  Mockups mock = Mockups();
  MetaMaskProvider mp = MetaMaskProvider();
  NFTMetadata ni = NFTMetadata();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map>>(
        future: mock.propertiesOf(mp.currentAddress),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                shrinkWrap: true,
                children: List.generate(
                  snapshot.data!.length,
                  (index) {
                    return nftcard(index, snapshot.data!);
                  },
                ));
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
        });
  }

  Widget nftcard(int index, List<Map> availableNFTs) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return GaveNFTPopup(
              tag: availableNFTs[index]["id"],
              index: index,
              nft: availableNFTs[index]);
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
                        future: ni.getMetadataFromUrl(
                            availableNFTs[index]["uri"],),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.memory(
                                        snapshot.data!["png"],
                                        width: 300,
                                        height: 280,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text(availableNFTs[index]["name"]),
                                          Text(snapshot.data!["name"]),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("Price"),
                                          Text(EthUtils.formatEther(
                                                  "${availableNFTs[index]["dailyprice"]}") +
                                              " Matic"),
                                        ],
                                      ),
                                    ],
                                  )
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
                      )),
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
