/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/slices/info_carousel_card/model/info_carousel_card_model_content_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../info_carousel_card_service.dart';

class InfoCarouselCardViewScrollBodyExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<InfoCarouselCardModelContentText> spans =
        Provider.of<InfoCarouselCardService>(context)
            .model
            .content!
            .body!
            .explain!;
    TextSpan? childSpan;
    spans.reversed.forEach((spanContent) {
      childSpan = _buildSpan(spanContent, childSpan, context);
    });
    return RichText(text: childSpan ?? TextSpan());
  }

  _buildSpan(InfoCarouselCardModelContentText content, TextSpan? child,
      BuildContext context) {
    return TextSpan(
        recognizer: TapGestureRecognizer()
          ..onTap = () => _launchUrl(content.url, context),
        style: TextStyle(
            color: content.url == null ? Colors.white : ConfigColor.fireBush,
            fontWeight:
                content.url == null ? FontWeight.normal : FontWeight.w600,
            fontSize: 13.sp,
            fontFamily: "NunitoSans"),
        text: content.text,
        children: [child ?? TextSpan()]);
  }

  _launchUrl(String? url, context) {
    if (url != null)
      Provider.of<InfoCarouselCardService>(context, listen: false)
          .controller
          .launchUrl(url);
  }
}
