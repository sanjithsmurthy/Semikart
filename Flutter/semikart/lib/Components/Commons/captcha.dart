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
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE4E8EC)),
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  _captchaText,
                  style: TextStyle(
                    fontFamily: 'Product Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Color(0xFFA51414),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.refresh, color: Color(0xFFA51414)),
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
          SizedBox(height: 16.0),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter the code above',
              hintStyle: TextStyle(
                fontFamily: 'Product Sans',
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(color: Color(0xFFE4E8EC)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(color: Color(0xFFE4E8EC)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(color: Color(0xFFA51414)),
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
          SizedBox(height: 8.0),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: _controller.text.isNotEmpty
                ? Text(
                    _isValid ? 'Correct!' : 'Incorrect, try again',
                    style: TextStyle(
                      color: _isValid ? Colors.green : Colors.red,
                      fontFamily: 'Product Sans',
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}