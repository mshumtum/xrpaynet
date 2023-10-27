import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:phone_number/phone_number.dart';
import 'package:xr_paynet/components/screens/activationFeesScreens/LSPFeeByLockXRP.dart';
import 'package:xr_paynet/components/screens/activationFeesScreens/LifeStylePlusFees.dart';
import 'package:xr_paynet/components/screens/chooseOptionScreens/ChooseCountry.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/utilities/utility.dart';
import 'package:xr_paynet/components/widgets/_bottom_sheets.dart';
import 'package:xr_paynet/components/widgets/_gender_selection.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_input_filed.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/cubits/card_apply_cubit/applyPhysicalCardCubit.dart';
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
  final ApplyPhysicalCardCubit _applyPhysicalCardCubit =
      locator<ApplyPhysicalCardCubit>();
  String selectedCountryName = "England";
  bool isSelected = true;
  String selectedCountry = "91",
      countryName = "IN",
      firstName = "",
      lastName = "",
      phoneSecurityCode = "",
      emailSecurityCode = "";
  bool isPhoneNumberValid = false, isClubCard = true;

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email =
      TextEditingController(text: "munish.antier@gmail.com");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: SingleChildScrollView(
        child: Column(children: [
          const Header(
            title: "Card Application",
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
                    onChangeText: (value) {
                      setState(() {
                        firstName = value;
                      });
                    },
                    maxLength: 50,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InputField(
                    inputLabel: "Last Name",
                    hintText: 'Enter last name here',
                    onChangeText: (value) {
                      setState(() {
                        lastName = value;
                      });
                    },
                    maxLength: 50,
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
                  InputField(
                    inputLabel: "Province",
                    hintText: 'Texas',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InputField(
                    inputLabel: "City",
                    hintText: 'Texas',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InputField(
                    inputLabel: "Street Address",
                    hintText: 'Housetown1123',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InputField(
                    inputLabel: "Postcode",
                    hintText: 'Enter Code',
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 2, right: 2, top: 40, bottom: 20),
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
                                if (value == "wallet") {
                                  _navigationService.navigateWithBack(
                                      LifeStylePlusFees.routeName,
                                      arguments: {
                                        "isFrom": "lifestyleVirtual",
                                        "cardType": "physical"
                                      });
                                } else {
                                  _navigationService.navigateWithBack(
                                      LSPFeeByLockXRP.routeName,
                                      arguments: {
                                        "isFrom": "lifestyleVirtual",
                                        "cardType": "physical"
                                      });
                                }
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
        myController: phoneNumber,
        onPickerClick: () {
          showCountryPicker(
            context: context,
            onSelect: (Country country) {
              setState(() {
                phoneNumber.text = "";
                selectedCountry = country.phoneCode;
                countryName = country.countryCode;
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
        onSendClick: () async {
          // validate is number valid or not
          try {
            bool isValidNum = await PhoneNumberUtil().validate(
              selectedCountry + phoneNumber.text,
              regionCode: countryName,
            );
            setState(() {
              isPhoneNumberValid = isValidNum;
            });
            print("xfklmd=====${Constants.userAccessToken}");

            if (isValidNum) {
              // _applyVirtualCardCubit.sendOTPForVerification(
              //     medium: phoneNumber.text, type: "mobile");
            } else {
              showError(context, "Please enter valid phone number.");
            }
          } catch (err) {
            showError(context, "Please enter valid phone number.");
          }
        });
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
        myController: phoneNumber,
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
              const Icon(
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
