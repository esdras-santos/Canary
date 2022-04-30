import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:nftrenter/screen/utils/canary_abi.dart';
import 'package:nftrenter/screen/utils/interfaces.dart';


class MetaMaskProvider extends ChangeNotifier {
  MetaMaskProvider._privateConstructor();
  static final MetaMaskProvider _mmp = MetaMaskProvider._privateConstructor();
  factory MetaMaskProvider() {
    return _mmp;
  }
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
      //     "facetAddress": "0x4FEB6DA9F4cb1Ff93A24E4FA75b7129653169970",
      //     "action": 0,
      //     "functionSelectors":
      //         getSelectors(a.diamondLoupAbi, a.diamondLoupeNames)
      //   },
      //   {
      //     "facetAddress": "0x667064c47430d45cAE9dAd03878101bA3d47f83c",
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
