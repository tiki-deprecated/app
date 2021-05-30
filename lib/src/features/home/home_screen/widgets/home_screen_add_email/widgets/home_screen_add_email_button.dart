import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_add_email/bloc/home_screen_add_email_cubit.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_add_email/bloc/home_screen_add_email_state.dart';
import 'package:app/src/utils/helper/helper_google_auth.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/widgets/components/tiki_info_cards/slider_info_cards.dart';
import 'package:app/src/widgets/components/tiki_info_cards/slider_info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddGmailButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AddEmailCubit(),
        child: BlocBuilder<AddEmailCubit, AddEmailState>(
            builder: (BuildContext context, AddEmailState state) {
          _getGmailCurrentUser(context);
          return state is InitialState ? CircularProgressIndicator(color: ConfigColor.mardiGras,)  : _addBtn(context);
        }));
  }

  _removeGmail(context) {
    AddEmailCubit cubit = BlocProvider.of<AddEmailCubit>(context);
    cubit.removeAccount();
  }

  _addGmail(context) {
    AddEmailCubit cubit = BlocProvider.of<AddEmailCubit>(context);
    cubit.addAccount();
  }

  _whatGmailHolds(context) {
    List<SliderInfoCard> cards = createCards();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SliderInfoCards(cards)));
  }

  Widget _addBtn(context) {
    AddEmailState state = BlocProvider.of<AddEmailCubit>(context).state;
    List<Widget> child = state is AddedState
        ? [_removeRow(context), _seeButton(context)]
        : [_addButton(context)];

    return Column(children: child);
  }

  Widget _removeRow(context) {
    return Container(
        margin: EdgeInsets.only(bottom: 12),
        child: Row(children: [
          Text("You've linked your Gmail account.",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "NunitoSans",
                  fontWeight: FontWeight.w600)),
          GestureDetector(
            child: Container(
                child: Row(children: [
              Text(" Remove",
                  style: TextStyle(
                      color: ConfigColor.orange,
                      fontSize: 15,
                      fontFamily: "NunitoSans",
                      fontWeight: FontWeight.w600)),
              Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(20.0)),
                    border: new Border.all(
                      color: ConfigColor.orange,
                      width: 1.0,
                    ),
                  ),
                  child:
                      Icon(Icons.close, size: 18, color: ConfigColor.orange)),
            ])),
            onTap: () => _removeGmail(context),
          )
        ]));
  }

  Widget _addButton(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        //boxShadow: [BoxShadow(offset: Offset(4,4), blurRadius: 20, color:Color(0x33000000))]
      ),
      child: GestureDetector(
          child: Row(children: [
            HelperImage(
              "add-email",
              width: 35,
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Add your\nGmail account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: "Montserrat")))),
            HelperImage(
              "right-arrow",
              width: 30,
            )
          ]),
          onTap: () => _addGmail(context)), //_whatGmailHolds(context)),
    );
  }

  Widget _seeButton(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        //boxShadow: [BoxShadow(offset: Offset(4,4), blurRadius: 20, color:Color(0x33000000))]
      ),
      child: GestureDetector(
          child: Row(children: [
            HelperImage(
              "eye-added-email",
              width: 35,
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("See what\nGmail account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: "Montserrat")))),
            HelperImage(
              "right-arrow",
              width: 30,
            )
          ]),
          onTap: () => _whatGmailHolds(context)),
    );
  }

  List<SliderInfoCard> createCards() {
    return [SliderInfoCard(), SliderInfoCard(), SliderInfoCard()];
  }

  _getGmailCurrentUser(context) async {
    AddEmailCubit cubit = BlocProvider.of<AddEmailCubit>(context);
    HelperGoogleAuth().getConnectedUser().then((connectedUser) {
      if (connectedUser != null) {
        cubit.emit(AddedState(connectedUser));
      } else {
        cubit.emit(NotAddedState());
      }
      ;
    });
  }
}
