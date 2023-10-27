import 'package:flutter/material.dart';
import 'package:xr_paynet/components/widgets/_heading_text.dart';
import 'package:xr_paynet/theme/Colors.dart';

class PasswordTextField extends StatefulWidget {
  final String hintText;
  final String inputLabel;
  final Function(String)? onChangeText;
  final int a;
  PasswordTextField(
      {super.key,
      required this.hintText,
      this.inputLabel = "",
      this.onChangeText,
      this.a = 128});

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.inputLabel != ""
            ? HeadingText(
                title: widget.inputLabel,
              )
            : Container(),
        const SizedBox(
          height: 9,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: TextField(
            obscureText: _obscureText, //This will obscure text dynamically
            controller: myController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            maxLines: 1,
            onChanged: widget.onChangeText,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: AppClr.grey2),
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
                    color: AppClr.grey,
                  ),
                ),
                counterText: ""),
            maxLength: widget.a,
            keyboardType: TextInputType.visiblePassword,
          ),
        ),
      ],
    );
  }
}
