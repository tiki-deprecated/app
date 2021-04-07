/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

class HelperLoginView extends StatelessWidget {
  final Widget _loggedIn;
  final Widget _creating;
  final Widget _loggedOut;
  final Widget _pending;

  HelperLoginView(
      this._loggedIn, this._creating, this._loggedOut, this._pending);

  /*@override
  Widget build(BuildContext context) {
    HelperLoginBloc _bloc = HelperLoginBlocProvider.of(context).bloc;
    return StreamBuilder(
        stream: _bloc.observable,
        initialData: _bloc.helperLoginModel,
        builder: (context, AsyncSnapshot<HelperLoginModel> snapshot) {
          if (snapshot.data.semaphore == false && snapshot.data.otp != null)
            _bloc.completeOtp();
          else if (snapshot.data.state == HelperLoginModelState.loggedIn)
            return _loggedIn;
          else if (snapshot.data.state == HelperLoginModelState.creating)
            return _creating;
          else if (snapshot.data.state == HelperLoginModelState.loggedOut)
            return _loggedOut;
          return _pending;
        });
  }*/

  /*@override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HelperLoginBlocProvider.of(context).bloc.beginOtp(otp),
        builder: (context, AsyncSnapshot<HelperLoginModel> snapshot) {});
  }*/
}
