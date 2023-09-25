import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../theme/Images.dart';
import '../../widgets/_header.dart';

class Deposit extends StatefulWidget {
  const Deposit({Key? key}) : super(key: key);

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  var userAddress = "0x5c17613C5ad1e3543c1E3989BD3E09D442620d2b";
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  _qrImage(),
                  const SizedBox(
                    height: 35,
                  ),
                  SizedBox(
                    width: ClassMediaQuery.screenWidth / 1.45,
                    child: Row(children: [
                      Expanded(
                        child: Text(userAddress,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.greyWhite16Regular),
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: userAddress))
                              .then((res) {});
                        },
                        child: Image.asset(
                          Images.icCopy,
                          width: 13,
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _qrImage() {
    return Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppClr.greyQrBack,
        ),
        child: QrImageView(
          data: 'usdt:0xE53dC38c6F68E3d0dd3Cf00459DD94401EBdFdcC?amount=50',
          version: QrVersions.auto,
          size: 200.0,
          eyeStyle: const QrEyeStyle(
            eyeShape: QrEyeShape.square,
            color: Colors.white,
          ),
          dataModuleStyle: const QrDataModuleStyle(
            dataModuleShape: QrDataModuleShape.square,
            color: Colors.white,
          ),
        ));
  }
}
