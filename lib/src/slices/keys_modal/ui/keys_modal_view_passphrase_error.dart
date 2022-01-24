import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../keys_modal_service.dart';

class KeysModalViewPassphraseError extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    KeysModalService service = Provider.of<KeysModalService>(context);
    return Column(children: [
      Text(service.model.errorMessage, style: TextStyle(color: Colors.red)),
    ]);
  }

}
