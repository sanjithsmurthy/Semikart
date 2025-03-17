import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'loginpassword.dart';


class LoginWelcomeScreenWidget extends StatefulWidget {
  @override
  _LoginWelcomeScreenWidgetState createState() => _LoginWelcomeScreenWidgetState();
}

class _LoginWelcomeScreenWidgetState extends State<LoginWelcomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 412,
      height: 917,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color.fromRGBO(255, 255, 255, 1),
    
      ),
      child: Stack( children: <Widget>[ // "Don't have an account?" text and icon
          Positioned(
            top: 639,
            left: 219,
            child: Container(
              width: 170,
              height: 24,
              child: Row(
                children: [
                  Text(
                    'Don\'t have an account?',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color.fromRGBO(34, 34, 34, 1),
                      fontFamily: 'Product Sans',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1.4285714285714286,
                    ),
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    color: Color.fromRGBO(165,20,20,1),
                    child: SvgPicture.asset(
                      'assets/images/vector.svg',
                      semanticsLabel: 'vector',
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // "Forgot Password" text and icon
          Positioned(
            top: 608,
            left: 259,
            child: Container(
              width: 130,
              height: 24,
              child: Row(
                children: [
                  Text(
                    'Forgot Password',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color.fromRGBO(34, 34, 34, 1),
                      fontFamily: 'Product Sans',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1.4285714285714286,
                    ),
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    color: Color.fromRGBO(165,20,20,1),
                    child: SvgPicture.asset(
                      'public/assets/images/vector.svg',
                      semanticsLabel: 'vector',
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Password field
          Positioned(
            top: 517,
            left: 22,
            child: Container(
              width: 367,
              height: 84,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 29),
                    child: Text(
                      'Password',
                      style: TextStyle(
                        color: Color.fromRGBO(165,20,20,1),
                        fontFamily: 'Product Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Text(
                          '**************',
                          style: TextStyle(
                            color: Color.fromRGBO(117, 117, 117, 1),
                            fontFamily: 'Product Sans',
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 20,
                        height: 16,
                        child: SvgPicture.asset(
                          'public/assets/images/vector.svg',
                          semanticsLabel: 'vector',
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Email field
          Positioned(
            top: 413,
            left: 22,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 31),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          color: Color.fromRGBO(165,20,20,1),
                          fontFamily: 'Product Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Johny@gmail.com',
                        style: TextStyle(
                          color: Color.fromRGBO(117, 117, 117, 117),
                          fontFamily: 'Product Sans',
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // OR divider
          Positioned(
            top: 353,
            left: 35,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 151,
                    height: 1,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'OR',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Product Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 151,
                    height: 1,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ],
              ),
            ),
          ),
          
          // Login with OTP button
          Positioned(
            top: 264,
            left: 212,
            child: Container(
              width: 172,
              height: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  )
                ],
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              child: Center(
                child: Text(
                  'Login with OTP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Product Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    height: 1.4285714285714286,
                  ),
                ),
              ),
            ),
          ),
          
          // Sign in with Google button
          Positioned(
            top: 264,
            left: 22,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  )
                ],
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 13, vertical: 9),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 38,
                    height: 38,
                    child: SvgPicture.asset(
                      'public/assets/images/Google.svg',
                      semanticsLabel: 'Google logo',
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Sign in with Google',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Product Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      height: 1.4285714285714286,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Login header text
          Positioned(
            top: 197,
            left: 36,
            child: Text(
              'Login',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Product Sans',
                fontSize: 25,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),


          //semikart logo
          Positioned(
            top: 113,
            left: 36,
            child: Container(
              width: 190,
              height: 28,
              child: SvgPicture.asset(
                'public/assets/images/semikart_logo_medium.svg',
                semanticsLabel: 'Semikart logo',
              ),
            ),
          ),

        ],
      ),
    );
  }
}