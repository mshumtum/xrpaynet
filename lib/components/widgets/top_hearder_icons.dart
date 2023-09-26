import 'package:flutter/material.dart';

import '../../theme/AppTheme.dart';
import '../../theme/Colors.dart';
class TopHeaderWithIcons extends StatefulWidget {

  final String leftIcon ;
  final String title ;
  final String rightIcon;
  final Function onClickLeftIcon;
  final Function onClickRightIcon;

  const TopHeaderWithIcons({
    super.key,
    required this.leftIcon,
    required this.title,
    required this.rightIcon,
    required this.onClickLeftIcon,
    required this.onClickRightIcon
  });

  @override
  State<TopHeaderWithIcons> createState() => _TopHeaderWithIconsState();
}

class _TopHeaderWithIconsState extends State<TopHeaderWithIcons> {
  @override
  Widget build(BuildContext context) {
    return  _topBar();
  }
  Widget _topBar() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(left: 15,right: 15,top: 15),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              widget.onClickLeftIcon();
            },
            child: Image.asset(
              widget.leftIcon  ,
              width: 20,
              height: 20,
            ),
          ),
           Text(
            widget.title,
            style: const TextStyle(
                fontSize: 18,
                color: AppClr.white,
                fontWeight: FontWeight.w500,
                fontFamily: AppTheme.fontMedium),
          ),
          InkWell(
            onTap: (){
              widget.onClickRightIcon();
            },
            child: Image.asset(
              widget.rightIcon  ,
              width: 20,
              height: 20,
            ),
          )

        ],
      ),
    );
  }
}
