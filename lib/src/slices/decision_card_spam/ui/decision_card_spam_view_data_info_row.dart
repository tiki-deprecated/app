import 'package:app/src/config/config_color.dart';
import 'package:flutter/material.dart';

class DecisionCardSpamViewDataInfoRow extends StatelessWidget {
  final sinceYear;
  final totalEmails;

  const DecisionCardSpamViewDataInfoRow(
      {Key? key, this.sinceYear, this.totalEmails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: [
      DecisionCardSpamViewSent(this.totalEmails, this.sinceYear),
      VerticalDivider(),
      DecisionCardSpamViewOpened(25)
    ]));
  }
}

class DecisionCardSpamViewOpened extends StatelessWidget {
  final percent;

  DecisionCardSpamViewOpened(this.percent);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("You've opened"),
        TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: this.percent / 100),
            duration: const Duration(milliseconds: 3500),
            builder: (_, value, __) => Stack(children: [
                  Text("${value.toString()} %"),
                  CircularProgressIndicator(
                      backgroundColor: ConfigColor.greyThree, value: value),
                ])),
        Text("of their emails"),
      ],
    );
  }
}

class DecisionCardSpamViewSent extends StatelessWidget {
  final totalEmails;
  final sinceYear;

  DecisionCardSpamViewSent(this.totalEmails, this.sinceYear);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("They've sent you"),
        Text(this.totalEmails.toString()),
        Text("emails"),
        Container(
            color: ConfigColor.tikiBlue,
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.white),
                Text(" since ${this.sinceYear.toString()}")
              ],
            ))
      ],
    );
  }
}
