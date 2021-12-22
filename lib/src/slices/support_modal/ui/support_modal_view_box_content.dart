import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SupportModalViewBoxContent extends StatelessWidget {
  final dynamic data;

  SupportModalViewBoxContent(this.data);

  @override
  Widget build(BuildContext context) {
    String content = data.content
        .substring(0, data.content.length > 30 ? 30 : data.content.length);
    return Container(
        alignment: Alignment.centerLeft, child: Html(data: content));
  }
}
