import 'package:flutter/material.dart';
import 'package:nftrenter/screen/gave_nft_popup.dart';
import 'package:nftrenter/screen/utils/hero_dialog_route.dart';

import '../nft_mockups.dart';

class GaveRights extends StatefulWidget {
  const GaveRights({ Key? key }) : super(key: key);

  @override
  State<GaveRights> createState() => _GaveRightsState();
}

class _GaveRightsState extends State<GaveRights> {
  Mockups mock = Mockups();
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 1.0,
      mainAxisSpacing: 1.0,
      shrinkWrap: true,
      children: List.generate(
        mock.nfts.length,
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
          return GaveNFTPopup(tag: mock.nfts[index]["id"], index: index);
        }));
      },
      child: Hero(
        tag: mock.nfts[index]["id"],
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
                        child: Container(
                          width: 345,
                          height: 320,
                          decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   image: NetworkImage('img.png'),
                            //   fit: BoxFit.cover,
                            // ),
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                      Text(mock.nfts[index]["collectionname"], style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(mock.nfts[index]["id"], style: TextStyle(fontWeight: FontWeight.bold)),
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