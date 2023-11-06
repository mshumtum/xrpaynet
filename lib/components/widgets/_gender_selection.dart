import 'package:flutter/material.dart';

import '../../theme/Colors.dart';

class GenderSelection extends StatefulWidget {
  final Function()? selectedValue;
  final bool isMaleSelected;
  const GenderSelection({
    super.key,
    this.selectedValue,
    this.isMaleSelected = true,
  });

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {

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
              onTap: widget.selectedValue,
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.06,
                width: MediaQuery.sizeOf(context).width * 0.42,
                decoration: BoxDecoration(
                    color:
                    widget.isMaleSelected ? AppClr.blue : AppClr.inputFieldBg,
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
              onTap: widget.selectedValue,
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.06,
                width: MediaQuery.sizeOf(context).width * 0.42,
                decoration: BoxDecoration(
                    color:
                    !widget.isMaleSelected ? AppClr.blue : AppClr.inputFieldBg,
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
