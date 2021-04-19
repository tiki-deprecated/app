/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:app/src/utilities/utility_functions.dart';

const String bouncer = 'bouncer';
const String blockchain = 'blockchain';
const String website = 'website';

String of(String key) {
  return (appEnv == appEnvPublic ? _publicConfig : _localConfig)[key];
}

const Map<String, String> _publicConfig = {
  bouncer: "bouncer.mytiki.com",
  blockchain: "blockchain.mytiki.com",
  website: "api.mytiki.com",
};

const Map<String, String> _localConfig = {
  bouncer: "localhost:10227",
  blockchain: "localhost:10252",
  website: "localhost:3000",
};
