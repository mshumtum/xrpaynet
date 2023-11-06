import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:phone_number/phone_number.dart';
import 'package:xr_paynet/components/screens/activationFeesScreens/LSPFeeByLockXRP.dart';
import 'package:xr_paynet/components/screens/activationFeesScreens/LifeStylePlusFees.dart';
import 'package:xr_paynet/components/utilities/utility.dart';
import 'package:xr_paynet/components/utilities/validators.dart';
import 'package:xr_paynet/components/widgets/_bottom_sheets.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/cubits/base_cubit/base_state.dart';
import 'package:xr_paynet/cubits/card_apply_cubit/applyVirtualCardCubit.dart';
import 'package:xr_paynet/cubits/user_cubit/response/UserReponse.dart';
import 'package:xr_paynet/cubits/user_cubit/user_cubit.dart';
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
  final ApplyVirtualCardCubit _applyVirtualCardCubit =
      locator<ApplyVirtualCardCubit>();
  final UserDataCubit _userDataCubit = locator<UserDataCubit>();
  final phoneController = OtpFieldController();

  String selectedCountry = "91",
      countryName = "IN",
      firstName = "",
      lastName = "",
      phoneSecurityCode = "",
      emailSecurityCode = "";
   int cardId = 0;
  bool isPhoneNumberValid = false, isClubCard = true;

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
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
    cardId = params["id"];
    setState(() {
      email.text = _userDataCubit.state.main.userData?.userInfo?.email ?? "";
    });
    if(_userDataCubit.state.main.userData?.cardInfo?.isNotEmpty ?? false){
      int totalCard = _userDataCubit.state.main.userData?.cardInfo?.length ?? 0;
      for(int i = 0; i < totalCard; i++){

         CardInfo? item = _userDataCubit.state.main.userData!.cardInfo?[0];
         print("LENGTH---${item?.cardType}");
      }
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  bool isValid() {
    print("object====${_applyVirtualCardCubit.state.main.isInProgress}");
    return Validators.isNameValid(firstName) &&
        Validators.isNameValid(lastName) &&
        isPhoneNumberValid &&
        phoneSecurityCode.length == 4 &&
        emailSecurityCode.length == 4 &&
        !_applyVirtualCardCubit.state.main.isInProgress;
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
    if(isValid()){
      _applyVirtualCardCubit.applyVirtualCard(
          firstName: firstName,
          lastName: lastName,
          phoneNum: phoneNumber.text,
          phoneCode: int.parse(phoneSecurityCode),
          email: email.text,
          emailCode: int.parse(emailSecurityCode),
          countryCode: "+" + selectedCountry,
          countryName: countryName,
          cardId:cardId
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplyVirtualCardCubit, BaseState>(
        bloc: _applyVirtualCardCubit,
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
                          _phoneNum(context),
                          _otpFieldPhone(),
                          const SizedBox(
                            height: 16,
                          ),
                          _emailField(),
                          _otpFieldEmail(),
                          const SizedBox(
                            height: 16,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, top: 40),
                            child: ButtonPrimary(
                              title: "Confirm and Pay",
                              onClick: () {
                                onConfirmAndPayPress();
                                // showPaymentScreen(context);
                              },
                              buttonColor:
                                  isValid() ? AppClr.blue : AppClr.greyButton,
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
        });
  }

  void showPaymentScreen(context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ChoosePaymentOptions(
          onClick: (value) {
            print(value);

            var cardScreen = isClubCard ? "clubVirtual" : "lifestyleVirtual";

            if (value == "wallet") {
              _navigationService.navigateWithBack(LifeStylePlusFees.routeName,
                  arguments: {"isFrom": cardScreen, "cardType": "virtual"});
            } else {
              _navigationService.navigateWithBack(LSPFeeByLockXRP.routeName,
                  arguments: {"isFrom": cardScreen, "cardType": "virtual"});
            }
          },
        );
      },
    );
  }

  Widget _phoneNum(context) {
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
              print("country==$country");
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
        maxLength: 12,
        onChangeText:(value){
          if(phoneSecurityCode.isNotEmpty) {
            setState(() {
              phoneSecurityCode = "";
            });
            phoneController.set(["", "", "", ""]);
          }
        },
        onSendClick: () async {
          print("HERE-----");
          // validate is number valid or not
          try {
            bool isValidNum = await PhoneNumberUtil().validate(
              selectedCountry + phoneNumber.text,
              regionCode: countryName,
            );
            setState(() {
              isPhoneNumberValid = isValidNum;
            });
            print("xfklmd=====${const PhoneNumField().maxLength}");

            if (isValidNum) {
              _applyVirtualCardCubit.sendOTPForVerification(
                  medium: phoneNumber.text, type: "mobile");
            } else {
              showError(context, "Please enter valid phone number.");
            }
          } catch (err) {
            showError(context, "Please enter valid phone number.");
          }
        });
  }

  Widget _otpFieldPhone() {
    return OtpTextField(
      label: 'Enter Code',
      fieldController: phoneController,
      onOtpComplete: (pin) {
        setState(() {
          phoneSecurityCode =pin ;
        });
      },
    );
  } Widget _otpFieldEmail() {
    return OtpTextField(
      label: 'Enter Code',
      onOtpComplete: (pin) {
        setState(() {
          emailSecurityCode = pin ;
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
      onSendClick: () {
        _applyVirtualCardCubit.sendOTPForVerification(
            medium: email.text, type: "email");
      },
      myController: email,
    );
  }
}
