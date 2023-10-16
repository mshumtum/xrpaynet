import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xr_paynet/components/screens/lifeStylePlusKYC/LspSuccessScreen.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_documents_points.dart';
import 'package:xr_paynet/components/widgets/_text_view_with_arrow.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
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
  String selectedDate = "DD/MM/YYYY";
  bool isKycRejected = false;

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
              inputType: TextInputType.name),
          const SizedBox(
            height: 15,
          ),
          InputField(
              inputLabel: "Last Name",
              hintText: 'Enter name',
              inputType: TextInputType.name),
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
                  initialDate: DateTime.now(),
                  //get today's date
                  firstDate: DateTime(2000),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                print(pickedDate);
                String formattedDate =
                    DateFormat('dd/MM/yyyy').format(pickedDate);
                print(formattedDate);
                //You can format date as per your need
                setState(() {
                  selectedDate = formattedDate;
                });
              } else {
                setState(() {
                  selectedDate = selectedDate;
                });
              }
            },
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
            valueText: 'Indian',
            onClick: () {},
          ),
          const SizedBox(
            height: 15,
          ),
          const HeadingText(
            title: 'Document Type',
          ),
          const SizedBox(
            height: 10,
          ),
          TextViewArrow(
            arrowShow: true,
            valueText: 'Passport',
            onClick: () {},
          ),
          const SizedBox(
            height: 15,
          ),
          InputField(
              inputLabel: "Document Number",
              hintText: 'Enter document number',
              inputType: TextInputType.name),
          const SizedBox(
            height: 40,
          ),
          const HeadingText(
            title: 'Front ID Card',
          ),
          _documentWidgets('Upload Your ID Card'),
          const DocumentsPoints(
              text: 'Please upload the front page of the ID card'),
          const DocumentsPoints(
              text:
                  'Ensure that the ID card is completely visible, the font is clear, and the brightness is uniform'),
          const DocumentsPoints(
              text:
                  'The photo should be less than 2MB and can be in jpg/jpeg/png formats'),
          const SizedBox(
            height: 20,
          ),
          const HeadingText(
            title: 'Selfie With ID Card',
          ),
          _documentWidgets('Upload Your Selfie With ID Card'),
          const DocumentsPoints(
              text: 'Please upload your selfie with hand holding the ID card'),
          const DocumentsPoints(
              text:
                  'Take a selfie with hand holding the ID card information page'),
          const SizedBox(
            height: 20,
          ),
          const HeadingText(
            title: 'Signature Photo',
          ),
          _documentWidgets('Upload Photo of your Signature'),
          const DocumentsPoints(
              text: 'The photo of the signature must be clearly visible'),
          const DocumentsPoints(
              text:
                  'The photo should be less than 1MB and can be in jpg/jpeg/png formats'),
          const SizedBox(
            height: 30,
          ),
          InputField(
              inputLabel: "Emergency Contact",
              hintText: 'Enter name',
              inputType: TextInputType.name),
          const SizedBox(
            height: 30,
          ),
          InputField(
              inputLabel: "Emergency Number",
              hintText: 'Enter number',
              inputType: TextInputType.number),
          const SizedBox(
            height: 20,
          ),
          ButtonPrimary(
              title: 'Submit',
              onClick: () {
                _navigationService.navigateWithBack(LspSuccessScreen.routeName,
                    arguments: widget.arguments);
              }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _documentWidgets(text) {
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
    );
  }
}
