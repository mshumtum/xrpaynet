import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          Icons.cloud_off,
          size: 30,
          color: Colors.redAccent,
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Text(
            'No Internet',
            style: TextStyle(color: Colors.redAccent, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}