import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nftrenter/screen/utils/nft_image.dart';

class TestForm extends StatefulWidget {
  const TestForm({Key? key}) : super(key: key);

  @override
  State<TestForm> createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  NFTImage ni = NFTImage();
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: ni.getImageFromUrl("ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/841"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.memory(
                  snapshot.data!,
                  width: 400,
                  height: 400,
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }
      },
    );
  }
}
