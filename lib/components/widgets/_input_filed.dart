import 'package:flutter/material.dart';
import 'package:xr_paynet/components/widgets/_heading_text.dart';
import 'package:xr_paynet/theme/AppTheme.dart';

import '../../theme/Colors.dart';

class InputField extends StatefulWidget {
  final String inputLabel;
  final String hintText;
  final TextInputType inputType;
  final Function(String)? onChangeText;
  const InputField(
      {super.key,
      this.inputLabel = "",
      required this.hintText,
      this.inputType = TextInputType.name,
      this.onChangeText});

  @override
  _InputFieldState createState() => _InputFieldState();

  // Define a static method to get the text value
  // String getText() {
  //   onChangeText!(_InputFieldState.textValue);
  //   return _InputFieldState.textValue;
  // }
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
              style: const TextStyle(color: Colors.white, fontSize: 14.0),
              maxLines: 1,
              onChanged: (value) {
                // setState(() {
                //   textValue = value;
                // });
                widget.onChangeText!(value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: const TextStyle(color: AppClr.grey2),
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

class PhoneNumField extends StatefulWidget {
  final String inputLabel;
  final String hintText;
  final String countryCode;
  final TextInputType inputType;
  final Function(String)? onChangeText;
  final bool isPhonePicker;
  final Function()? onPickerClick;
  final Function()? onSendClick;
  const PhoneNumField(
      {super.key,
      this.inputLabel = "",
      this.hintText = "",
      this.countryCode = "",
      this.inputType = TextInputType.name,
      this.onChangeText,
      this.isPhonePicker = false,
      this.onPickerClick,
      this.onSendClick});

  @override
  State<PhoneNumField> createState() => _PhoneNumFieldState();
}

class _PhoneNumFieldState extends State<PhoneNumField> {
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
                color: AppClr.inputFieldBg,
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                widget.isPhonePicker
                    ? Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: widget.onPickerClick,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 10),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              color: Colors.blue,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("+${widget.countryCode}",
                                    style: AppTheme.white14Regular),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: myController,
                    cursorColor: Colors.white,
                    style: AppTheme.white14Regular,
                    maxLines: 1,
                    maxLength: 15,
                    onChanged: (value) {
                      widget.onChangeText!(value);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      hintStyle: const TextStyle(color: AppClr.grey2),
                      hintText: widget.hintText,
                      fillColor: AppClr.inputFieldBg,
                      counterText: "",
                    ),
                    keyboardType: widget.inputType,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(9),
                              bottomRight: Radius.circular(9)),
                          color: AppClr.inputFieldBg,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: ElevatedButton(
                            onPressed: widget.onSendClick,
                            child: const Text(
                              "Send Code",
                              style: AppTheme.white14Regular,
                            ),
                          ),
                        ))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
