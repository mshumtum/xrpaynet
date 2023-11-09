import 'package:flutter/material.dart';

import '../../theme/AppTheme.dart';
import '../../theme/Colors.dart';
import '../utilities/ClassMediaQuery.dart';

class TextViewArrow extends StatefulWidget {
  final String valueText;

  final Function()? onClick;
  final bool arrowShow;
  final Color textColor;

  TextViewArrow({
    super.key,
    this.valueText = "",
    required this.arrowShow,
    this.onClick,
    this.textColor = AppClr.white,
  });

  @override
  State<TextViewArrow> createState() => _TextViewArrowState();
}

class _TextViewArrowState extends State<TextViewArrow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
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
                widget.valueText,
                style: TextStyle(
                    color: widget.textColor,
                    fontSize: 14,
                    fontFamily: AppTheme.fontRegular),
              ),
              widget.arrowShow
                  ? const Icon(
                      Icons.arrow_forward_ios,
                      color: AppClr.grey,
                      size: 15, // Change the icon color as needed
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
