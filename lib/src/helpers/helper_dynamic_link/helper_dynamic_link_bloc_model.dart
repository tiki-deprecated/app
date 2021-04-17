/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_dynamic_link/helper_dynamic_link_bloc_model_blockchain.dart';
import 'package:app/src/helpers/helper_dynamic_link/helper_dynamic_link_bloc_model_bouncer.dart';

class HelperDynamicLinkBlocModel {
  final HelperDynamicLinkBlocModelBouncer _bouncer;
  final HelperDynamicLinkBlocModelBlockchain _blockchain;

  HelperDynamicLinkBlocModel(
      {HelperDynamicLinkBlocModelBouncer bouncer,
      HelperDynamicLinkBlocModelBlockchain blockchain})
      : this._bouncer = bouncer,
        this._blockchain = blockchain;

  HelperDynamicLinkBlocModelBouncer get bouncer => _bouncer;
  HelperDynamicLinkBlocModelBlockchain get blockchain => _blockchain;
}
