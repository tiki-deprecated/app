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

Map<String, String> jsonHeaders({Map provided, String auth}) {
  Map<String, String> header = Map();
  if (provided != null) header.addAll(provided);
  if (auth != null) header["Authorization"] = "Bearer " + auth;
  header["Content-Type"] = "application/json";
  header["Accept"] = "*/*";
  header["Cache-Control"] = "no-cache";
  return header;
}
