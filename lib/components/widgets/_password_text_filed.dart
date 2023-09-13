import 'package:flutter/material.dart';
import 'package:xr_paynet/theme/Colors.dart';

class PasswordTextField extends StatefulWidget {
  final String hintText;

  PasswordTextField({
    required this.hintText,
  });

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = false;
  final myController = TextEditingController();
  static String textValue = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color:  AppClr.inputFieldBg,
        ),
        child: TextField(
          obscureText: _obscureText,//This will obscure text dynamically
          controller: myController,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          maxLines: 1,
          onChanged: (value) {
            setState(() {
              textValue = value;
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: widget.hintText,
            fillColor: AppClr.inputFieldBg,

            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
            ),
          ),

          keyboardType: TextInputType.visiblePassword,
        ),
      ),
    );
  }
}