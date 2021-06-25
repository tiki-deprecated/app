import 'package:app/src/slices/gmail_data_screen/gmail_data_screen_service.dart';

class GmailDataScreenPresenter {
  final GmailDataScreenService service;

  GmailDataScreenPresenter(this.service);
}

// "coverData": {
// 'topHeader': Row(
// mainAxisAlignment: MainAxisAlignment.start, children: [
// Expanded(
// child: Row(children: [
// HelperImage("gmail-round-logo", width: 6.w),
// Padding(padding: EdgeInsets.only(right: 2.w)),
// Text(
// "Your Gmail account",
// style: TextStyle(
// fontFamily: "NunitoSans",
// fontSize: 1.8.h,
// fontWeight: FontWeight.w800,
// color: ConfigColor.tikiBlue),
// )
// ])),
// GestureDetector(
// onTap: () =>
// _shareCard(
// message:
// "Gmail knows where you are when you read your emails. It's your data, start taking it back on https://www.mytiki.com",
// image: 'socialmedia1.png'),
// child: Icon(Icons.share, color: ConfigColor.orange, size: 40))
// ]),
// 'image': "where-you-are",
// 'subtitle': "Gmail knows...",
// 'bigTextLighter': 'Where you are ',
// 'bigTextDarker': 'when you read your emails.',
// 'subText':
// "Your Gmail account tracks your location when you open your emails...\nEvery single time you do it."
// },
// "cardData": {
// 'cardContentData': {
// 'richTextExplanation': RichText(
// text: TextSpan(
// style: TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.bold,
// fontSize: 2.h,
// fontFamily: "NunitoSans"),
// text: "Gmail records your ",
// children: [
// TextSpan(
// recognizer: TapGestureRecognizer()
// ..onTap = () =>
// _launchUrl(
// "https://en.wikipedia.org/wiki/IP_address"),
// style: TextStyle(
// color: ConfigColor.orange,
// fontWeight: FontWeight.bold,
// fontSize: 2.h,
// fontFamily: "NunitoSans"),
// text: "IP address",
// children: [
// TextSpan(
// style: TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.w400,
// fontSize: 2.sp,
// fontFamily: "NunitoSans"),
// text:
// " every time you open your inbox or send an email.\n\nMost Google products and almost all email services do this. Some, like Outlook, but NOT Gmail, will even send your IP address to the person receiving your email.\n\nThe most common use approximates your location, pinpointing you within 3-5 miles anywhere in the world. In extreme cases, like criminal investigations, your IP address can be tied to your exact device and location by working with an Internet Service Provider.",
// )
// ])
// ])),
// 'theysay': [
// {
// 'image': "info-badge",
// 'text': "Security monitoring to suspicious access"
// },
// {
// 'image': "search-graph",
// 'text': "Analyzing patterns to develop new features and products"
// },
// ],
// 'youShouldKnow': [
// {
// 'image': "np-tap",
// 'text':
// "Used advertisers for location-based targeting and surveillance"
// },
// {'image': "badge", 'text': "Used by law enforcement"},
// {
// 'image': "worldwide",
// 'text': "Saved for 9 months, then obscured and kept permanently"
// }
// ]
// },
// 'cardCtaData': {
// 'richTextExplanation': RichText(
// text: TextSpan(
// style: TextStyle(
// color: ConfigColor.tikiBlue,
// fontWeight: FontWeight.w500,
// fontSize: 2.h,
// fontFamily: "NunitoSans"),
// text: "You can use a ",
// children: [
// TextSpan(
// recognizer: TapGestureRecognizer()
// ..onTap = () => _launchUrl('https://nordvpn.com'),
// style: TextStyle(
// color: ConfigColor.orange,
// fontWeight: FontWeight.w500,
// fontSize: 2.h,
// fontFamily: "NunitoSans"),
// text: "VPN",
// children: [
// TextSpan(
// style: TextStyle(
// color: ConfigColor.tikiBlue,
// fontWeight: FontWeight.w400,
// fontSize: 2.sp,
// fontFamily: "NunitoSans"),
// text:
// " to hide your IP address or, for true anonymity, switch to an ",
// children: [
// TextSpan(
// recognizer: TapGestureRecognizer()
// ..onTap = () =>
// _launchUrl('https://protonmail.com'),
// style: TextStyle(
// color: ConfigColor.orange,
// fontWeight: FontWeight.bold,
// fontSize: 2.sp,
// fontFamily: "NunitoSans"),
// text: "encrypted email service",
// children: [
// TextSpan(
// style: TextStyle(
// color: ConfigColor.tikiBlue,
// fontWeight: FontWeight.w400,
// fontSize: 2.sp,
// fontFamily: "NunitoSans"),
// text:
// ".\n\nGmail does not currently use additional location services, here’s how to  ",
// children: [
// TextSpan(
// // just left if here to know when to reactivate
// //recognizer: TapGestureRecognizer()..onTap = () => _launchUrl('https://mytiki.com/blog/how-to-block-location-services'),
// style: TextStyle(
// color: ConfigColor.tikiBlue,
// fontWeight: FontWeight.bold,
// fontSize: 2.sp,
// fontFamily: "NunitoSans"),
// text: "block them",
// children: [
// TextSpan(
// style: TextStyle(
// color: ConfigColor
//     .tikiBlue,
// fontWeight: FontWeight
//     .w400,
// fontSize: 2.sp,
// fontFamily: "NunitoSans"),
// text:
// ".\n\nIf you just hate the ads, you can turn off ad personalization for your entire Google account. ",
// )
// ])
// ])
// ])
// ])
// ])
// ])),
// 'buttonText': "AD PERSONALIZATION",
// 'btnAction': () => _launchUrl("https://adssettings.google.com")
// }
// }
// },
// {        "coverData": {
// 'topHeader': Row(mainAxisAlignment: MainAxisAlignment.start, children: [
// Expanded(
// child: Row(children: [
// HelperImage("gmail-round-logo", width: 25),
// Padding(padding: EdgeInsets.only(right: 8)),
// Text(
// "Your Gmail account",
// style: TextStyle(
// fontFamily: "NunitoSans",
// fontSize: 1.8.h,
// fontWeight: FontWeight.w800,
// color: ConfigColor.tikiBlue),
// )
// ])),
// GestureDetector(
// onTap: () =>
// _shareCard(
// message:
// "Gmail knows what you've written to your friends. Find out more on https://www.mytiki.com",
// image: 'socialmedia2.png'),
// child: Icon(Icons.share, color: ConfigColor.orange, size: 40))
// ]),
// 'image': "what-written",
// 'subtitle': "Gmail knows...",
// 'bigTextLighter': 'What you’ve written to ',
// 'bigTextDarker': 'your friends',
// 'subText':
// "Gmail has all emails you’ve ever written to anyone. They look at the content in the emails, so they know you better."
// },
// cardData: {
// 'cardContentData': {
// 'richTextExplanation': RichText(
// text: TextSpan(
// style: TextStyle(
// color: Colors.white,
// fontSize: 2.h,
// fontFamily: "NunitoSans"),
// text:
// "Gmail has access to your emails - it reads, stores and analyzes them.\n\nGoogle uses this information for targeted ads and what they call “smart features” like automatically adding your flight information to your calendar.\n\nIn their own words:\n",
// children: [
// TextSpan(
// style: TextStyle(
// color: ConfigColor.white,
// fontStyle: FontStyle.italic,
// fontSize: 2.h,
// fontFamily: "NunitoSans"),
// text:
// "”Google places advertising on Gmail based on key words that appear in messages transmitted through our system (it's a good example of ads helping to pay for the free services we all enjoy online) - so if you're emailing a friend about a trip to Paris, for example, ads might appear on the right hand side of the page for trains to France...”",
// children: [
// TextSpan(
// style: TextStyle(
// color: Colors.white,
// fontSize: 2.h,
// fontFamily: "NunitoSans"),
// text: "\n\nCreepy.",
// )
// ])
// ])),
// 'theysay': [
// {
// 'image': "airplane",
// 'text': "Travel assistance like itineraries, updates, and maps."
// },
// {
// 'image': "email",
// 'text':
// "Smart email with suggestions, nudges, prioritization, and filtering"
// },
// {
// 'image': "package",
// 'text': "Track packages, reservations, loyalty cards, and bills"
// },
// ],
// 'youShouldKnow': [
// {
// 'image': "np-tap",
// 'text': "Used by advertisers for key word targetting"
// },
// {'image': "hammer", 'text': "Used by law enforcement"},
// {'image': "worldwide", 'text': "Disabled by default in Europe"}
// ]
// },
// 'cardCtaData': {
// 'richTextExplanation': RichText(
// text: TextSpan(
// style: TextStyle(
// color: ConfigColor.tikiBlue,
// fontWeight: FontWeight.w500,
// fontSize: 2.h,
// fontFamily: "NunitoSans"),
// text: "You can turn off both,",
// children: [
// TextSpan(
// recognizer: new TapGestureRecognizer()
// ..onTap = () =>
// _launchUrl(
// "https://support.google.com/mail/answer/10079371"),
// style: TextStyle(
// color: ConfigColor.orange,
// fontWeight: FontWeight.w500,
// fontSize: 2.h,
// fontFamily: "NunitoSans"),
// text: " ad personalization ",
// children: [
// TextSpan(
// style: TextStyle(
// color: ConfigColor.tikiBlue,
// fontWeight: FontWeight.w400,
// fontSize: 2.sp,
// fontFamily: "NunitoSans"),
// text:
// "and “smart features” to stop Google from scanning your emails.",
// )
// ])
// ])),
// 'buttonText': "STOP READING MY EMAILS",
// 'btnAction': () =>
// _launchUrl("https://support.google.com/mail/answer/10079371")
// }
// },
// ),
// "coverData": {
// 'topHeader': Row(mainAxisAlignment: MainAxisAlignment.start, children: [
// Expanded(
// child: Row(children: [
// HelperImage("gmail-round-logo", width: 25),
// Padding(padding: EdgeInsets.only(right: 8)),
// Text(
// "Your Gmail account",
// style: TextStyle(
// fontFamily: "NunitoSans",
// fontSize: 1.8.h,
// fontWeight: FontWeight.w800,
// color: ConfigColor.tikiBlue),
// )
// ])),
// GestureDetector(
// onTap: () =>
// _shareCard(
// message:
// "Gmail knows what you've written to your friends. Find out more on https://www.mytiki.com",
// image: 'socialmedia2.png'),
// child: Icon(Icons.share, color: ConfigColor.orange, size: 40))
// ]),
// 'image': "everything-you-do",
// 'subtitle': "Gmail knows...",
// 'bigTextLighter': "Everything\n",
// 'bigTextDarker': 'you do in your Gmail app',
// 'subText':
// "Your Gmail app has quite a lot of analytics packed in and knows quite a few things...."
// },
// },{
// "cardData": {
// 'cardContentData': {
// 'richTextExplanation': RichText(
// text: TextSpan(
// style: TextStyle(
// color: Colors.white,
// fontSize: 2.h,
// fontFamily: "NunitoSans"),
// text:
// "Gmail’s app is designed to track most of the things you do with it. It tracks each action you take, on which device, OS, and time of day.\n\nFor example, when you opened the app, what you searched for and if you saw an ad were all tracked.\n\nYour audio is recorded if you use voice search or assistant with Gmail.",
// )),
// 'theysay': [
// {'image': "person-4", 'text': "Personalized experiences"},
// {
// 'image': "circle-badge",
// 'text': "App and content recommendations"
// },
// {'image': "search", 'text': "Faster Search"},
// ],
// 'youShouldKnow': [
// {
// 'image': "hat-n-glasses",
// 'text': "Your activity is tracked even when logged out"
// },
// {'image': "badge", 'text': "Used by law enforcement"},
// {
// 'image': "bomb",
// 'text':
// "You can set your history to auto delete after 3, 18, or 36 months"
// }
// ]
// },
// 'cardCtaData': {
// 'richTextExplanation': RichText(
// text: TextSpan(
// style: TextStyle(
// color: ConfigColor.tikiBlue,
// fontWeight: FontWeight.w500,
// fontSize: 2.h,
// fontFamily: "NunitoSans"),
// text:
// "You can delete all activities, individual activities, set it to auto-delete, or disable activity tracking entirely.",
// )),
// 'buttonText': "MY ACTIVITY",
// 'btnAction': () => _launchUrl("https://myactivity.google.com")
// }
// }}
// ];
// }
//
//
