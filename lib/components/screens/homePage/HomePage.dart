import 'package:flutter/material.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Images.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              title: "XRPaynet Card",
              isHideBack: false,
              secondaryButtonImg: Images.ic_logout,
              secondaryClick: () {
                print("adkfnkd");
              },
            )
          ],
        ),
      ),
    );
  }
}
