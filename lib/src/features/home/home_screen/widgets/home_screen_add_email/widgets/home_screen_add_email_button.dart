import 'package:app/src/config/config_color.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_add_email/bloc/home_screen_add_email_cubit.dart';
import 'package:app/src/features/home/home_screen/widgets/home_screen_add_email/bloc/home_screen_add_email_state.dart';
import 'package:app/src/utils/helper/helper_google_auth.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:app/src/widgets/components/tiki_info_cards/slider_info_cards.dart';
import 'package:app/src/widgets/components/tiki_info_cards/slider_info_card/slider_info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      ;
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
    return [
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
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: ConfigColor.tikiBlue),
            )
          ])),
          Icon(Icons.share, color: ConfigColor.orange, size: 40)
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
                      fontSize: 18,
                      fontFamily: "NunitoSans"),
                  text: "Gmail records your ",
                  children: [
                TextSpan(
                    style: TextStyle(
                        color: ConfigColor.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: "NunitoSans"),
                    text: "IP address",
                    children: [
                      TextSpan(
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
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
                      fontSize: 18,
                      fontFamily: "NunitoSans"),
                  text: "You can use a ",
                  children: [
                TextSpan(
                    style: TextStyle(
                        color: ConfigColor.orange,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        fontFamily: "NunitoSans"),
                    text: "VPN",
                    children: [
                      TextSpan(
                          style: TextStyle(
                              color: ConfigColor.tikiBlue,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              fontFamily: "NunitoSans"),
                          text:
                              " to hide your IP address or, for true anonymity, switch to an ",
                          children: [
                            TextSpan(
                                style: TextStyle(
                                    color: ConfigColor.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: "NunitoSans"),
                                text: "encrypted email service",
                                children: [
                                  TextSpan(
                                      style: TextStyle(
                                          color: ConfigColor.tikiBlue,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          fontFamily: "NunitoSans"),
                                      text:
                                          " .\n\nGmail does not currently use additional location services, here’s how to  ",
                                      children: [
                                        TextSpan(
                                            style: TextStyle(
                                                color: ConfigColor.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                fontFamily: "NunitoSans"),
                                            text: " block them",
                                            children: [
                                              TextSpan(
                                                style: TextStyle(
                                                    color: ConfigColor.tikiBlue,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18,
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
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: ConfigColor.tikiBlue),
            )
          ])),
          Icon(Icons.share, color: ConfigColor.orange, size: 40)
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
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: "NunitoSans"),
                  text:
                      "Gmail has access to your emails - it reads, stores and analyzes them.\n\nGoogle uses this information for targeted ads and what they call “smart features” like automatically adding your flight information to your calendar.\n\nIn their own words:\n",
                  children: [
                TextSpan(
                    style: TextStyle(
                        color: ConfigColor.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                        fontFamily: "NunitoSans"),
                    text:
                        "”Google places advertising on Gmail based on key words that appear in messages transmitted through our system (it's a good example of ads helping to pay for the free services we all enjoy online) - so if you're emailing a friend about a trip to Paris, for example, ads might appear on the right hand side of the page for trains to France...”",
                    children: [
                      TextSpan(
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
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
                      fontSize: 18,
                      fontFamily: "NunitoSans"),
                  text: "You can use a ",
                  children: [
                TextSpan(
                    style: TextStyle(
                        color: ConfigColor.orange,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        fontFamily: "NunitoSans"),
                    text: "VPN",
                    children: [
                      TextSpan(
                          style: TextStyle(
                              color: ConfigColor.tikiBlue,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              fontFamily: "NunitoSans"),
                          text:
                              " to hide your IP address or, for true anonymity, switch to an ",
                          children: [
                            TextSpan(
                                style: TextStyle(
                                    color: ConfigColor.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: "NunitoSans"),
                                text: "encrypted email service",
                                children: [
                                  TextSpan(
                                      style: TextStyle(
                                          color: ConfigColor.tikiBlue,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          fontFamily: "NunitoSans"),
                                      text:
                                          " .\n\nGmail does not currently use additional location services, here’s how to  ",
                                      children: [
                                        TextSpan(
                                            style: TextStyle(
                                                color: ConfigColor.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                fontFamily: "NunitoSans"),
                                            text: " block them",
                                            children: [
                                              TextSpan(
                                                style: TextStyle(
                                                    color: ConfigColor.tikiBlue,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18,
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
          'buttonText': "STOP READING MY EMAILS",
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
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: ConfigColor.tikiBlue),
            )
          ])),
          Icon(Icons.share, color: ConfigColor.orange, size: 40)
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
                      fontSize: 18,
                      fontFamily: "NunitoSans"),
                  text: "Gmail records your ",
                  children: [
                TextSpan(
                    style: TextStyle(
                        color: ConfigColor.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: "NunitoSans"),
                    text: "IP address",
                    children: [
                      TextSpan(
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
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
                      fontSize: 18,
                      fontFamily: "NunitoSans"),
                  text: "You can turn off both ",
                  children: [
                TextSpan(
                    style: TextStyle(
                        color: ConfigColor.orange,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        fontFamily: "NunitoSans"),
                    text: "VPN",
                    children: [
                      TextSpan(
                          style: TextStyle(
                              color: ConfigColor.tikiBlue,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              fontFamily: "NunitoSans"),
                          text: " ad personalization",
                          children: [
                            TextSpan(
                                style: TextStyle(
                                    color: ConfigColor.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: "NunitoSans"),
                                text: "encrypted email service",
                                children: [
                                  TextSpan(
                                    style: TextStyle(
                                        color: ConfigColor.tikiBlue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        fontFamily: "NunitoSans"),
                                    text:
                                        "  and “smart features” to stop Google from scanning your emails.",
                                  )
                                ])
                          ])
                    ])
              ])),
          'buttonText': "AD PERSONALIZATION",
          'btnAction': () => _launchUrl("https://adssettings.google.com")
        }
      }),
    ];
  }

  _launchUrl(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
