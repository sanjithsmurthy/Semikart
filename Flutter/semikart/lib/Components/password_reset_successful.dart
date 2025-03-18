// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class successpage extends StatelessWidget{

//   @override
//   Widget build(BuildContext){
//      return Container(
//       width: 412,
//       height: 917,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(30),
//         color: Color.fromRGBO(255, 255, 255, 1),
//       ),
//     child: Builder(
//       builder: (context) => Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SvgPicture.asset(
//             'public/assets/images/success.svg',
//             width: 164,
//             height: 164,
//           ), // 1st child in column (success svg)
//           SizedBox(height: 13), // spacing after success svg
//           Text(
//             'Success',
//             style: TextStyle(
//               fontFamily: 'ProductSans',
//               fontSize: 22,
//               color: Color.fromRGBO(0, 0, 0, 1),
//             ),
//           ), // 2nd child in column (Password Reset Successful)
//           SizedBox(height: 20), // spacing after success text
//           Text(
//             'Congratulations! You have been successfully authenticated',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontFamily: 'ProductSans',
//               fontSize: 18,
//               color: Color.fromRGBO(182, 182, 182, 1),
//             ),
//           ), // 3rd child in column
//           SizedBox(height: 40), // spacing after message
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => semikart_home()),
//               );
//             },
//             child: Text('Go to Home'),
//           ),
//         ],
//       ),
//     );
//   }

// }