import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../keys_modal_service.dart';

class KeysModalViewPassphrase extends StatelessWidget {
  final String question = "Enter a 8 digits passphrase.";

  @override
  Widget build(BuildContext context) {
    KeysModalService service = Provider.of<KeysModalService>(context);
    return Column(children: [
      Text(question),
      TextField(
        onSubmitted: (text) => service.controller.submitPassphrase(text),
      )
    ]);
  }
}
