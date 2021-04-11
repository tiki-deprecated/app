/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:package_info/package_info.dart';

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

Future<String> version() async {
  return (await PackageInfo.fromPlatform()).version;
}

Future<String> versionPlusBuild() async {
  PackageInfo info = await PackageInfo.fromPlatform();
  return info.version + "+" + info.buildNumber;
}

const String appEnvPublic = 'public';
const String appEnv = String.fromEnvironment('com.mytiki.app.environment',
    defaultValue: appEnvPublic);
