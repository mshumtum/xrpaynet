import 'package:flutter/material.dart';
import 'package:xr_paynet/theme/Colors.dart';

import '../../../theme/Images.dart';
import '../../widgets/_header.dart';

class Deposit extends StatefulWidget {
  const Deposit({Key? key}) : super(key: key);

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(
              title: "Deposit",
            ),
            _qrImage(),
          ],
        ),
      ),
    );
  }

  Widget _qrImage(){
    return Container(
        child: Center(
            child: Image.asset(Images.qr_img, width: 226)));
  }

}
