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
  static const operatingChain = 868455272153094;
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
      //     "facetAddress": "0x9c520e4561993294744227af6C46a08056667784",
      //     "action": 0,
      //     "functionSelectors":
      //         getSelectors(a.diamondLoupAbi, a.diamondLoupeNames)
      //   },
      //   {
      //     "facetAddress": "0x5D9efE77aCb9D0DfCfC8aAE134696A5587cc1273",
      //     "action": 0,
      //     "functionSelectors": getSelectors(a.ownershipAbi, a.ownershipNames)
      //   }
      // ];

      // var cut = [
      //   {
      //     "facetAddress": "0xAD25D794E88c358C4bE5899d98EB06b1f7080141",
      //     "action": 0,
      //     "functionSelectors":
      //         getSelectors(a.canaryabi, a.canaryNames)
      //   }
      // ];
      // print(cut);
      print(EthUtils.defaultAbiCoder.encode(["address","uint256"], ["0x550Ee22945AaCBEBa678550b53A8B1AF7e923EBe", "10"]));
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
