import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/components/screens/appliedCardScreens/LifeStylePlusApplied.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/utilities/utility.dart';
import 'package:xr_paynet/components/utilities/validators.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/cubits/base_cubit/base_state.dart';
import 'package:xr_paynet/cubits/card_apply_cubit/applyPhysicalCardCubit.dart';
import 'package:xr_paynet/cubits/user_cubit/user_cubit.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

import '../../../theme/Images.dart';
import '../../widgets/_button_primary.dart';
import '../../widgets/_documents_points.dart';
import '../../widgets/_header.dart';
import '../../widgets/_input_filed.dart';

class LinkCard extends StatefulWidget {
  static const String routeName = '/life_style_link_card';
  final Object? arguments;
  const LinkCard({super.key, this.arguments});

  @override
  State<LinkCard> createState() => _LinkCardState();
}

class _LinkCardState extends State<LinkCard> {
  final NavigationService _navigationService = locator<NavigationService>();
  final ApplyPhysicalCardCubit _applyPhysicalCardCubit =
      locator<ApplyPhysicalCardCubit>();
  final UserDataCubit _userDataCubit = locator<UserDataCubit>();

  String applicantName = "", cardNumber = "", envelopeNumber = "";

  bool isValid() {
    return Validators.isNameValid(applicantName) &&
        Validators.isValidCardNumber(cardNumber) &&
        Validators.isValidPostalCode(envelopeNumber) &&
        !_applyPhysicalCardCubit.state.main.isInProgress;
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
            _navigationService.navigateWithBack(LifeStylePlusApplied.routeName,
                arguments: {"isFrom": "linkCard"});
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppClr.black,
            body: _rootUI(),
          );
        });
  }

  Widget _rootUI() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(
            title: "Link Card",
          ),
          _cardImage(),
          _linkCardText('Link Your Card Now For Compliance'),
          _linkCardText('Once Successful, Your Card Will Be Issued'),
          const SizedBox(
            height: 30,
          ),
          InputField(
            inputLabel: "Applicant Name",
            hintText: 'Enter name',
            inputType: TextInputType.name,
            onChangeText: (value) {
              setState(() {
                applicantName = value;
              });
            },
            validator: !Validators.isNameValid(applicantName) &&
                    applicantName.isNotEmpty
                ? Constants.enterValidFullName
                : null,
            maxLength: 50,
            value: applicantName,
          ),
          const SizedBox(
            height: 15,
          ),
          InputField(
            inputLabel: "Card Number",
            hintText: 'Enter card number',
            inputType: TextInputType.number,
            onChangeText: (value) {
              setState(() {
                cardNumber = value;
              });
            },
            validator: !Validators.isValidCardNumber(cardNumber) &&
                    cardNumber.isNotEmpty
                ? Constants.enterValidCard
                : null,
            maxLength: 16,
            value: cardNumber,
          ),
          const SizedBox(
            height: 15,
          ),
          InputField(
            inputLabel: "Envelope Number",
            hintText: 'Enter number',
            onChangeText: (value) {
              setState(() {
                envelopeNumber = value;
              });
            },
            validator: !Validators.isValidPostalCode(envelopeNumber) &&
                    envelopeNumber.isNotEmpty
                ? Constants.enterEnvelopeCard
                : null,
            maxLength: 50,
            value: envelopeNumber,
          ),
          const DocumentsPoints(text: Constants.linkCardRule1),
          const DocumentsPoints(text: Constants.linkCardRule2),
          const DocumentsPoints(text: Constants.linkCardRule3),
          const SizedBox(
            height: 36,
          ),
          ButtonPrimary(
              title: 'Link Now',
              onClick: () {
                if (isValid()) {
                  _applyPhysicalCardCubit.linkPhysicalCard(
                      applicantName:
                          _userDataCubit.state.main.userData?.userInfo?.email ??
                              "munish.antier@gmail.com",
                      cardNumber: cardNumber,
                      envelopeNumber: envelopeNumber,
                      mcTrade: "48d2741747a4493223feb22");
                }
              },
              buttonColor: isValid() ? AppClr.blue : AppClr.greyButton),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _cardImage() {
    return Container(
      margin: const EdgeInsets.only(top: 35, bottom: 20),
      width: ClassMediaQuery.screenWidth,
      child: Align(
        alignment: Alignment.center, // Center-align the image horizontally
        child: Image.asset(
          Images.ic_white_card,
          width: 72, // Adjust the width to fit your layout
          height: 46, // Adjust the height to fit your layout
        ),
      ),
    );
  }

  Widget _linkCardText(text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      width: ClassMediaQuery.screenWidth,
      child: Align(
        alignment: Alignment.center, // Center-align the image horizontally
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 15,
              // fontFamily: AppTheme.fontLight,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
    );
  }
}
