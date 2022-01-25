import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../keys_modal_service.dart';

class KeysModalViewPincodeError extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    KeysModalService service = Provider.of<KeysModalService>(context);
    return Column(children: [
      Text(_getErrorMessage(), style: TextStyle(color: Colors.red)),
    ]);
  }

  String _getErrorMessage() {
    return "Incorrect pincode. Please try again";
  }
}