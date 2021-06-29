/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class HelperHeaders {
  Map<String, String> header = {
    "Content-Type": "application/json",
    "Accept": "*/*",
    "Cache-Control": "no-cache"
  };

  HelperHeaders({Map? provided, String? auth}) {
    if (provided != null) header.addAll(provided as Map<String, String>);
    if (auth != null) header["Authorization"] = "Bearer " + auth;
  }
}
