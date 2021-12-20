import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SupportModalViewBoxContent extends StatelessWidget {
  final dynamic data;

  SupportModalViewBoxContent(this.data);

  @override
  Widget build(BuildContext context) {
    String content = data.content;
    return Html(data: content);
  }
}
