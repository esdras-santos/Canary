import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:nftrenter/screen/utils/canary_abi.dart';
import 'package:nftrenter/screen/utils/interfaces.dart';


class MetaMaskProvider extends ChangeNotifier {
  static const operatingChain = 242;
  String currentAddress = '';
  int currentChain = -1;
  bool get isEnabled => ethereum != null;
  bool get isInOperatingChain => currentChain == operatingChain;
  bool get isConnected => isEnabled && currentAddress.isNotEmpty;
  Interfaces inter = Interfaces();
  CanaryAbi a = CanaryAbi();

  Future<void> connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) currentAddress = accs.first;
      currentChain = await ethereum!.getChainId();
      // var cut = [
      //   {
      //     "facetAddress": "0x8b7CF4e9709d9c7A60b92f2fB46C0E5a9c40cd31",
      //     "action": 0,
      //     "functionSelectors":
      //         getSelectors(a.diamondLoupAbi, a.diamondLoupeNames)
      //   },
      //   {
      //     "facetAddress": "0x734d95D74Cb7366E17d851fE09Ad0113E67ef7d0",
      //     "action": 0,
      //     "functionSelectors": getSelectors(a.ownershipAbi, a.ownershipNames)
      //   }
      // ];

      // var cut = [
      //   {
      //     "facetAddress": "0x3e9966fA0da25bc97D9A0aA318Eff7dd761a49C9",
      //     "action": 0,
      //     "functionSelectors":
      //         getSelectors(a.canaryabi, a.canaryNames)
      //   }
      // ];
      
      notifyListeners();
    }
  }

  clear() {
    currentAddress = "";
    currentChain = -1;
    notifyListeners();
  }

  init() {
    if (isEnabled) {
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });
      ethereum!.onChainChanged((chainId) {
        clear();
      });
    }
  }

  List<String> getSelectors(String abi, List<String> names) {
    List<String> selectors = [];
    for (int i = 0; i < names.length; i++) {
      selectors.add(Interface(abi).getSighash(names[i]));
    }
    return selectors;
  }
}
