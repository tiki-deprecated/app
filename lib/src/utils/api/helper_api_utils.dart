/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class HelperApiUtils {
  static bool is2xx(int? code) => (code != null && code >= 200 && code < 300);
  static bool isNot2xx(int? code) =>
      (code == null || code < 200 || code <= 300);

  static bool is3xx(int? code) => (code != null && code >= 300 && code < 400);
  static bool is4xx(int? code) => (code != null && code >= 400 && code < 500);
  static bool is5xx(int? code) => (code != null && code >= 500);

  static bool isOk(int? code) => (code != null && code == 200);
  static bool isNotOk(int? code) => (code == null || code != 200);

  static bool isBadRequest(int? code) => (code != null && code == 400);
  static bool isUnauthorized(int? code) => (code != null && code == 401);
  static bool isForbidden(int? code) => (code != null && code == 403);
  static bool isNotFound(int? code) => (code != null && code == 404);
  static bool isUnprocessable(int? code) => (code != null && code == 422);
}
