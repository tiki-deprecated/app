import 'package:app/src/config/config_color.dart';
import 'package:app/src/config/config_font.dart';
import 'package:app/src/utils/helper_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';

class DecisionCardSpamViewSecurity extends StatelessWidget {
  final double? starRates;

  const DecisionCardSpamViewSecurity(this.starRates);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Column(children: [DecisionCardSpamViewSecurityStars(this.starRates)]),
    );
  }
}

class DecisionCardSpamViewSecurityStars extends StatelessWidget {
  final double? starRates;

  DecisionCardSpamViewSecurityStars(this.starRates);

  @override
  Widget build(BuildContext context) {
    return Container(
        child:Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 0.5.h),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: _getStars()),
      Padding(
        padding: EdgeInsets.only(top: 1.h),
      ),
      this.starRates != null ?
      RichText(
        text: TextSpan(
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: ConfigFont.familyKoara,
                color: ConfigColor.greyFour,
                fontSize: 20.sp),
            text: "Your data is ",
            children: [
              TextSpan(
                  text: _getSecurityText(this.starRates ?? 0),
                  style: TextStyle(color: _getColorForText())),
              _getInfoIcon(context)
            ]),
      ) :
      RichText(
        text: TextSpan(
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: ConfigFont.familyKoara,
                color: ConfigColor.greyFour,
                fontSize: 20.sp),
            text: "No data score info yet ",
            children: [
              _getInfoIcon(context)
            ]),
      ),
      Padding(
        padding: EdgeInsets.only(top: 3.h),
      ),
    ]));
  }

  List<Widget> _getStars() {
    var color = _getColor();
    var starRate = this.starRates ?? 0;
    var stars = <Widget>[];
    for (int i = 0; i < 5; i++) {
      if (i < starRate) {
        stars.add(HelperImage("star-$color", width: 6.w));
      } else if (i > starRate.floor() && i < starRate.ceil()) {
        stars.add(Stack(children: [
          ClipRect(
            child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: 0.5,
                child: HelperImage("star-$color", width: 7.w)),
          ),
          HelperImage("star-grey", width: 7.w),
        ]));
      } else if (i >= starRate) {
        stars.add(HelperImage("star-grey", width: 7.w));
      }
    }
    return stars;
  }

  String _getColor() {
    if(this.starRates == null) {
      return "grey";
    }else{
      var starRate = this.starRates ?? 0;
      if (starRate < 2) {
        return "red";
      } else if (starRate < 4) {
        return "yellow";
      } else {
        return "green";
      }
    }
  }

  Color _getColorForText() {
    var starRates = this.starRates ?? 0;
    if(this.starRates == null) {
      return ConfigColor.greyFive;
    }else{
      if (starRates< 2) {
        return ConfigColor.tikiRed;
      } else if (starRates < 4) {
        return ConfigColor.tikiOrange;
      } else {
        return ConfigColor.green;
      }
    }
  }

  String _getSecurityText(num starRate) {
    if (starRate < 2) {
      return "not safe";
    } else if (starRate < 4) {
      return "somewhat safe";
    } else {
      return "very safe";
    }
  }

  Future<void> showModal(BuildContext context, {num? sensitivity, num? hacking}) {
    var spacing = 2.4.h;
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: ConfigColor.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.5.h))),
        builder: (BuildContext context) => Container(
            padding: EdgeInsets.only(left: 20, right: 40),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: EdgeInsets.only(top: spacing),
              ),
              Divider(
                height: spacing,
                thickness: 5,
                color: ConfigColor.greyTwo,
              ),
              Padding(
                padding: EdgeInsets.only(top: spacing * 2),
              ),
              Text('Security score.',
                  style: TextStyle(
                      color: ConfigColor.tikiBlue,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.only(top: spacing),
              ),
              sensitivity == null
                  ? DecisionCardSpamViewSecurityEmpty()
                  : Container(),
              RichText(
                  text: TextSpan(
                      text:
                          'For each email list that emails you, we show you a rating which we call a ',
                      children: [
                    TextSpan(
                        text: 'Security score.',
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
              Padding(
                padding: EdgeInsets.only(top: spacing),
              ),
              Text('The security score is determined by two ratings:'),
              sensitivity != null
                  ? DecisionCardSpamViewSecurityScore()
                  : Container(),
              Padding(
                padding: EdgeInsets.only(top: spacing),
              ),
              DecisionCardSpamViewSecuritySensivityText(),
              Padding(
                padding: EdgeInsets.only(top: spacing),
              ),
              DecisionCardSpamViewSecurityHackingText(),
              Padding(
                padding: EdgeInsets.only(top: spacing * 2),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(70.w),
                  primary: ConfigColor.orange,
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.w))),
                ),
                child: Text("OK, got it",
                    style: TextStyle(
                        fontSize: 13.5.sp, fontWeight: FontWeight.w800)),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Padding(
                padding: EdgeInsets.only(top: spacing * 3),
              ),
            ])));
  }

  _getInfoIcon(BuildContext context) {
    return WidgetSpan(child:
      Padding(padding:EdgeInsets.only(left:6.sp, bottom:1.sp),
      child: GestureDetector(child:
      Icon(Icons.info_outline_rounded,
      color: ConfigColor.greyFour),
      onTap: () => showModal(context),)));
    }
}

class DecisionCardSpamViewSecurityHackingText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text('HACKING SCORE', style: TextStyle(color:ConfigColor.greyThree)),
          Text('A rating based on known recent security breaches/hacks (from www.XXXXXXXXX.com)')
        ]
    );
  }
}

class DecisionCardSpamViewSecuritySensivityText extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text('SENSITIVITY SCORE'),
          Text('A rating based on the sensitivity of the business emailing you, for example whether they are holding medical or financial information vs a clothing company. We find this information at www.XXXXXXXXX.com.')
        ]
    );
  }
}

class DecisionCardSpamViewSecurityEmpty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Text('We’re sorry that we cannot provide you with a security score for this email list right now. Find out more info about security score below.', style: TextStyle(color:ConfigColor.tikiRed));
  }

}

class DecisionCardSpamViewSecurityScore extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: [
        Center(child: HelperImage("vertical-separator", height: 12.h)),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecisionCardSpamViewSecurityScoreNumbers(7, 'SENSITIVITY'),
          DecisionCardSpamViewSecurityScoreNumbers(6, 'HACKING'),
        ])
    ])]);
  }
}

class DecisionCardSpamViewSecurityScoreNumbers extends StatelessWidget{
  final score;
  final text;

  const DecisionCardSpamViewSecurityScoreNumbers(this.score, this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        Text("${this.score} / 10", style: TextStyle(color:ConfigColor.tikiBlue, fontSize: 30.sp)),
        Text(this.text, style: TextStyle(color:ConfigColor.greyFive, fontSize: 15.sp))
      ]
    );
  }

}
