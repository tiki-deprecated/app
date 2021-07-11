import 'package:app/src/slices/app/app_service.dart';
import 'package:flutter/material.dart';

class AppInformationParser extends RouteInformationParser<AppService> {
  final AppService appService;

  AppInformationParser({required this.appService});

  @override
  Future<AppService> parseRouteInformation(
      RouteInformation routeInformation) async {
    final String dlPathBouncer = "/app/bouncer";
    final link = Uri.parse(routeInformation.location!);
    if (link.path == dlPathBouncer) {
      String? otp = link.queryParameters["otp"];
      if (otp != null && otp.isNotEmpty) {
        var user = await appService.authService.verifyOtp(otp);
        if (user != null) {
          if (user.address != null) {
            user.isLoggedIn = true;
            await appService.updateUser(user);
            return appService;
          } else {
            return appService;
          }
        }
      }
    }
    return appService;
  }
}
