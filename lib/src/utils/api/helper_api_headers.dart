/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class HelperApiHeaders {
  Map<String, String> header = {
    "Content-Type": "application/json",
    "Accept": "*/*",
    "Cache-Control": "no-cache"
  };

  HelperApiHeaders({Map? provided, String? auth}) {
    if (provided != null) header.addAll(provided as Map<String, String>);
    if (auth != null) header["Authorization"] = "Bearer " + auth;
  }
}
