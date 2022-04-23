import 'dart:typed_data';

import 'package:flutter_web3/flutter_web3.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:nftrenter/screen/utils/interfaces.dart';

class NFTImage {
  Interfaces inter = Interfaces();
  http.Client httpClient = http.Client();
  Future<Map> getImageFromToken(String erc721, String token) async {
    var result = await inter.erc721(erc721).call<String>('tokenURI', [token]);
    Uint8List png = await getImageFromUrl(result);
    return {"png": png};
  }

  Future<Uint8List> getImageFromUrl(String ipfsurl) async {
    var url = ipfsurl.replaceFirst(r'ipfs://', r'https://ipfs.io/ipfs/');
    var resp = await httpClient.get(Uri.parse(url));
    var json = convert.jsonDecode(resp.body) as Map;
    var imageUrl = json["image"]
        .toString()
        .replaceFirst(r'ipfs://', r'https://ipfs.io/ipfs/');
    var imgresp = await httpClient.get(Uri.parse(imageUrl));
    return Uint8List.fromList(imgresp.body.codeUnits);
  }
}
