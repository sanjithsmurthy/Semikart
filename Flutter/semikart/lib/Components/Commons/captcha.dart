// import 'package:flutter/material.dart';
// import 'package:flutter_recaptcha_v2/flutter_recaptcha_v2.dart';

// class CaptchaScreen extends StatefulWidget {
//   @override
//   _CaptchaScreenState createState() => _CaptchaScreenState();
// }

// class _CaptchaScreenState extends State<CaptchaScreen> {
//   final RecaptchaV2Controller _recaptchaV2Controller = RecaptchaV2Controller();
//   String captchaResponse = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('reCAPTCHA Example'),
//         backgroundColor: Color(0xFFA51414),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             RecaptchaV2(
//               apiKey: "YOUR_GOOGLE_RECAPTCHA_SITE_KEY", // Replace with your site key
//               apiSecret: "YOUR_GOOGLE_RECAPTCHA_SECRET_KEY", // Replace with your secret key
//               controller: _recaptchaV2Controller,
//               onVerifiedError: (err) {
//                 print(err);
//               },
//               onVerifiedSuccessfully: (success) {
//                 setState(() {
//                   captchaResponse = success ? 'You are verified!' : 'Failed to verify';
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             Text(captchaResponse),
//           ],
//         ),
//       ),
//     );
//   }
// }