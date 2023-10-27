import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/utilities/Debouncer.dart';
import 'package:xr_paynet/components/widgets/_heading_text.dart';
import 'package:xr_paynet/theme/AppTheme.dart';

import '../../theme/Colors.dart';

class InputField extends StatefulWidget {
  final String inputLabel;
  final String hintText;
  final int maxLength;
  final bool readOnly;
  final TextInputType inputType;
  final Function(String)? onChangeText;
  final Function()? onClick;

  InputField(
      {super.key,
      this.inputLabel = "",
      required this.hintText,
      this.inputType = TextInputType.name,
      this.onChangeText,
      this.readOnly = false,
      this.onClick,
      this.maxLength = 60});

  @override
  _InputFieldState createState() => _InputFieldState();
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
          child: TextField(
            controller: myController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white, fontSize: 14.0),
            maxLines: 1,
            onChanged: widget.onChangeText,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: const TextStyle(color: AppClr.grey2),
                hintText: widget.hintText,
                fillColor: AppClr.inputFieldBg,
                counterText: ""),
            keyboardType: widget.inputType,
            maxLength: widget.maxLength,

            // maxLength: widget.maxLength,
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
  final int maxLength;
  final bool readOnly;
  final TextInputType inputType;
  final TextEditingController myController;
  final Function(String)? onChangeText;
  final bool isPhonePicker;
  final Function()? onPickerClick;
  final Function()? onSendClick;

  const PhoneNumField(
      {super.key,
      this.inputLabel = "",
      this.hintText = "",
      this.countryCode = "",
      this.inputType = TextInputType.phone,
      this.onChangeText,
      this.isPhonePicker = false,
      this.readOnly = false,
      this.maxLength = 150,
      this.onPickerClick,
      required this.myController,
      this.onSendClick});

  @override
  State<PhoneNumField> createState() => _PhoneNumFieldState();
}

class _PhoneNumFieldState extends State<PhoneNumField> {
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                vertical: 15, horizontal: 10),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              color: AppClr.blue,
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
                  flex: widget.isPhonePicker ? 5 : 7,
                  child: TextFormField(
                    controller: widget.myController,
                    cursorColor: Colors.white,
                    style: AppTheme.white14Regular,
                    maxLines: 1,
                    maxLength: widget.maxLength,
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
                    readOnly: widget.readOnly,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: widget.onSendClick,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Send Code",
                          style: AppTheme.white14Regular,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OtpTextField extends StatefulWidget {
  final String label;
  final Function(String value)? onOtpComplete;

  const OtpTextField({
    super.key,
    this.label = "",
    this.onOtpComplete,
  });

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != ""
            ? HeadingText(
                title: widget.label,
              )
            : Container(),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: OTPTextField(
            length: 4,
            width: ClassMediaQuery.screenWidth,
            fieldWidth: 80,
            style: AppTheme.white16w500,
            otpFieldStyle: OtpFieldStyle(
                backgroundColor: AppClr.otpBackground,
                focusBorderColor: AppClr.blue),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.box,
            outlineBorderRadius: 10,
            onCompleted: (pin) {
              widget.onOtpComplete!(pin);
              print("Completed: " + pin);
            },
          ),
        )
      ],
    );
  }
}

class SearchField extends StatefulWidget {
  final String inputLabel;
  final String hintText;
  final TextInputType inputType;
  final Function(String)? onSearchText;

  const SearchField(
      {super.key,
      this.inputLabel = "",
      required this.hintText,
      this.inputType = TextInputType.name,
      this.onSearchText});

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final myController = TextEditingController();
  static String textValue = '';
  bool _obscureText = true;
  final _debouncer = Debouncer(milliseconds: 500);

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
              autofocus: true,
              controller: myController,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white, fontSize: 14.0),
              maxLines: 1,
              onChanged: (value) {
                // setState(() {
                //   textValue = value;
                // });
                _debouncer.run(() => {widget.onSearchText!(value)});
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: AppClr.white),
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
