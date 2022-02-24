import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

import '../user_account_modal_service.dart';

class UserAccountModalViewQrCodeShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserAccountModalService service =
        Provider.of<UserAccountModalService>(context);
    return Container(
        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 1.5.h),
        child: QrImage(
          data: service.model.qrCode!,
          version: QrVersions.auto,
          size: 80.w,
        ));
  }
}
