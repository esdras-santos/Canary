import 'package:flutter_web3/flutter_web3.dart';

import 'canary_abi.dart';

class Interfaces {
  CanaryAbi ca = CanaryAbi();

  Contract canary() {
    return Contract("0xF1f2ba31c44bECa971600451ceD0090B11382441",
        Interface(ca.abi), provider!.getSigner());
  }

  Contract canaryro() {
    return Contract("0xF1f2ba31c44bECa971600451ceD0090B11382441",
        Interface(ca.abi), provider!);
  }

  Contract erc721(String collection) {
    provider!.getSigner().getAddress().then((value) => print(value));
    return Contract(collection, Interface(ca.e721abi), provider!.getSigner());
  }
}
