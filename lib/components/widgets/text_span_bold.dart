import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../theme/AppTheme.dart';
import '../../theme/Colors.dart';

class TextSpanBold extends StatelessWidget {
  final String title;
  final String boldText;
  final Function() onClick;
  const TextSpanBold(
      {super.key,
        required this.title,
        required this.boldText,
        required this.onClick
      }
      );

  @override
  Widget build(BuildContext context) {
    return  RichText(
      textAlign: TextAlign.start,
      text:  TextSpan(
        style: const TextStyle(
          color: AppClr.grey,
          fontSize: 14.0,
          fontFamily: AppTheme.fontLight,
        ),
        children: <TextSpan>[
          TextSpan(text: title),
          TextSpan(
            text: boldText,
            recognizer: TapGestureRecognizer()
              ..onTap = onClick,
            style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: AppTheme.fontBold,
                color: Colors.white),
          ),

        ],
      ),
    );
  }
}
