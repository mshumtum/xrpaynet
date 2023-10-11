import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:xr_paynet/theme/Colors.dart';

import '../../widgets/_button_primary.dart';
import '../../widgets/_header.dart';
import '../../widgets/_input_filed.dart';

class ApplyVirtualCardForm extends StatefulWidget {
  static const String routeName = '/virtual_card';

  const ApplyVirtualCardForm({Key? key, required String arguments})
      : super(key: key);

  @override
  State<ApplyVirtualCardForm> createState() => _ApplyVirtualCardFormState();
}

class _ApplyVirtualCardFormState extends State<ApplyVirtualCardForm> {
  String selectedCountry = "1";
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(
              title: "Virtual Card Application",
            ),
            SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 31,
                    ),
                    InputField(
                        inputLabel: "First Name",
                        hintText: 'Enter first name here',
                        onChangeText: (value) {}),
                    const SizedBox(
                      height: 16,
                    ),
                     InputField(
                      inputLabel: "Last Name",
                      hintText: 'Enter last name here',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _phoneNum(),
                    _otpField(),
                    const SizedBox(
                      height: 16,
                    ),
                    _emailField(),
                    _otpField(),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 40),
                      child: ButtonPrimary(
                        title: "Confirm and Pay",
                        onClick: () {},
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _phoneNum() {
    return PhoneNumField(
        inputLabel: "Phone Number",
        hintText: 'Phone Number',
        isPhonePicker: true,
        countryCode: selectedCountry,
        onPickerClick: () {
          showCountryPicker(
            context: context,
            onSelect: (Country country) {
              setState(() {
                selectedCountry = country.phoneCode;
              });
            },
            showPhoneCode: true,
          );
        },
        onSendClick: () {});
  }

  Widget _otpField() {
    return OtpTextField(
      label: 'Enter Code',
      onOtpComplete: (pin) {
        print(pin);
      },
    );
  }

  Widget _emailField() {
    return PhoneNumField(
        inputLabel: "Email",
        hintText: 'Enter your email',
        isPhonePicker: false,
        countryCode: selectedCountry,
        onPickerClick: () {
          showCountryPicker(
            context: context,
            onSelect: (Country country) {
              setState(() {
                selectedCountry = country.phoneCode;
              });
            },
            showPhoneCode: false,
          );
        },
        onSendClick: () {});
  }
}
