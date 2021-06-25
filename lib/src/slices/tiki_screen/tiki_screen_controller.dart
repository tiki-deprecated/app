import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/tiki_screen/tiki_screen_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TikiScreenController {
  addGmailAccount(context) {
    Provider.of<TikiScreenService>(context).addGoogleAccount();
  }

  removeGmailAccount(context) {
    Provider.of<TikiScreenService>(context).removeGoogleAccount();
  }

  whatGmailHolds(context) {
    Provider.of<TikiScreenService>(context).whatGmailHolds(context);
  }

  launchUrl(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  logout(context) {
    Provider.of<AppService>(context).controller.logout();
  }

  shareText(context, text) {
    Provider.of<TikiScreenService>(context).shareLink(context, text);
  }
}
