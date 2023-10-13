import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/appliedCardScreens/LifeStylePlusApplied.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
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
              inputType: TextInputType.name),
          const SizedBox(
            height: 15,
          ),
          InputField(
              inputLabel: "Card Number",
              hintText: 'Enter card number',
              inputType: TextInputType.number),
          const SizedBox(
            height: 15,
          ),
          InputField(
              inputLabel: "Envelope Number",
              hintText: 'Enter number',
              inputType: TextInputType.number),
          const DocumentsPoints(
              text: "We don't charge any fee for the linking service"),
          const DocumentsPoints(text: 'Please fill all the details carefully'),
          const DocumentsPoints(
              text:
                  'Once the card is linked, you will not be able to unlink the card'),
          const SizedBox(
            height: 36,
          ),
          ButtonPrimary(
              title: 'Link Now',
              onClick: () {
                _navigationService.navigateWithBack(
                    LifeStylePlusApplied.routeName,
                    arguments: {"isFrom": "linkCard"});
              }),
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
