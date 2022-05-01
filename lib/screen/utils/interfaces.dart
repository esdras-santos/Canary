import 'package:flutter_web3/flutter_web3.dart';

import 'canary_abi.dart';

class Interfaces {
  CanaryAbi ca = CanaryAbi();

  Contract canary() {
    return Contract("0x34786005489a9BE178Aeb46895Adc800062D143C",
        Interface(ca.abi), provider!.getSigner());
  }

  Contract canaryro() {
    return Contract("0x34786005489a9BE178Aeb46895Adc800062D143C",
        Interface(ca.abi), provider!);
  }

  Contract erc721(String collection) {
    return Contract(collection, Interface(ca.e721abi), provider!.getSigner());
  }
}
