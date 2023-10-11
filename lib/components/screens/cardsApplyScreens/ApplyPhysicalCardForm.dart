import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/activationFeesScreens/LifeStylePlusFees.dart';
import 'package:xr_paynet/components/screens/chooseOptionScreens/ChooseCountry.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_bottom_sheets.dart';
import 'package:xr_paynet/components/widgets/_gender_selection.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_input_filed.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/Colors.dart';
import '../../../theme/AppTheme.dart';
import '../../widgets/_button_primary.dart';
import '../../widgets/_heading_text.dart';

class ApplyPhysicalCardForm extends StatefulWidget {
  static const String routeName = '/apply_virtual_card_form';

  const ApplyPhysicalCardForm({Key? key, required String arguments})
      : super(key: key);

  @override
  State<ApplyPhysicalCardForm> createState() => _ApplyPhysicalCardFormState();
}

class _ApplyPhysicalCardFormState extends State<ApplyPhysicalCardForm> {
  final NavigationService _navigationService = locator<NavigationService>();

  String selectedCountry = "1";
  String selectedCountryName = "England";
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: SingleChildScrollView(
        child: Column(children: [
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
                  const InputField(
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
                  const HeadingText(
                    title: 'Gender',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _genderSelection(),
                  const SizedBox(
                    height: 16,
                  ),
                  const HeadingText(
                    title: 'Country',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _countrySelected(),
                  const SizedBox(
                    height: 16,
                  ),
                  const InputField(
                    inputLabel: "Province",
                    hintText: 'Texas',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const InputField(
                    inputLabel: "City",
                    hintText: 'Texas',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const InputField(
                    inputLabel: "Street Address",
                    hintText: 'Housetown1123',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const InputField(
                    inputLabel: "Postcode",
                    hintText: 'Enter Code',
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
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
                                _navigationService.navigateWithNoBack(
                                    LifeStylePlusFees.routeName);
                              },
                            );
                          },
                        );
                      },
                    ),
                  )
                ]),
          )
        ]),
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

  Widget _genderSelection() {
    return GenderSelection(
      selectedValue: (value) {
        print(value);
      },
    );
  }

  Widget _countrySelected() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                  builder: (_) => const ChooseCountry(),
                  fullscreenDialog: true),
            )
            .then((val) => {
                  setState(() {
                    selectedCountryName = val;
                  })
                });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          width: ClassMediaQuery.screenWidth,
          height: 50,
          padding: const EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppClr.inputFieldBg,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedCountryName,
                style: const TextStyle(
                    color: AppClr.grey,
                    fontSize: 14,
                    fontFamily: AppTheme.fontRegular),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppClr.grey,
                size: 15, // Change the icon color as needed
              ),
            ],
          ),
        ),
      ),
    );
  }
}
