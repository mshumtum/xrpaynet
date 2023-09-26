import 'package:flutter/material.dart';
import 'package:xr_paynet/theme/Colors.dart';

class CircleContainer extends StatefulWidget {
  final double containerSize;

  const CircleContainer({
    super.key,
    this.containerSize = 0,
  });

  @override
  State<CircleContainer> createState() => _CircleContainerState();
}

class _CircleContainerState extends State<CircleContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.containerSize,
      height: widget.containerSize,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: AppClr.white),
    );
  }
}
