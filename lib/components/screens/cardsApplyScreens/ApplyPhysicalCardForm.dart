import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:phone_number/phone_number.dart';
import 'package:xr_paynet/components/screens/activationFeesScreens/LSPFeeByLockXRP.dart';
import 'package:xr_paynet/components/screens/activationFeesScreens/LifeStylePlusFees.dart';
import 'package:xr_paynet/components/screens/chooseOptionScreens/ChooseCountry.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/utilities/utility.dart';
import 'package:xr_paynet/components/utilities/validators.dart';
import 'package:xr_paynet/components/widgets/_bottom_sheets.dart';
import 'package:xr_paynet/components/widgets/_gender_selection.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_input_filed.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/cubits/base_cubit/base_state.dart';
import 'package:xr_paynet/cubits/card_apply_cubit/applyPhysicalCardCubit.dart';
import 'package:xr_paynet/cubits/user_cubit/response/UserReponse.dart';
import 'package:xr_paynet/cubits/user_cubit/user_cubit.dart';
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
  final UserDataCubit _userDataCubit = locator<UserDataCubit>();

  String selectedCountryName = "United Kingdom";
  bool isSelected = true;
  String selectedCountry = "91",
      countryName = "IN",
      firstName = "",
      lastName = "",
      phoneSecurityCode = "",
      emailSecurityCode = "",
      province = "",
      city = "",
      streetAddress = "",
      postCode = "";
  bool isPhoneNumberValid = false;
  final phoneController = OtpFieldController();
  bool isMaleSelected = true;

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController(text: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      email.text = _userDataCubit.state.main.userData?.userInfo?.email ?? "";

    });
    _applyPhysicalCardCubit.getSupportedCountry();

    if(_userDataCubit.state.main.userData?.cardInfo?.isNotEmpty ?? false){
      int totalCard = _userDataCubit.state.main.userData?.cardInfo?.length ?? 0;
      for(int i = 0; i < totalCard; i++){

        CardInfo? item = _userDataCubit.state.main.userData!.cardInfo?[0];

        if(item?.cardType == "PHYSICAL"){
          print("LENGTH---${item?.firstName}");
          var code = item?.countryCode ?? "" ;

          setState(() {
            firstName=  item?.firstName ?? "";
            lastName=  item?.lastName ?? "";
            phoneNumber.text=  item?.phoneNumber ?? "";
            // countryName=  PhoneNumberUtil().
            selectedCountryName=  item?.country ?? "";
            selectedCountry = code.replaceAll("+", "");
            province=  item?.province ?? "";
            city=  item?.city ?? "";
            streetAddress=  item?.streetAddress ?? "";
            postCode=  item?.postCode ?? "";
          });
          break;
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    hideSnackBar(context);
  }

  bool isValid() {
    return Validators.isNameValid(firstName) &&
        Validators.isNameValid(lastName) &&
        isPhoneNumberValid &&
        phoneSecurityCode.length == 4 &&
        emailSecurityCode.length == 4 &&
        Validators.isValidCityName(province) &&
        Validators.isValidCityName(city) &&
        streetAddress.isNotEmpty &&
        Validators.isValidPostalCode(postCode);
  }

  void onConfirmAndPayPress() {
    // if (!Validators.isNameValid(firstName)) {
    //   showError(context, "Enter valid first name.");
    // } else if (!Validators.isNameValid(lastName)) {
    //   showError(context, "Enter valid last name.");
    // } else if (phoneNumber.text.length < 8) {
    //   showError(context, "Enter valid phone number.");
    // } else if (phoneSecurityCode.length != 4) {
    //   showError(context, "Enter valid OTP for phone number.");
    // } else if (emailSecurityCode.length != 4) {
    //   showError(context, "Enter valid OTP for email.");
    // } else {
    //   _applyPhysicalCardCubit.applyPhysicalCard(
    //       firstName: firstName,
    //       lastName: lastName,
    //       phoneNum: phoneNumber.text,
    //       phoneCode: int.parse(phoneSecurityCode),
    //       email: email.text,
    //       emailCode: int.parse(emailSecurityCode),
    //       countryCode: "+" + selectedCountry);
    // }

    if (isValid()) {
      print("province-----$province, city----$city");
      _applyPhysicalCardCubit.applyPhysicalCard(
        firstName: firstName,
        lastName: lastName,
        phoneNum: phoneNumber.text,
        phoneCode: int.parse(phoneSecurityCode),
        email: email.text,
        emailCode: int.parse(emailSecurityCode),
        countryCode: "+" + selectedCountry,
        gender: isMaleSelected ? "male" : "female",
        country: selectedCountryName,
        province: province,
        city: city,
        streetAddress: streetAddress,
        postCode: postCode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplyPhysicalCardCubit, BaseState>(
        bloc: _applyPhysicalCardCubit,
        listener: (context, state) async {
          if (state.main.isFailure) {
            showError(context, state.main.errorMessage ?? '');
          }

          if (state.main.isInProgress) {
            showLoadingBar(context, "Loading...");
          }
          if (state.main.isOtpSent) {
            showSuccess(context, "OTP sent");
          }
          if (state.main.isSuccess) {
            showSuccess(
                context, state.main.errorMessage ?? "Information added.");
            showPaymentScreen(context);
          }
        },
        builder: (context, state) {
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
                          validator: !Validators.isNameValid(firstName) &&
                                  firstName.isNotEmpty
                              ? Constants.enterValidFirstName
                              : null,
                          maxLength: 50,
                          value: firstName,
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
                          validator: !Validators.isNameValid(lastName) &&
                                  lastName.isNotEmpty
                              ? Constants.enterValidLastName
                              : null,
                          value: lastName,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _phoneNum(),
                        _otpFieldPhone(),
                        const SizedBox(
                          height: 16,
                        ),
                        _emailField(),
                        _otpFieldEmail(),
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
                          onChangeText: (value) {
                            setState(() {
                              province = value;
                            });
                          },
                          maxLength: 50,
                          validator: !Validators.isValidCityName(province) &&
                                  province.isNotEmpty
                              ? Constants.enterValidProvince
                              : null,
                          value: province,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InputField(
                          inputLabel: "City",
                          hintText: 'Texas',
                          onChangeText: (value) {
                            setState(() {
                              city = value;
                            });
                          },
                          maxLength: 50,
                          validator: !Validators.isValidCityName(province) &&
                                  province.isNotEmpty
                              ? Constants.enterValidCity
                              : null,
                          value: city,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InputField(
                          inputLabel: "Street Address",
                          hintText: 'Housetown1123',
                          onChangeText: (value) {
                            setState(() {
                              streetAddress = value;
                            });
                          },
                          maxLength: 100,
                        value: streetAddress,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InputField(
                          inputLabel: "Postcode",
                          hintText: 'Enter Code',
                          onChangeText: (value) {
                            setState(() {
                              postCode = value;
                            });
                          },
                          maxLength: 50,
                          validator: !Validators.isValidPostalCode(postCode) &&
                                  postCode.isNotEmpty
                              ? Constants.enterValidPostal
                              : null,
                          value: postCode,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 2, right: 2, top: 40, bottom: 20),
                          child: ButtonPrimary(
                            title: "Confirm and Pay",
                            onClick: () {
                              onConfirmAndPayPress();
                            },
                            buttonColor:
                                isValid() ? AppClr.blue : AppClr.greyButton,
                          ),
                        )
                      ]),
                )
              ]),
            ),
          );
        });
  }

  Widget _phoneNum() {
    return PhoneNumField(
        inputLabel: "Phone Number",
        hintText: 'Phone Number',
        isPhonePicker: true,
        countryCode: selectedCountry,
        countryName: countryName,
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

            if (isValidNum) {
              _applyPhysicalCardCubit.sendOTPForVerification(
                  medium: phoneNumber.text, type: "mobile");
            } else {
              showError(context, "Please enter valid phone number.");
            }
          } catch (err) {
            showError(context, "Please enter valid phone number.");
          }
        },
        onChangeText: (value) {
          if (phoneSecurityCode.isNotEmpty) {
            setState(() {
              phoneSecurityCode = "";
              isPhoneNumberValid = false;
            });
            phoneController.set(["", "", "", ""]);
          }
        });
  }

  Widget _otpFieldPhone() {
    return OtpTextField(
      label: 'Enter Code',
      fieldController: phoneController,
      onOtpComplete: (pin) {
        setState(() {
          phoneSecurityCode = pin;
        });
      },
    );
  }

  Widget _otpFieldEmail() {
    return OtpTextField(
      label: 'Enter Code',
      onOtpComplete: (pin) {
        setState(() {
          emailSecurityCode = pin;
        });
      },
    );
  }

  Widget _emailField() {
    return PhoneNumField(
        inputLabel: "Email",
        hintText: 'Enter your email',
        isPhonePicker: false,
        readOnly: true,
        myController: email,
        onSendClick: () {
          _applyPhysicalCardCubit.sendOTPForVerification(
              medium: email.text, type: "email");
        });
  }

  Widget _genderSelection() {
    return GenderSelection(
      isMaleSelected: isMaleSelected,
      selectedValue: () {
        setState(() {
          isMaleSelected = !isMaleSelected;
        });
      },
    );
  }

  Widget _countrySelected() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                  builder: (_) =>
                      ChooseCountry(countryName: selectedCountryName),
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

  void showPaymentScreen(context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ChoosePaymentOptions(
          onClick: (value) {
            print(value);
            if (value == "wallet") {
              _navigationService.navigateWithBack(LifeStylePlusFees.routeName,
                  arguments: {
                    "isFrom": "lifestyleVirtual",
                    "cardType": "physical"
                  });
            } else {
              _navigationService.navigateWithBack(LSPFeeByLockXRP.routeName,
                  arguments: {
                    "isFrom": "lifestyleVirtual",
                    "cardType": "physical"
                  });
            }
          },
        );
      },
    );
  }
}
