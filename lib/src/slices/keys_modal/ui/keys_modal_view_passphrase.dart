import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../keys_modal_service.dart';
import 'keys_modal_view_passphrase_error.dart';

class KeysModalViewPassphrase extends StatelessWidget {
  final String question = "Enter at least 8 digits passphrase.";

  @override
  Widget build(BuildContext context) {
    KeysModalService service = Provider.of<KeysModalService>(context);
    return Column(children: [
      Text(question),
      TextField(
        obscureText: true,
        onSubmitted: (text) => service.controller.submitPassphrase(text),
        onChanged: (text) => service.controller.passphraseChanged(text),
      ),
      if(service.model.error != null) KeysModalViewPassphraseError()
    ]);
  }
}
