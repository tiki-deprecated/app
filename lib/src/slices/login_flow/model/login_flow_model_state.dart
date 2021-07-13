/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

enum LoginFlowModelState {
  returningUser,
  otpRequested,
  creatingKeys,
  keysCreated,
  loggedIn
}
