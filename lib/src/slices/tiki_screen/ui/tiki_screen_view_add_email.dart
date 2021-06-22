import 'package:flutter/material.dart';

class TikiScreenViewAddEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TikiScreenViewAddEmailButton();
  }
}

class TikiScreenViewAddEmailButton extends StatelessWidget {

  const TikiScreenViewAddEmailButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: _addEmail(),
        child: true ? Text("Add") : Text("Remove"));
  }

  _addEmail() {}
}
