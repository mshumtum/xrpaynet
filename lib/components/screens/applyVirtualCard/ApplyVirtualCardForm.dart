import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_input_filed.dart';
import 'package:xr_paynet/theme/Colors.dart';

class ApplyVirtualCardForm extends StatefulWidget {
  static const String routeName = '/apply_virtual_card_form';

  const ApplyVirtualCardForm({super.key});

  @override
  State<ApplyVirtualCardForm> createState() => _ApplyVirtualCardFormState();
}

class _ApplyVirtualCardFormState extends State<ApplyVirtualCardForm> {
  String selectedCountry = "1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: Column(children: [
        const Header(
          title: "Virtual Card Application",
        ),
        SingleChildScrollView(
          child: Column(children: [
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
            PhoneNumField(
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
                onSendClick: () {}),
          ]),
        )
      ]),
    );
  }
}
