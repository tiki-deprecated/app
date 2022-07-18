import 'dart:io';

import 'package:flutter/material.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfigUpdate{

  ConfigUpdate._();

  static bool shouldUpdate = true;
  static String latestVersion = '';

  static Future<void> checkVersion({BuildContext? context}) async {
    Uri uri = Uri.parse('https://api.github.com/repos/tiki/app/releases');
    await Httpp().client().request(HttppRequest(
        uri: uri,
        verb: HttppVerb.GET,
        timeout: const Duration(seconds: 30),
        onSuccess: (rsp) async {
          try {
            List releases = rsp.body?.jsonBody;
            Map ver = releases[0];
            String releaseName = ver['name'].trim();
            String currentName = (await PackageInfo.fromPlatform()).version;
            if (releaseName != currentName) {
              List<String> latest = releaseName.split('.');
              List<String> current = currentName.split('.');
              int major1 = int.parse(latest[0]);
              int major2 = int.parse(current[0]);
              int minor1 = int.parse(latest[1]);
              int minor2 = int.parse(current[1]);
              int hot1 = int.parse(latest[2]);
              int hot2 = int.parse(current[2]);
              if (major1 > major2 ||
                  (major1 == major2 && minor1 > minor2) ||
                  (minor1 == minor2 && hot1 > hot2)
              ) {
                shouldUpdate = true;
                latestVersion = releaseName;
              } else {
                shouldUpdate = false;
                latestVersion = currentName;
              }
            }
          }catch(e){
            Logger('ConfigUpdate').warning("Error with version check", e);
          }
        }));
  }

  static AlertDialog dialog(BuildContext context){
      return AlertDialog(
            title: const Text('Update TIKI ?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('There is a new version available.'),
                  Text('Update?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text('Yes'),
                  onPressed: () =>  _updateApp()
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
  }

  static Future<void> _updateApp() async {
    Uri url = Uri.parse(Platform.isIOS ? 'https://testflight.apple.com/join/pUcjaGK8' :
      'https://play.google.com/store/apps/details?id=com.mytiki.app');
    (await canLaunchUrl(url)) ?
      launchUrl(url) :
      Logger('ConfigUpdates').warning('Cannot open ${url.toString()}');
  }
}