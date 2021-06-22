import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_add_email/bloc/home_screen_add_email_cubit.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_add_email/bloc/home_screen_add_email_state.dart';
import 'package:app/src/repositories/google/google_repository.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/utils/helper_permission.dart';
import 'package:app/src/widgets/components/tiki_info_cards/slider_info_card/slider_info_card.dart';
import 'package:app/src/widgets/components/tiki_info_cards/slider_info_cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class AddGmailButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AddEmailCubit(),
        child: BlocBuilder<AddEmailCubit, AddEmailState>(
            builder: (BuildContext context, AddEmailState state) {
          _getGmailCurrentUser(context);
          return state is InitialState
              ? CircularProgressIndicator(
                  color: ConfigColor.mardiGras,
                )
              : _addBtn(context);
        }));
  }

  _getGmailCurrentUser(context) async {
    AddEmailCubit cubit = BlocProvider.of<AddEmailCubit>(context);
    HelperGoogleAuth().getConnectedUser().then((connectedUser) {
      if (connectedUser != null) {
        cubit.emit(AddedState(connectedUser));
      } else {
        cubit.emit(NotAddedState());
      }
    });
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
    AddedState state =
        BlocProvider.of<AddEmailCubit>(context).state as AddedState;
    String? gmail = state.currentUser?.email;
    return Container(
        margin: EdgeInsets.only(bottom: 12),
        child: RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: 1.75.h,
                    fontFamily: "NunitoSans",
                    color: Color(0xFF545454),
                    fontWeight: FontWeight.w600),
                text: "You've linked ",
                children: <InlineSpan>[
              TextSpan(
                style: TextStyle(
                    fontSize: 1.75.h,
                    fontFamily: "NunitoSans",
                    color: Color(0xFF545454),
                    fontWeight: FontWeight.w600),
                text: gmail ?? "your Gmail account.",
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => _removeGmail(context),
                style: TextStyle(
                    color: ConfigColor.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 1.75.h,
                    fontFamily: "NunitoSans"),
                text: " Remove ",
              ),
              WidgetSpan(
                  alignment: ui.PlaceholderAlignment.middle,
                  child: GestureDetector(
                    onTap: () => _removeGmail(context),
                    child: Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(15.0)),
                          border: new Border.all(
                            color: ConfigColor.orange,
                            width: 1.0,
                          ),
                        ),
                        child: Center(
                            child: Icon(Icons.close,
                                size: 14, color: ConfigColor.orange))),
                  )),
            ])));
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
                            fontSize: 2.h,
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
                    child: Text("See what data\nGmail has on you",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 2.h,
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
    return [
      SliderInfoCard(coverData: {
        'topHeader': Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
              child: Row(children: [
            HelperImage("gmail-round-logo",
                width: PlatformRelativeSize.blockHorizontal * 6),
            Padding(
                padding: EdgeInsets.only(
                    right: PlatformRelativeSize.blockHorizontal * 2)),
            Text(
              "Your Gmail account",
              style: TextStyle(
                  fontFamily: "NunitoSans",
                  fontSize: 1.8.h,
                  fontWeight: FontWeight.w800,
                  color: ConfigColor.tikiBlue),
            )
          ])),
          GestureDetector(
              onTap: () => _shareCard(
                  message:
                      "Gmail knows where you are when you read your emails. It's your data, start taking it back on https://www.mytiki.com",
                  image: 'socialmedia1.png'),
              child: Icon(Icons.share, color: ConfigColor.orange, size: 40))
        ]),
        'image': "where-you-are",
        'subtitle': "Gmail knows...",
        'bigTextLighter': 'Where you are ',
        'bigTextDarker': 'when you read your emails.',
        'subText':
            "Your Gmail account tracks your location when you open your emails...\nEvery single time you do it."
      }, cardData: {
        'cardContentData': {
          'richTextExplanation': RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 2.h,
                      fontFamily: "NunitoSans"),
                  text: "Gmail records your ",
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchUrl(
                          "https://en.wikipedia.org/wiki/IP_address"),
                    style: TextStyle(
                        color: ConfigColor.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 2.h,
                        fontFamily: "NunitoSans"),
                    text: "IP address",
                    children: [
                      TextSpan(
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 2 * PlatformRelativeSize.blockVertical,
                            fontFamily: "NunitoSans"),
                        text:
                            " every time you open your inbox or send an email.\n\nMost Google products and almost all email services do this. Some, like Outlook, but NOT Gmail, will even send your IP address to the person receiving your email.\n\nThe most common use approximates your location, pinpointing you within 3-5 miles anywhere in the world. In extreme cases, like criminal investigations, your IP address can be tied to your exact device and location by working with an Internet Service Provider.",
                      )
                    ])
              ])),
          'theysay': [
            {
              'image': "info-badge",
              'text': "Security monitoring to suspicious access"
            },
            {
              'image': "search-graph",
              'text': "Analyzing patterns to develop new features and products"
            },
          ],
          'youShouldKnow': [
            {
              'image': "np-tap",
              'text':
                  "Used advertisers for location-based targeting and surveillance"
            },
            {'image': "badge", 'text': "Used by law enforcement"},
            {
              'image': "worldwide",
              'text': "Saved for 9 months, then obscured and kept permanently"
            }
          ]
        },
        'cardCtaData': {
          'richTextExplanation': RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: ConfigColor.tikiBlue,
                      fontWeight: FontWeight.w500,
                      fontSize: 2.h,
                      fontFamily: "NunitoSans"),
                  text: "You can use a ",
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchUrl('https://nordvpn.com'),
                    style: TextStyle(
                        color: ConfigColor.orange,
                        fontWeight: FontWeight.w500,
                        fontSize: 2.h,
                        fontFamily: "NunitoSans"),
                    text: "VPN",
                    children: [
                      TextSpan(
                          style: TextStyle(
                              color: ConfigColor.tikiBlue,
                              fontWeight: FontWeight.w400,
                              fontSize: 2 * PlatformRelativeSize.blockVertical,
                              fontFamily: "NunitoSans"),
                          text:
                              " to hide your IP address or, for true anonymity, switch to an ",
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      _launchUrl('https://protonmail.com'),
                                style: TextStyle(
                                    color: ConfigColor.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        2 * PlatformRelativeSize.blockVertical,
                                    fontFamily: "NunitoSans"),
                                text: "encrypted email service",
                                children: [
                                  TextSpan(
                                      style: TextStyle(
                                          color: ConfigColor.tikiBlue,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 2 *
                                              PlatformRelativeSize
                                                  .blockVertical,
                                          fontFamily: "NunitoSans"),
                                      text:
                                          ".\n\nGmail does not currently use additional location services, here’s how to  ",
                                      children: [
                                        TextSpan(
                                            // just left if here to know when to reactivate
                                            //recognizer: TapGestureRecognizer()..onTap = () => _launchUrl('https://mytiki.com/blog/how-to-block-location-services'),
                                            style: TextStyle(
                                                color: ConfigColor.tikiBlue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 2 *
                                                    PlatformRelativeSize
                                                        .blockVertical,
                                                fontFamily: "NunitoSans"),
                                            text: "block them",
                                            children: [
                                              TextSpan(
                                                style: TextStyle(
                                                    color: ConfigColor.tikiBlue,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 2 *
                                                        PlatformRelativeSize
                                                            .blockVertical,
                                                    fontFamily: "NunitoSans"),
                                                text:
                                                    ".\n\nIf you just hate the ads, you can turn off ad personalization for your entire Google account. ",
                                              )
                                            ])
                                      ])
                                ])
                          ])
                    ])
              ])),
          'buttonText': "AD PERSONALIZATION",
          'btnAction': () => _launchUrl("https://adssettings.google.com")
        }
      }),
      SliderInfoCard(coverData: {
        'topHeader': Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
              child: Row(children: [
            HelperImage("gmail-round-logo", width: 25),
            Padding(padding: EdgeInsets.only(right: 8)),
            Text(
              "Your Gmail account",
              style: TextStyle(
                  fontFamily: "NunitoSans",
                  fontSize: 1.8.h,
                  fontWeight: FontWeight.w800,
                  color: ConfigColor.tikiBlue),
            )
          ])),
          GestureDetector(
              onTap: () => _shareCard(
                  message:
                      "Gmail knows what you've written to your friends. Find out more on https://www.mytiki.com",
                  image: 'socialmedia2.png'),
              child: Icon(Icons.share, color: ConfigColor.orange, size: 40))
        ]),
        'image': "what-written",
        'subtitle': "Gmail knows...",
        'bigTextLighter': 'What you’ve written to ',
        'bigTextDarker': 'your friends',
        'subText':
            "Gmail has all emails you’ve ever written to anyone. They look at the content in the emails, so they know you better."
      }, cardData: {
        'cardContentData': {
          'richTextExplanation': RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 2.h,
                      fontFamily: "NunitoSans"),
                  text:
                      "Gmail has access to your emails - it reads, stores and analyzes them.\n\nGoogle uses this information for targeted ads and what they call “smart features” like automatically adding your flight information to your calendar.\n\nIn their own words:\n",
                  children: [
                TextSpan(
                    style: TextStyle(
                        color: ConfigColor.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 2.h,
                        fontFamily: "NunitoSans"),
                    text:
                        "”Google places advertising on Gmail based on key words that appear in messages transmitted through our system (it's a good example of ads helping to pay for the free services we all enjoy online) - so if you're emailing a friend about a trip to Paris, for example, ads might appear on the right hand side of the page for trains to France...”",
                    children: [
                      TextSpan(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 2 * PlatformRelativeSize.blockVertical,
                            fontFamily: "NunitoSans"),
                        text: "\n\nCreepy.",
                      )
                    ])
              ])),
          'theysay': [
            {
              'image': "airplane",
              'text': "Travel assistance like itineraries, updates, and maps."
            },
            {
              'image': "email",
              'text':
                  "Smart email with suggestions, nudges, prioritization, and filtering"
            },
            {
              'image': "package",
              'text': "Track packages, reservations, loyalty cards, and bills"
            },
          ],
          'youShouldKnow': [
            {
              'image': "np-tap",
              'text': "Used by advertisers for key word targetting"
            },
            {'image': "hammer", 'text': "Used by law enforcement"},
            {'image': "worldwide", 'text': "Disabled by default in Europe"}
          ]
        },
        'cardCtaData': {
          'richTextExplanation': RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: ConfigColor.tikiBlue,
                      fontWeight: FontWeight.w500,
                      fontSize: 2.h,
                      fontFamily: "NunitoSans"),
                  text: "You can turn off both,",
                  children: [
                TextSpan(
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () => _launchUrl(
                          "https://support.google.com/mail/answer/10079371"),
                    style: TextStyle(
                        color: ConfigColor.orange,
                        fontWeight: FontWeight.w500,
                        fontSize: 2.h,
                        fontFamily: "NunitoSans"),
                    text: " ad personalization ",
                    children: [
                      TextSpan(
                        style: TextStyle(
                            color: ConfigColor.tikiBlue,
                            fontWeight: FontWeight.w400,
                            fontSize: 2 * PlatformRelativeSize.blockVertical,
                            fontFamily: "NunitoSans"),
                        text:
                            "and “smart features” to stop Google from scanning your emails.",
                      )
                    ])
              ])),
          'buttonText': "STOP READING MY EMAILS",
          'btnAction': () =>
              _launchUrl("https://support.google.com/mail/answer/10079371")
        }
      }),
      SliderInfoCard(coverData: {
        'topHeader': Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
              child: Row(children: [
            HelperImage("gmail-round-logo", width: 25),
            Padding(padding: EdgeInsets.only(right: 8)),
            Text(
              "Your Gmail account",
              style: TextStyle(
                  fontFamily: "NunitoSans",
                  fontSize: 1.8.h,
                  fontWeight: FontWeight.w800,
                  color: ConfigColor.tikiBlue),
            )
          ])),
          GestureDetector(
              onTap: () => _shareCard(
                  message:
                      "Gmail knows what you've written to your friends. Find out more on https://www.mytiki.com",
                  image: 'socialmedia2.png'),
              child: Icon(Icons.share, color: ConfigColor.orange, size: 40))
        ]),
        'image': "everything-you-do",
        'subtitle': "Gmail knows...",
        'bigTextLighter': "Everything\n",
        'bigTextDarker': 'you do in your Gmail app',
        'subText':
            "Your Gmail app has quite a lot of analytics packed in and knows quite a few things...."
      }, cardData: {
        'cardContentData': {
          'richTextExplanation': RichText(
              text: TextSpan(
            style: TextStyle(
                color: Colors.white, fontSize: 2.h, fontFamily: "NunitoSans"),
            text:
                "Gmail’s app is designed to track most of the things you do with it. It tracks each action you take, on which device, OS, and time of day.\n\nFor example, when you opened the app, what you searched for and if you saw an ad were all tracked.\n\nYour audio is recorded if you use voice search or assistant with Gmail.",
          )),
          'theysay': [
            {'image': "person-4", 'text': "Personalized experiences"},
            {
              'image': "circle-badge",
              'text': "App and content recommendations"
            },
            {'image': "search", 'text': "Faster Search"},
          ],
          'youShouldKnow': [
            {
              'image': "hat-n-glasses",
              'text': "Your activity is tracked even when logged out"
            },
            {'image': "badge", 'text': "Used by law enforcement"},
            {
              'image': "bomb",
              'text':
                  "You can set your history to auto delete after 3, 18, or 36 months"
            }
          ]
        },
        'cardCtaData': {
          'richTextExplanation': RichText(
              text: TextSpan(
            style: TextStyle(
                color: ConfigColor.tikiBlue,
                fontWeight: FontWeight.w500,
                fontSize: 2.h,
                fontFamily: "NunitoSans"),
            text:
                "You can delete all activities, individual activities, set it to auto-delete, or disable activity tracking entirely.",
          )),
          'buttonText': "MY ACTIVITY",
          'btnAction': () => _launchUrl("https://myactivity.google.com")
        }
      }),
    ];
  }

  _launchUrl(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  _shareCard({required String message, required String image}) async {
    bool permission = await HelperPermission.request(Permission.storage);
    if (permission) {
      ByteData? bytes = await rootBundle.load("res/images/$image");
      var buffer = bytes.buffer;
      Uint8List pngBytes = buffer.asUint8List();
      Directory directory;
      if (Platform.isIOS)
        directory = await getApplicationDocumentsDirectory();
      else
        directory = (await getExternalStorageDirectory())!;
      String path = directory.path + '/tikishare.png';
      File imgFile = new File(path);

      imgFile.writeAsBytesSync(pngBytes, flush: true);
      Share.shareFiles(
        [path],
        text: message,
      );
    }
  }
}
