import 'package:nftrenter/screen/utils/metamask.dart';

import 'screen/utils/interfaces.dart';

class Mockups {
  MetaMaskProvider mp = MetaMaskProvider();
  Interfaces inter = Interfaces();

  Future<List<Map>> getAvailableNFTs() async {    
    final anfts = await inter.canary().call("getAvailableNFTs");

    List<Map> availableNFTs = [];

    for (int i = 0; i < anfts.length; i = i + 2) {
      final dp = await inter.canary().call<BigInt>("dailyPriceOf", [anfts[i]]);
      final owner = await inter.canary().call<String>("ownerOf", [anfts[i]]);
      final mp = await inter.canary().call<BigInt>("maxPeriodOf", [anfts[i]]);
      final or = await inter.canary().call("originOf", [anfts[i]]);
      final md = await inter.canary().call("rightURI", [anfts[i]]);
      final cn = await inter
          .erc721("0x" + or[0].substring(26, or[0].length))
          .call<String>("name");

      availableNFTs.add({
        "rightid": anfts[i],
        "dailyprice": "$dp",
        "id": "${int.parse(or[1])}",
        "owner": owner,
        "ERC721": "0x" + or[0].substring(26, or[0].length),
        "maxperiod": "$mp",
        "name": cn,
        "uri": md
      });
    }
    return availableNFTs;
  }

  Future<List<Map>> getRightsOf(String holder) async {
    final hr = await inter.canary().call("rightsOf", [holder]);

    List<Map> rightsOf = [];
    for (int i = 0; i < hr.length; i = i + 2) {
      final dp = await inter.canary().call<BigInt>("dailyPriceOf", [hr[i]]);
      final owner = await inter.canary().call<String>("ownerOf", [hr[i]]);
      final mp = await inter.canary().call<BigInt>("maxPeriodOf", [hr[i]]);
      final or = await inter.canary().call("originOf", [hr[i]]);
      final md = await inter.canary().call("rightURI", [hr[i]]);
      final cn = await inter
          .erc721("0x" + or[0].substring(26, or[0].length))
          .call<String>("name");
      rightsOf.add({
        "rightid": hr[i],
        "dailyprice": "$dp",
        "id": "${int.parse(or[1])}",
        "owner": owner,
        "ERC721": "0x" + or[0].substring(26, or[0].length),
        "maxperiod": "$mp",
        "name": cn,
        "uri": md
      });
    }
    return rightsOf;
  }

  Future<List<Map>> propertiesOf(String owner) async {
    final prop = await inter.canaryro().call("propertiesOf", [owner]);

    List<Map> properties = [];
    for (int i = 0; i < prop.length; i = i + 2) {
      final dp = await inter.canary().call<BigInt>("dailyPriceOf", [prop[i]]);

      final owner = await inter.canary().call<String>("ownerOf", [prop[i]]);

      final mp = await inter.canary().call<BigInt>("maxPeriodOf", [prop[i]]);
      final or = await inter.canary().call("originOf", [prop[i]]);
      final md = await inter.canary().call("rightURI", [prop[i]]);
      final cn = await inter
          .erc721("0x" + or[0].substring(26, or[0].length))
          .call<String>("name");

      properties.add({
        "rightid": prop[i],
        "dailyprice": "$dp",
        "id": "${int.parse(or[1])}",
        "owner": owner,
        "ERC721": "0x" + or[0].substring(26, or[0].length),
        "maxperiod": "$mp",
        "name": cn,
        "uri": md
      });
    }
    return properties;
  }

  Future<Map> royalties(String rightid) async {
    final rightHolders =
        await inter.canaryro().call("rightHoldersOf", [rightid]);
    List deadlinelist = [];
    List roindexes = [];
    List whrindexes = [];
    int confirmedRoyalties = 0;
    int unconfirmedRoyalties = 0;

    for (int i = 0; i < rightHolders.length; i++) {
      var deadline = await inter
          .canaryro()
          .call("holderDeadline", [rightid, rightHolders[i]]);
      final dailyPrice = await inter.canaryro().call("dailyPriceOf", [rightid]);
      final rightsPeriod = await inter
          .canaryro()
          .call("rightsPeriodOf", [rightid, rightHolders[i]]);

      if (deadline < (DateTime.now().millisecondsSinceEpoch / 1000)) {
        deadlinelist.add(rightHolders[i]);
        confirmedRoyalties += int.parse(dailyPrice) * int.parse(rightsPeriod);
        whrindexes.add(i);
        var rightsOver =
            await inter.canaryro().call("rightsOf", [rightHolders[i]]);
        for (int j = 0; j < rightsOver.length; j += 2) {
          if (int.parse(rightsOver[j]) == int.parse(rightid)) {
            roindexes.add(j);
          }
        }
      } else {
        unconfirmedRoyalties += int.parse(dailyPrice) * int.parse(rightsPeriod);
      }
    }
    return {
      "dl": deadlinelist,
      "roi": roindexes,
      "whri": whrindexes,
      "cr": confirmedRoyalties,
      "ur": unconfirmedRoyalties
    };
  }
}
