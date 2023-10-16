import 'package:flutter/material.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/theme/AppTheme.dart';

import '../../theme/Colors.dart';
import '../../theme/Images.dart';

class DropDownField extends StatefulWidget {
  final String value;
  final Function onClick;

  const DropDownField({super.key, this.value = "", required this.onClick});

  @override
  State<DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onClick();
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppClr.inputFieldBg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                widget.value != ""
                    ? SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset(
                          Images.ic_usdt,
                          width: 25,
                          height: 25,
                        ),
                      )
                    : Container(),
                const SizedBox(width: 8),
                Text(
                  widget.value,
                  style: const TextStyle(
                      color: AppClr.grey,
                      fontSize: 14,
                      fontFamily: AppTheme.fontRegular),
                )
              ],
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: AppClr.white,
            )
          ],
        ),
      ),
    );
  }
}
