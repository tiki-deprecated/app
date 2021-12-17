import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SupportScreenViewBoxContent extends StatelessWidget {
  final dynamic data;

  SupportScreenViewBoxContent(this.data);

  @override
  Widget build(BuildContext context) {
    String content = data.content;
    return Html(data: content);
  }
}
