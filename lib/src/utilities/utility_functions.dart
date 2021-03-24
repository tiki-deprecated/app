/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

Map jsonDecodeNullSafe(String source) {
  if (source == null)
    return null;
  else
    return jsonDecode(source);
}
