import 'package:app/src/slices/gmail_data_screen/gmail_data_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GmailDataScreenController{

  shareCard(BuildContext context, String message, String image) {
   Provider.of<GmailDataScreenService>(context, listen:false).shareCard(message, image);
  }

  launchUrl(BuildContext context, String url) async {
    Provider.of<GmailDataScreenService>(context, listen:false).launchUrl(url);
  }

}
