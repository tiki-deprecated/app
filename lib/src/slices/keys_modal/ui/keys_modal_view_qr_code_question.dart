import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../keys_modal_service.dart';

class KeysModalViewQrCodeQuestion extends StatelessWidget {
  final String question = "Do you have a QR code to scan?";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(question),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => _yesTap(context),
              child: Text("Yes"),
              behavior: HitTestBehavior.opaque,
            ),
            GestureDetector(
              onTap: () => _noTap(context),
              child: Text("No"),
              behavior: HitTestBehavior.opaque,
            )
          ],
        )
      ],
    );
  }

  _noTap(BuildContext context) {
    KeysModalService service = Provider.of<KeysModalService>(context, listen:false);
    service.controller.restoreKeys();
  }

  _yesTap(BuildContext context) {
    KeysModalService service = Provider.of<KeysModalService>(context, listen:false);
    service.controller.scanQrCode();
  }
}
