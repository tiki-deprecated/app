import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TikiScreenViewVersion extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var service = Provider.of<TikiScreenService>(context);
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(vertical: service.presenter.marginVerticalLogOut),
      child: Text("v0.1.1", style: TextStyle(color: Colors.grey)),
    );
  }

}