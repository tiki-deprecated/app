/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

class WalletBalanceViewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('res/images/wallet-card.png'),
      width: double.infinity,
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  }
}
