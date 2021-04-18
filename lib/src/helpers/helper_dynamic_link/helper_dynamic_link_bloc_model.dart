/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/helpers/helper_dynamic_link/helper_dynamic_link_bloc_model_blockchain.dart';
import 'package:app/src/helpers/helper_dynamic_link/helper_dynamic_link_bloc_model_bouncer.dart';

class HelperDynamicLinkBlocModel {
  HelperDynamicLinkBlocModelBouncer bouncer;
  HelperDynamicLinkBlocModelBlockchain blockchain;

  HelperDynamicLinkBlocModel({this.bouncer, this.blockchain});
}
