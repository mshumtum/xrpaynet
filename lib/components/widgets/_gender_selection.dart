import 'package:flutter/material.dart';

import '../../theme/Colors.dart';

class GenderSelection extends StatefulWidget {
  final Function(int value)? selectedValue;
  const GenderSelection({
    super.key,
    this.selectedValue,
  });

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
   int isSelected = 0;
   @override
  Widget build(BuildContext context) {
    return  _genderSelection();
  }

  Widget _genderSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = 0;
                  widget.selectedValue!(0);
                });
              },
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.06,
                width: MediaQuery.sizeOf(context).width * 0.42,
                decoration: BoxDecoration(
                    color:
                    isSelected == 0 ? AppClr.blue : AppClr.inputFieldBg,
                    borderRadius: BorderRadius.circular(12)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.male_rounded,
                      color: Colors.white,
                    ),
                    Text(
                      "Male",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = 1;
                  widget.selectedValue!(1);
                });
              },
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.06,
                width: MediaQuery.sizeOf(context).width * 0.42,
                decoration: BoxDecoration(
                    color:
                    isSelected == 1 ? AppClr.blue : AppClr.inputFieldBg,
                    borderRadius: BorderRadius.circular(12)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.female_rounded,
                      color: Colors.white,
                    ),
                    Text(
                      "Female",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
