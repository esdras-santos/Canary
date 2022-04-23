import 'package:flutter_web3/flutter_web3.dart';

import 'screen/utils/interfaces.dart';

class Mockups {
  Mockups._privateConstructor();
  static final Mockups _mock = Mockups._privateConstructor();
  Interfaces inter = Interfaces();
  factory Mockups() {
    return _mock;
  }

  Future<List<Map>> getAvailablNFTs() async {
    final anfts = await inter.canary().call("getAvailableNFTs");
    List<Map> availableNFTs = [];
    for (int i = 0; i < anfts.length; i = i + 2) {
      final dp = await inter
          .canary()
          .call<BigInt>("dailyPriceOf", [anfts[i], anfts[i + 1]]);
      final owner = await inter
          .canary()
          .call<String>("ownerOf", [anfts[i], anfts[i + 1]]);
      final mp = await inter
          .canary()
          .call<BigInt>("maxPeriodOf", [anfts[i], anfts[i + 1]]);
      final cn = await inter.erc721("${anfts[i]}").call<String>("name");
      availableNFTs.add({
        "dailyprice": "$dp",
        "id": "${int.parse(anfts[i + 1])}",
        "owner": owner,
        "ERC721": "${anfts[i]}",
        "maxperiod": "$mp",
        "name": cn
      });
    }
    return availableNFTs;
  }

  Future<List<Map>> getRightsOf(String holder) async {
    final hr = await inter.canary().call("rightsOf", [holder]);
    List<Map> rightsOf = [];
    for (int i = 0; i < hr.length; i = i + 2) {
      final dp =
          await inter.canary().call<BigInt>("dailyPriceOf", [hr[i], hr[i + 1]]);
      final owner =
          await inter.canary().call<String>("ownerOf", [hr[i], hr[i + 1]]);
      final mp =
          await inter.canary().call<BigInt>("maxPeriodOf", [hr[i], hr[i + 1]]);
      final cn = await inter.erc721("${hr[i]}").call<String>("name");
      rightsOf.add({
        "dailyprice": "$dp",
        "id": "${int.parse(hr[i + 1])}",
        "owner": owner,
        "ERC721": "${hr[i]}",
        "maxperiod": "$mp",
        "name": cn
      });
    }
    return rightsOf;
  }

  Future<List<Map>> propertiesOf(String owner) async {
    final prop = await inter.canary().call("propertiesOf", [owner]);
    List<Map> properties = [];
    for (int i = 0; i < prop.length; i = i + 2) {
      final dp = await inter
          .canary()
          .call<BigInt>("dailyPriceOf", [prop[i], prop[i + 1]]);
      final owner =
          await inter.canary().call<String>("ownerOf", [prop[i], prop[i + 1]]);
      final mp = await inter
          .canary()
          .call<BigInt>("maxPeriodOf", [prop[i], prop[i + 1]]);
      final cn = await inter.erc721("${prop[i]}").call<String>("name");
      properties.add({
        "dailyprice": "$dp",
        "id": "${int.parse(prop[i + 1])}",
        "owner": owner,
        "ERC721": "${prop[i]}",
        "maxperiod": "$mp",
        "name": cn
      });
    }
    return properties;
  }
}
