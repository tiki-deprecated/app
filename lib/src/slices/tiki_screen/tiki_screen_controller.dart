import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TikiScreenController {
  addGmailAccount(context) {
    Provider.of<TikiScreenService>(context, listen: false).addGoogleAccount();
  }

  removeGmailAccount(context) {
    Provider.of<TikiScreenService>(context, listen: false)
        .removeGoogleAccount();
  }

  whatGmailHolds(context) {
    Provider.of<TikiScreenService>(context, listen: false)
        .whatGmailHolds(context);
  }

  launchUrl(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  logout(context) {
    removeGmailAccount(context);
    Provider.of<AppService>(context, listen: false).logout();
  }

  shareText(context) {
    Provider.of<TikiScreenService>(context, listen: false).shareLink();
  }
}
