import 'package:app/src/config/config_color.dart';
import 'package:app/src/utils/helper/helper_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SliderInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return AnimatedCardContainer(constraints);
            })));
  }
}

class AnimatedCardContainer extends StatefulWidget {
  final BoxConstraints constraints;

  const AnimatedCardContainer(this.constraints);

  @override
  State<StatefulWidget> createState() => _AnimatedCardContainerState();
}

class _AnimatedCardContainerState extends State<AnimatedCardContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late DragStartDetails startVerticalDragDetails;
  late DragUpdateDetails updateVerticalDragDetails;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          minHeight: widget.constraints.maxHeight,
        ),
        color: ConfigColor.mardiGras,
        child: Column(
          children: [
            GestureDetector(
                onVerticalDragStart: (dragDetails) {
                  startVerticalDragDetails = dragDetails;
                },
                onVerticalDragUpdate: (dragDetails) {
                  updateVerticalDragDetails = dragDetails;
                },
                onVerticalDragEnd: (endDetails) {
                  double dx = updateVerticalDragDetails.globalPosition.dx -
                      startVerticalDragDetails.globalPosition.dx;
                  double dy = updateVerticalDragDetails.globalPosition.dy -
                      startVerticalDragDetails.globalPosition.dy;
                  double velocity = endDetails.primaryVelocity ?? 0;

                  //Convert values to be positive
                  if (dx < 0) dx = -dx;
                  if (dy < 0) dy = -dy;

                  if (velocity < 0) {
                    controller.forward();
                  }
                  if (velocity > 0) {
                    controller.reverse();
                  }
                },
                child: Cover(
                    controller: controller,
                    maxHeight: widget.constraints.maxHeight)),
            CardContent(widget.constraints)
          ],
        ));
  }
}

class Cover extends AnimatedWidget {
  final maxHeight;

  Cover({
    Key? key,
    required AnimationController controller,
    required double this.maxHeight,
  }) : super(key: key, listenable: controller);

  Animation<double> get _controllerValue => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: _calculateAnimation(maxHeight, _controllerValue.value, 150),
        padding: EdgeInsets.only(top: 16, left: 25, right: 25),
        child: Stack(fit: StackFit.expand, children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  height: _calculateAnimation(60, _controllerValue.value, 0),
                  child: Opacity(
                    opacity: 1 - _controllerValue.value,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                          GestureDetector(Icon(Icons.share, color: ConfigColor.orange, size: 40)
                        ]),
                  ))),
          Align(
              alignment: Alignment(
                _controllerValue.value,-1
              ),
                  child: Padding(
                      padding: EdgeInsets.only(top:_calculateAnimation(50, _controllerValue.value, 0)),child:HelperImage("where-you-are",
                  width: _calculateAnimation(300, _controllerValue.value, 130)))),
          Positioned(
              top: 330,
              child: Container(
                  height: _calculateAnimation(60, _controllerValue.value, 0),
                  child: Opacity(
                      opacity: _controllerValue.value * 2 <= 1
                          ? 1 - (_controllerValue.value * 2)
                          : 0,
                      child: Container(
                          height: _calculateAnimation(
                              60, _controllerValue.value, 0),
                          margin: EdgeInsets.only(bottom: 10),
                          width: double.maxFinite,
                          child: Text("Gmail knows...",
                              style: TextStyle(
                                  color: ConfigColor.orange,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "NunitoSans")))))),
          Padding(
              padding: EdgeInsets.only(top: _calculateAnimation(370, _controllerValue.value, 0)),
              child: Align(
                  alignment: Alignment(
                    -_controllerValue.value,
                    -1,
                  ),
                  child: Container(
                      width: _calculateAnimation(
                          MediaQuery.of(context).size.width,
                          _controllerValue.value,
                          170),
                      child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              style: TextStyle(
                                  color: Color(0xFF0036B5),
                                  height: 1,
                                  fontFamily: "Koara",
                                  fontSize: _calculateAnimation(45, _controllerValue.value, 30),
                                  fontWeight: FontWeight.bold),
                              text: 'Where you are ',
                              children: [
                                TextSpan(
                                    text: 'when you read your emails.',
                                    style: TextStyle(
                                        color: ConfigColor.tikiBlue,
                                        height: 1,
                                        fontFamily: "Koara",
                                        fontSize: _calculateAnimation(45, _controllerValue.value, 30),
                                        fontWeight: FontWeight.bold))
                              ]))))),
          Padding(
              padding: EdgeInsets.only(
              top: 520,
              ),
              child: Opacity(
                  opacity: _controllerValue.value * 3 <= 1
                      ? 1 - (_controllerValue.value * 3)
                      : 0,
                  child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: double.maxFinite,
                      child: Text(
                          "Your Gmail account tracks your location when you open your emails...\nEvery single time you do it.",
                          style: TextStyle(
                              color: ConfigColor.tikiBlue,
                              fontFamily: "NunitoSans",
                              fontSize: 18,
                              fontWeight: FontWeight.w600))))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: _calculateAnimation(60, _controllerValue.value, 0),
                  child: Opacity(
                      opacity: _controllerValue.value * 2 <= 1
                          ? 1 - (_controllerValue.value * 2)
                          : 0,
                      child: Container(
                        height:
                            _calculateAnimation(60, _controllerValue.value, 0),
                        padding: EdgeInsets.only(bottom: 16),
                        child: HelperImage(
                          "arrow-up",
                          width: 60,
                        ),
                      ))))
        ]));
  }

  _calculateAnimation(double initialValue, double rate, double minimalValue) {
    double decrease = rate * initialValue;
    return initialValue - decrease > minimalValue
        ? initialValue - decrease
        : minimalValue;
  }
}

class CardContent extends StatelessWidget {
  final BoxConstraints constraints;

  const CardContent(this.constraints);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                child: HelperImage(
              "information",
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
                Text("This data can be used for government surveillance",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "NunitoSans",
                        fontWeight: FontWeight.bold,
                        fontSize: 16))
              ]))
            ])),
            Padding(padding: EdgeInsets.only(top: 16)),
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
            Padding(padding: EdgeInsets.only(top: 16)),
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
          margin: EdgeInsets.only(top: 40),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                primary: ConfigColor.white),
            onPressed: () {},
            child: Text("FIND OUT MORE",
                style: TextStyle(
                    color: Color(0xFF102770),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ))
    ]);
  }
}
