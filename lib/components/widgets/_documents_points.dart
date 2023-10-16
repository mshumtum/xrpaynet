import 'package:flutter/material.dart';

import '../../theme/AppTheme.dart';
import '../../theme/Colors.dart';
import '../../theme/Images.dart';
import '../utilities/ClassMediaQuery.dart';

class DocumentsPoints extends StatelessWidget {
  final String text;

  const DocumentsPoints({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ClassMediaQuery.screenWidth,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children at the top
        children: [
          Container(
            margin: EdgeInsets.only(top: 2),
            child: Image.asset(
              Images.ic_tick_with_circle,
              width: 12, // Adjust the width to fit your layout
              height: 12, // Adjust the height to fit your layout
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              flex: 1,
              child: Text(
                text,
                style: const TextStyle(
                    fontFamily: AppTheme.fontRegular,
                    fontSize: 14,
                    color: AppClr.greyWhite),
              ))
        ],
      ),
    );
  }
}
