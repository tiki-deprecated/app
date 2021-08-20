import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config_color.dart';

class UserAccountModalViewVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
          return Text(
              "TIKI Inc." +
                  (snapshot.hasData
                      ? " | Release " + snapshot.data!.version
                      : ""),
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: ConfigColor.greySix));
        });
  }
}
