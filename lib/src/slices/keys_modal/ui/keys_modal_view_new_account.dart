import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../keys_modal_service.dart';

class KeysModalViewNewAccount extends StatelessWidget {
  final String question = "Do you want to create a new account?";

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
    KeysModalService service = Provider.of<KeysModalService>(context, listen: false);
    service.controller.goToKeysScan();
  }

  _yesTap(BuildContext context) {
    KeysModalService service = Provider.of<KeysModalService>(context, listen:false);
    service.controller.createNewKeys();
  }
}
