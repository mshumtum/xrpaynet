import 'package:flutter/material.dart';
import 'package:xr_paynet/components/widgets/_heading_text.dart';

import '../../theme/Colors.dart';

class InputField extends StatefulWidget {
  final String inputLabel;
  final String hintText;
  final TextInputType inputType;

  const InputField({
    super.key,
    this.inputLabel = "",
    required this.hintText,
    required this.inputType,
  });

  @override
  _InputFieldState createState() => _InputFieldState();

  // Define a static method to get the text value
  static String getText() {
    return _InputFieldState.textValue;
  }
}

class _InputFieldState extends State<InputField> {
  final myController = TextEditingController();
  static String textValue = '';
  bool _obscureText = true;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppClr.inputFieldBg,
            ),
            child: TextField(
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
              ),
              keyboardType: widget.inputType,
            ),
          ),
        ),
      ],
    );
  }
}
