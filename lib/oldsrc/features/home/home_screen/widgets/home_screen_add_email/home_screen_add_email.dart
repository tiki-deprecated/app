import 'package:app/src/features/home/home_screen/widgets/home_screen_add_email/bloc/home_screen_add_email_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_screen_add_email_state.dart';

class HomeScreenAddEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEmailCubit, AddEmailState>(builder: (context, state) {
      return HomeScreenAddEmailButton(state);
    });
  }
}

class HomeScreenAddEmailButton extends StatelessWidget {
  final AddEmailState state;

  const HomeScreenAddEmailButton(this.state);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: _addEmail(state),
        child: state is InitialState ? Text("Add") : Text("Remove"));
  }

  _addEmail(AddEmailState state) {}
}
