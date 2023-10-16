import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/activationFeesScreens/LSPFeeByLockXRP.dart';
import 'package:xr_paynet/components/screens/activationFeesScreens/LifeStylePlusFees.dart';
import 'package:xr_paynet/components/widgets/_bottom_sheets.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

import '../../widgets/_button_primary.dart';
import '../../widgets/_header.dart';
import '../../widgets/_input_filed.dart';

class ApplyVirtualCardForm extends StatefulWidget {
  static const String routeName = '/virtual_card';
  final Object? arguments;
  const ApplyVirtualCardForm({Key? key, this.arguments}) : super(key: key);

  @override
  State<ApplyVirtualCardForm> createState() => _ApplyVirtualCardFormState();
}

class _ApplyVirtualCardFormState extends State<ApplyVirtualCardForm> {
  final NavigationService _navigationService = locator<NavigationService>();
  String selectedCountry = "1";
  bool isSelected = true;
  bool isClubCard = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var params = (widget?.arguments as Map);
    if (params["isFrom"] == "lifestyleVirtual") {
      setState(() {
        isClubCard = false;
      });
    }
  }

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
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 40),
                      child: ButtonPrimary(
                        title: "Confirm and Pay",
                        onClick: () {
                          showModalBottomSheet<void>(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return ChoosePaymentOptions(
                                onClick: (value) {
                                  print(value);

                                  var cardScreen = isClubCard
                                      ? "clubVirtual"
                                      : "lifestyleVirtual";

                                  if (value == "wallet") {
                                    _navigationService.navigateWithBack(
                                        LifeStylePlusFees.routeName,
                                        arguments: {
                                          "isFrom": cardScreen,
                                          "cardType": "virtual"
                                        });
                                  } else {
                                    _navigationService.navigateWithBack(
                                        LSPFeeByLockXRP.routeName,
                                        arguments: {
                                          "isFrom": cardScreen,
                                          "cardType": "virtual"
                                        });
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
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
            useSafeArea: true,
            countryListTheme: const CountryListThemeData(
              inputDecoration: InputDecoration(
                hintText: 'Start typing to search',
                hintStyle: AppTheme.greyText14Regular,
                prefixIcon: Icon(Icons.search, color: AppClr.white),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppClr.greyText),
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
              ),
              searchTextStyle: AppTheme.white14Regular,
              backgroundColor: AppClr.black,
              textStyle: AppTheme.white14Regular,
            ),
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
