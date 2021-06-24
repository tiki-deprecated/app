import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/gmail_data_screen/gmail_data_screen_service.dart';
import 'package:app/src/slices/gmail_data_screen/model/gmail_data_screen_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InfoCardContentExplanation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<InfoCardContentExplanationModel> spans = [];
    TextSpan? childSpan;
    spans.reversed.forEach((spanContent){
      childSpan = _buildSpan(spanContent, childSpan, context);
    });
    return RichText(text: childSpan ?? TextSpan());
  }

  _buildSpan(InfoCardContentExplanationModel content, TextSpan? child, BuildContext context) {
    return TextSpan(
        recognizer: TapGestureRecognizer()..onTap = () => _launchUrl(content.url, context),
        style: TextStyle(
        color: content.url == null ? Colors.white : ConfigColor.orange,
        fontWeight: content.url == null ? FontWeight.w400 : FontWeight.bold,
        fontSize: 12.sp,
        fontFamily: "NunitoSans"),
        text: content.text,
        children: [child ?? TextSpan()]
    );
  }

  _launchUrl(String? url, context) {
    if(url != null)
      Provider.of<GmailDataScreenService>(context).launchUrl(url);
  }
}
