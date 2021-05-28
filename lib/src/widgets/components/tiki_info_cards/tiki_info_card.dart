import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
              child: Container(
                  child: Column(children: [
                    Container(
                        height: constraints.maxHeight,
                        padding: EdgeInsets.only(bottom: 16),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(children: [
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Row(children: [
                                                Icon(Icons.remove_red_eye_outlined,
                                                    color: ConfigColor.tikiBlue),
                                                Padding(padding: EdgeInsets.only(right: 8)),
                                                Text(
                                                  "Gmail knows...",
                                                  style: TextStyle(
                                                      fontFamily: "NunitoSans",
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w900,
                                                      color: ConfigColor.tikiBlue),
                                                )
                                              ])),
                                          Icon(Icons.share,
                                              color: ConfigColor.tikiBlue, size: 30)
                                        ]),
                                    Padding(
                                        padding: EdgeInsets.only(top: 35),
                                        child: Center(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  HelperImage("gmail-sub"),
                                                  RichText(
                                                      textAlign: TextAlign.left,
                                                      text: TextSpan(
                                                          style: TextStyle(
                                                              color: ConfigColor.orange,
                                                              height: 1,
                                                              fontFamily: "NunitoSans",
                                                              fontSize: 45,
                                                              fontWeight: FontWeight.bold),
                                                          text: 'Every single time ',
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                'you open your Gmail app.',
                                                                style: TextStyle(
                                                                    color: ConfigColor.tikiBlue,
                                                                    height: 1,
                                                                    fontFamily: "NunitoSans",
                                                                    fontSize: 45,
                                                                    fontWeight:
                                                                    FontWeight.bold))
                                                          ]))
                                                ]))),
                                  ])),
                              Container(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.keyboard_arrow_up,
                                        size: 70,
                                        color: Colors.grey,
                                      ),
                                      Text("Find the truth",
                                          style: TextStyle(
                                              color: Color(0xFF8D8D8D),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              height: 0.8))
                                    ],
                                  )),
                            ])),
                    Container(
                        padding: EdgeInsets.only(top: 40, left: 25, right: 25, bottom: 66),
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: ConfigColor.mardiGras,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 30),
                                child: Text(
                                    "Gmail has all your email content. This includes everything you’ve ever written, and everything anyone has sent to you. Lorem ipsum con dolor last sentence",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        fontFamily: "NunitoSans"))),
                            Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: HelperImage(
                                            "alert",
                                            width: 35,
                                          )),
                                      Container(
                                        margin: EdgeInsets.only(top: 16),
                                        child: Text("You should know",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "NunitoSans",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                      Container(
                                          child: Row(children: [
                                            Padding(
                                                padding: EdgeInsets.only(right: 16),
                                                child: HelperImage("government", width: 30)),
                                            Expanded(
                                                child: Column(children: [
                                                  Padding(padding: EdgeInsets.only(bottom: 30)),
                                                  Text(
                                                      "This data can be used for government surveillance",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "NunitoSans",
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 16))
                                                ]))
                                          ])),
                                      Padding(padding:EdgeInsets.only(top:16)),
                                      Divider(color: Colors.white),
                                      Container(
                                          padding: EdgeInsets.only(right: 16),
                                          child: Row(children: [
                                            Padding(
                                                padding: EdgeInsets.only(right: 16),
                                                child: HelperImage("balance", width: 30)),
                                            Expanded(
                                                child: Column(children: [
                                                  Text("\nThis data is known to create racial bias",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "NunitoSans",
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 16)),
                                                ]))
                                          ])),
                                      Padding(padding:EdgeInsets.only(top:16)),
                                      Divider(color: Colors.white),
                                      Container(
                                          padding: EdgeInsets.only(right: 16),
                                          child: Row(children: [
                                            Padding(
                                                padding: EdgeInsets.only(right: 16),
                                                child: HelperImage("worldwide", width: 30)),
                                            Expanded(
                                                child: Column(children: [
                                                  Text(
                                                      "\nFacebook holds the largest facial dataset in the world",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "NunitoSans",
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 16))
                                                ]))
                                          ])),
                                    ])),
                            Container(
                                margin: EdgeInsets.only(top:40),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 30),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      primary: ConfigColor.white),
                                  onPressed: () {  }, child: Text("FIND OUT MORE", style: TextStyle(color: Color(0xFF102770), fontSize: 20, fontWeight: FontWeight.bold)),

                                )
                            )
                          ],
                        ))
                  ])));
        });
  }
}
