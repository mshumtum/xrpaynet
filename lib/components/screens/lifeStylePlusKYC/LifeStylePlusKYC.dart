import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:phone_number/phone_number.dart';
import 'package:xr_paynet/components/screens/chooseOptionScreens/ChooseCountry.dart';
import 'package:xr_paynet/components/screens/lifeStylePlusKYC/LspSuccessScreen.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/utilities/utility.dart';
import 'package:xr_paynet/components/utilities/validators.dart';
import 'package:xr_paynet/components/widgets/_bottom_sheets.dart';
import 'package:xr_paynet/components/widgets/_documents_points.dart';
import 'package:xr_paynet/components/widgets/_text_view_with_arrow.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/cubits/card_apply_cubit/applyPhysicalCardCubit.dart';
import 'package:xr_paynet/cubits/user_cubit/user_cubit.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Images.dart';

import '../../../theme/Colors.dart';
import '../../widgets/_button_primary.dart';
import '../../widgets/_header.dart';
import '../../widgets/_heading_text.dart';
import '../../widgets/_input_filed.dart';

class LifeStylePlusKYC extends StatefulWidget {
  static const String routeName = '/life_style_plus_activate';
  final Object? arguments;
  const LifeStylePlusKYC({super.key, this.arguments});
  @override
  State<LifeStylePlusKYC> createState() => _LifeStylePlusKYCState();
}

class _LifeStylePlusKYCState extends State<LifeStylePlusKYC> {
  final NavigationService _navigationService = locator<NavigationService>();
  final ApplyPhysicalCardCubit _applyPhysicalCardCubit =
      locator<ApplyPhysicalCardCubit>();

  String selectedDate = "DD/MM/YYYY",
      nationality = "United Kingdom",
      firstName = "",
      lastName = "",
      documentNumber = "",
      emergencyContactName = "",
      selectedCountry = "44";
  bool isKycRejected = false;
  TextEditingController phoneNumber = TextEditingController();
  File? frontPageId, selfieWithId, signature;
  late DateTime initialDate, lastDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _applyPhysicalCardCubit.getSupportedCountry();
    setState(() {
      var date = DateTime.now();
      initialDate = DateTime(date.year - 18, date.month, date.day);
      lastDate = DateTime(date.year - 18, date.month, date.day);
    });
  }

  void pickImage(type, isCameraOpen, quality, maxSize) async {
    try {
      final image = await ImagePicker().pickImage(
          source: isCameraOpen ? ImageSource.camera : ImageSource.gallery,
          preferredCameraDevice:
              (type == "selfie") ? CameraDevice.front : CameraDevice.rear,
          imageQuality: quality);

      if (image == null) return;
      final imageTemp = File(image.path);
      var imagePath = await image!.readAsBytes();

      var fileSize = imagePath.length;

      final kb = fileSize / 1024;
      final mb = kb / 1024;
      print("fileSize--$mb");
      if (mb > maxSize) {
        return showError(context, "Image size should be less then $maxSize MB");
      }
      setState(() {
        frontPageId = type == "frontId" ? imageTemp : frontPageId;
        selfieWithId = type == "selfie" ? imageTemp : selfieWithId;
        signature = type == "signature" ? imageTemp : signature;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  bool isValid() {
    print(
        "Rtr--, ${firstName}, ${lastName}, $selectedDate, $documentNumber, $frontPageId, $selfieWithId, $signature, ${emergencyContactName}, ${phoneNumber.text}");
    return Validators.isNameValid(firstName) &&
        Validators.isNameValid(lastName) &&
        selectedDate != "DD/MM/YYYY" &&
        Validators.isValidPostalCode(documentNumber) &&
        frontPageId != null &&
        selfieWithId != null &&
        signature != null &&
        Validators.isNameValid(emergencyContactName) &&
        Validators.isValidNumber(phoneNumber.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: _rootUI(),
    );
  }

  Widget _rootUI() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(
            title: "KYC",
          ),
          const SizedBox(
            height: 25,
          ),
          InputField(
            inputLabel: "First Name",
            hintText: 'Enter name',
            inputType: TextInputType.name,
            onChangeText: (value) {
              setState(() {
                firstName = value;
              });
            },
            validator:
                !Validators.isNameValid(firstName) && firstName.isNotEmpty
                    ? Constants.enterValidFirstName
                    : null,
            maxLength: 50,
            value: firstName,
          ),
          const SizedBox(
            height: 15,
          ),
          InputField(
            inputLabel: "Last Name",
            hintText: 'Enter name',
            inputType: TextInputType.name,
            onChangeText: (value) {
              setState(() {
                lastName = value;
              });
            },
            maxLength: 50,
            validator: !Validators.isNameValid(lastName) && lastName.isNotEmpty
                ? Constants.enterValidLastName
                : null,
            value: lastName,
          ),
          const SizedBox(
            height: 15,
          ),
          const HeadingText(
            title: 'Date Of Birth',
          ),
          const SizedBox(
            height: 16,
          ),
          TextViewArrow(
            arrowShow: false,
            valueText: selectedDate,
            onClick: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: initialDate,
                  //get today's date
                  firstDate: DateTime(1950),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: lastDate);

              if (pickedDate != null) {
                print(pickedDate);
                String formattedDate =
                    DateFormat('dd/MM/yyyy').format(pickedDate);
                print(formattedDate);
                //You can format date as per your need
                setState(() {
                  initialDate = pickedDate;
                  selectedDate = formattedDate;
                });
              }
            },
            textColor:
                selectedDate == "DD/MM/YYYY" ? AppClr.grey : AppClr.white,
          ),
          const SizedBox(
            height: 15,
          ),
          const HeadingText(
            title: 'Nationality',
          ),
          const SizedBox(
            height: 10,
          ),
          TextViewArrow(
              arrowShow: true,
              valueText: nationality,
              onClick: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                          builder: (_) => ChooseCountry(countryName: "India"),
                          fullscreenDialog: true),
                    )
                    .then((val) => {
                          setState(() {
                            nationality = val;
                          })
                        });
              }),
          const SizedBox(
            height: 15,
          ),
          InputField(
            inputLabel: "Document Type",
            value: "Passport",
            readOnly: true,
            hintText: '',
          ),
          const SizedBox(
            height: 15,
          ),
          InputField(
            inputLabel: "Document Number",
            hintText: 'Enter document number',
            inputType: TextInputType.name,
            onChangeText: (value) {
              setState(() {
                documentNumber = value;
              });
            },
            maxLength: 128,
            validator: !Validators.isValidPostalCode(documentNumber) &&
                    documentNumber.isNotEmpty
                ? Constants.enterValidDocument
                : null,
            value: documentNumber,
          ),
          const SizedBox(
            height: 40,
          ),
          const HeadingText(
            title: 'Front ID Card',
          ),
          _documentWidgets(
              Constants.faceIdTitle, "frontId", frontPageId, 50, 2),
          const DocumentsPoints(text: Constants.faceIdRule1),
          const DocumentsPoints(text: Constants.faceIdRule2),
          const DocumentsPoints(text: Constants.faceIdRule3),
          const SizedBox(
            height: 20,
          ),
          const HeadingText(
            title: 'Selfie With ID Card',
          ),
          _documentWidgets(
              Constants.selfieTitle, "selfie", selfieWithId, 70, 5),
          const DocumentsPoints(text: Constants.selfieRule1),
          const DocumentsPoints(text: Constants.selfieRule2),
          const SizedBox(
            height: 20,
          ),
          const HeadingText(
            title: 'Signature Photo',
          ),
          _documentWidgets(
              Constants.signatureTitle, "signature", signature, 40, 1),
          const DocumentsPoints(text: Constants.signatureRule1),
          const DocumentsPoints(text: Constants.signatureRule2),
          const SizedBox(
            height: 30,
          ),
          InputField(
              inputLabel: "Emergency Contact",
              hintText: 'Enter name',
              inputType: TextInputType.name,
              onChangeText: (value) {
                setState(() {
                  emergencyContactName = value;
                });
              },
              maxLength: 50,
              validator: !Validators.isNameValid(emergencyContactName) &&
                      emergencyContactName.isNotEmpty
                  ? Constants.enterValidFullName
                  : null,
              value: emergencyContactName),
          const SizedBox(
            height: 15,
          ),
          _phoneNum(),
          const SizedBox(
            height: 20,
          ),
          ButtonPrimary(
              title: 'Submit',
              buttonColor: isValid() ? AppClr.blue : AppClr.greyButton,
              onClick: () {
                if (isValid()) {
                  _navigationService.navigateWithBack(
                      LspSuccessScreen.routeName,
                      arguments: widget.arguments);
                }
              }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _documentWidgets(text, type, File? file, quality, maxSize) {
    return Container(
      width: ClassMediaQuery.screenWidth,
      height: 225,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 12),
      child: DottedBorder(
        color: AppClr.darkGreyDotted,
        strokeWidth: 1,
        dashPattern: [8, 3],
        radius: const Radius.circular(8),
        borderType: BorderType.RRect,
        child: file != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Stack(
                  children: [
                    Image.file(
                      fit: BoxFit.cover,
                      file!,
                      height: 225,
                      width: ClassMediaQuery.screenWidth,
                    ),
                    Positioned(
                        top: 10,
                        right: 12,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              frontPageId =
                                  type == "frontId" ? null : frontPageId;
                              selfieWithId =
                                  type == "selfie" ? null : selfieWithId;
                              signature =
                                  type == "signature" ? null : signature;
                            });
                          },
                          child: Image.asset(Images.ic_close,
                              height: 25, color: Colors.red),
                        ))
                  ],
                ))
            : GestureDetector(
                onTap: () {
                  showPaymentScreen(type, quality, maxSize);
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.ic_upload,
                        width: 35, // Adjust the width to fit your layout
                        height: 35, // Adjust the height to fit your layout
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        text,
                        style: const TextStyle(
                            fontFamily: AppTheme.fontRegular,
                            fontSize: 14,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _phoneNum() {
    return PhoneNumField(
      inputLabel: "Emergency Number",
      hintText: 'Phone Number',
      isPhonePicker: true,
      countryCode: selectedCountry,
      isShowSend: false,
      maxLength: 15,
      onPickerClick: () {
        showCountryPicker(
          context: context,
          onSelect: (Country country) {
            setState(() {
              selectedCountry = country.phoneCode;
            });
            print("country==${country.toJson()}");
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
      myController: phoneNumber,
      onChangeText: (value) {
        setState(() {});
      },
    );
  }

  void showPaymentScreen(type, quality, maxSize) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return PhotoOption(
          onCameraClicked: (isTrue) {
            pickImage(type, isTrue, quality, maxSize);
          },
        );
      },
    );
  }
}
