import 'package:flutter_web3/flutter_web3.dart';

import 'canary_abi.dart';

class Interfaces {
  CanaryAbi ca = CanaryAbi();

  Contract canary() {
    return Contract("0xDB75ECA09b0911e530741F52fdA0Ae862892aFE5",
        Interface(ca.abi), provider!.getSigner());
  }

  Contract erc721(String collection) {
    return Contract(collection, Interface(ca.e721abi), provider!.getSigner());
  }
}
