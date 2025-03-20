import 'dart:math';
import 'package:flutter/material.dart';

class CustomCaptcha extends StatefulWidget {
  final Function(bool) onValidated;

  const CustomCaptcha({
    Key? key,
    required this.onValidated,
  }) : super(key: key);

  @override
  State<CustomCaptcha> createState() => _CustomCaptchaState();
}

class _CustomCaptchaState extends State<CustomCaptcha> {
  late String _captchaText;
  final TextEditingController _controller = TextEditingController();
  bool _isValid = false;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _generateCaptcha();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _generateCaptcha() {
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    _captchaText = String.fromCharCodes(
      Iterable.generate(6, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
    );
  }

  void _validateCaptcha() {
    setState(() {
      _isValid = _controller.text == _captchaText;
      widget.onValidated(_isValid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 302,
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        border: Border.all(
          color: Color(0xFFD6D6D6),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Captcha Text Container
          Container(
            padding: EdgeInsets.symmetric(vertical: 12), // Reduced from 16
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Reduced from 20,12
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xFFD6D6D6),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _captchaText,
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 16, // Reduced from 20
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3, // Reduced from 4
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                IconButton(
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: Color(0xFFC1C1C1),
                    size: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      _generateCaptcha();
                      _controller.clear();
                      _isValid = false;
                      widget.onValidated(false);
                    });
                  },
                ),
              ],
            ),
          ),

          // Input Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Product Sans',
                fontSize: 14,
                color: Color(0xFF000000),
              ),
              decoration: InputDecoration(
                hintText: 'Enter the code above',
                hintStyle: TextStyle(
                  fontFamily: 'Product Sans',
                  fontSize: 14,
                  color: Color(0xFF757575),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: Color(0xFFD6D6D6),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: Color(0xFFC1C1C1),
                    width: 1,
                  ),
                ),
              ),
              onChanged: (value) {
                if (value.length == _captchaText.length) {
                  _validateCaptcha();
                } else {
                  setState(() {
                    _isValid = false;
                    widget.onValidated(false);
                  });
                }
              },
            ),
          ),

          // Checkbox Container (existing code)
          Container(
            width: 302,
            height: 74,
            decoration: BoxDecoration(
              color: Color(0xFFFAFAFA),
              border: Border.all(
                color: Color(0xFFD6D6D6),
                width: 1,
              ),
            ),
            child: Stack(
              children: [
                // Checkbox and Text
                Positioned(
                  left: 12,
                  top: (74 - 24) / 2,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value ?? false;
                              widget.onValidated(isChecked);
                            });
                          },
                          side: BorderSide(
                            color: Color(0xFFC1C1C1),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                      Text(
                        "I'm not a robot",
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // ReCaptcha Image
                Positioned(
                  right: 10,
                  top: (74 - 59) / 2,
                  child: Image.asset(
                    'public/assets/images/recaptcha.png',
                    width: 56,
                    height: 59,
                    fit: BoxFit.contain,
                  ),
                ),

                // Invisible button for the entire container
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isChecked = !isChecked;
                          widget.onValidated(isChecked);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}