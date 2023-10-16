import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_input_filed.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

class SetAmountDialog extends StatefulWidget {
  String amount;
  Function(String)? onConfirm;
  SetAmountDialog({super.key, this.amount = "", this.onConfirm});

  @override
  State<SetAmountDialog> createState() => _SetAmountDialogState();
}

class _SetAmountDialogState extends State<SetAmountDialog> {
  final myController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.text = widget.amount;
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: SizedBox(
        width: ClassMediaQuery.screenWidth,
        height: ClassMediaQuery.screenHeight,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: contentBox(context),
        ),
      ),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          // padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppClr.dialogBackground),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              Text(
                "Enter Amount",
                style: AppTheme.white18Medium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: myController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white, fontSize: 14.0),
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppClr.white),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    // border: InputBorder.none, // This will remove the outline
                    filled: true,
                    hintStyle: const TextStyle(color: AppClr.grey2),
                    hintText: "Amount",
                    fillColor: AppClr.greyQrBack,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                  height: 0.4,
                  width: ClassMediaQuery.screenWidth,
                  color: AppClr.extendedWhite),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                            child: Text(
                          "Cancel",
                          style: AppTheme.greyWhite16Regular,
                        )))),
                Container(height: 45, width: 0.4, color: AppClr.extendedWhite),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          if (myController.text.trim().length > 0) {
                            Navigator.pop(context);
                            widget.onConfirm!(myController.text);
                          }
                        },
                        child: Center(
                            child: Text("Confirm",
                                style: AppTheme.white16Regular)))),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
