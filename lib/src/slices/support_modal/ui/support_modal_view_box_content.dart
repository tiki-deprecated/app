import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart' as Webview;

import '../support_modal_service.dart';

class SupportModalViewBoxContent extends StatelessWidget {
  final dynamic data;
  final bool excerpt;

  SupportModalViewBoxContent(this.data, {this.excerpt = true});

  @override
  Widget build(BuildContext context) {
    String content = excerpt ? _getExcerpt(data.content) : data.content;
    SupportModalService service = Provider.of<SupportModalService>(context);
    return Container(
        alignment: Alignment.centerLeft,
        child: Html(
            data: content,
            onLinkTap: (String? url, _, __, ___) {
              if (url != null) service.controller.launchUrl(url);
            },
            customRender: {
              "iframe": (RenderContext context, Widget child) {
                final attrs = context.tree.element?.attributes;
                if (attrs != null) {
                  double? width = double.tryParse(attrs['width'] ?? "");
                  double? height = double.tryParse(attrs['height'] ?? "");
                  final initialUrl = attrs['src'] != null
                      ? "https:" + attrs['src']!
                      : "about:blank";
                  return Container(
                    width: width ?? (height ?? 150) * 2,
                    height: height ?? (width ?? 300) / 2,
                    child: Webview.WebView(
                        initialUrl: initialUrl,
                        javascriptMode: Webview.JavascriptMode.unrestricted,
                        gestureRecognizers: _gestureRecognizerFactorySet(),
                        navigationDelegate: (request) =>
                            _getNavigationDelegate(request, initialUrl)),
                  );
                } else {
                  return Container(height: 0);
                }
              }
            }));
  }

  _getNavigationDelegate(Webview.NavigationRequest request, String initialUrl) {
    return request.url == initialUrl
        ? Webview.NavigationDecision.navigate
        : Webview.NavigationDecision.prevent;
  }

  String _getExcerpt(String text) {
    Document document = parse(text);
    String parsedString =
        parse(document.body?.text).documentElement?.text ?? '';
    if (parsedString.length < 100) return text;
    int indexOfSpace = parsedString.substring(0, 100).lastIndexOf(' ');
    return parsedString.substring(0, indexOfSpace) + '...';
  }

  Set<Factory<OneSequenceGestureRecognizer>> _gestureRecognizerFactorySet() {
    return [Factory(() => VerticalDragGestureRecognizer())].toSet();
  }
}
