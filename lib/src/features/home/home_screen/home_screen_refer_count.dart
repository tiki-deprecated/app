/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/keys/keys_referral/keys_referral_cubit.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/platform/platform_relative_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenReferCount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenReferCount();
}

class _HomeScreenReferCount extends State<HomeScreenReferCount> {
  static const String _text = "people joined";
  static final double _fontSize = 4 * PlatformRelativeSize.blockHorizontal;
  static final double _marginRight = 2 * PlatformRelativeSize.blockHorizontal;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<KeysReferralCubit>(context).getCount();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeysReferralCubit, KeysReferralState>(
        builder: (BuildContext context, KeysReferralState state) {
      return _count(state.count == null ? 0 : state.count);
    });
  }

  Widget _count(int? count) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
          margin: EdgeInsets.only(right: _marginRight),
          child: HelperImage("ref-user")),
      Text(count.toString() + " " + _text,
          style: TextStyle(
              fontSize: _fontSize,
              fontWeight: FontWeight.w600,
              color: ConfigColor.jade))
    ]);
  }
}
