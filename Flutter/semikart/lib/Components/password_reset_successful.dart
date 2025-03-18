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
//       child: Column(
        
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
        
        
//         children: [

//         Positioned(
//           top:234,
//           left:124,
//           child: SvgPicture.asset(
//           'public/assets/images/success.svg',
//            width: 164,
//            height:164,
//         ), 
//         ), // 1st child in cloumn (success svg)
        
//         SizedBox(height:13), //spacing after success svg

//         Positioned(
//           top: 411,
//           left: 164,
//           child: Text(
//             'Success',
//             style: TextStyle(
//               fontFamily: 'ProductSans',
//               fontSize: 22,
//               color: Color.fromRGBO(0, 0, 0, 1),
//             ),
//           ),
//         ), // 2nd child in column (Password Reset Successful)

//         Positioned(
//           top:484,
//           left: 75,
//           child: Text(
//             'Congratulations! You have been successfully authenticated',
//             style: TextStyle(
//               fontFamily: 'ProductSans',
//               fontSize: 18,
//               color: Color.fromRGBO(182, 182, 182, 1),
//             ),
//           ),
//         ), //3rd child in column

//         Positioned(
//           top:574,
//           left:35,
//           child: ElevatedButton(
//             onPressed: (){
//               Navigator.push(
//                 context,

//                 MaterialPageRoute(builder: builder: (context) => semikart_home()),

//               );
//             },
//           ),
//         ),

//         ]
//       ),
//      )
//   };

// };