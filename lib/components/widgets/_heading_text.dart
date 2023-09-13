import 'package:flutter/material.dart';


class HeadingText extends StatelessWidget {
  final String title;
  final Color color;
  final double textSize;
  const HeadingText({super.key, required this.title, required this.color, required this.textSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0,left: 20.0),
      child:  Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: color,
          fontSize: textSize,
          fontFamily: 'Roboto-Regular',
        ),
      ),
    );
  }
}
