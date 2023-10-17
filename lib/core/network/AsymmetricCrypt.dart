import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';

abstract class BaseAuth {
  Future<dynamic> encryptData(dynamic data);
}

class AsymmetricCrypt extends BaseAuth {
//   late RSAPublicKey _publicKey;
//   // RSAPublicKey _privateKey;
//
//   @override
//   String encrypt(dynamic plain) {
//     print("plain====");
//     print(plain);
//     // RSAPublicKey _publicKey = RSAPublicKey.fromString(privateKey);
//     _publicKey = RSAPublicKey.fromPEM(publicKey);
//
//     print("_publicKey====");
//     print(_publicKey);
//     var en = _publicKey.encrypt(plain);
//     print("_EN------");
//     print(en);
//
//     return en;
//   }
//
//   // @override
//   // String decrypt(String data) {
//   //   _privateKey ??= RSAPrivateKey.fromString(privateKey);
//   //   return _privateKey.decrypt(data);
//   // }

  dynamic key = '''-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0ROFngTzPgOjYhwIGj26
cuXMJ3dvYk1viHUOlkMdn0qUInJXv7YqpVWdzQOYyk0A8W3FxCDBqZZT207NKs5u
L9AoHDJM/DW2EeSdFsl2WuQO9S18+oxAkeBV4xgEwB0gPvTEmAW0B2c5OGPryZFX
4QksIYB4BoFhXq1jRMDBsHaKZBWscvP28MDxoabSkKcWWFtJrsbuJBrnxChmfzrH
PhcbGdXY2xb1UJsTy1nP5vfHKQL9VLKskxEbIeVoW4avZtDWw1pygyNz2HjFAblm
nlBGubJ40PzfJdcrKFJ87rb4ZeU6U62CSzWax/UiDTqIovh4D2OUWClgk7YRTnte
kQIDAQAB
-----END PUBLIC KEY-----''';
  dynamic privateKey1 = '''-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA0ROFngTzPgOjYhwIGj26cuXMJ3dvYk1viHUOlkMdn0qUInJX
v7YqpVWdzQOYyk0A8W3FxCDBqZZT207NKs5uL9AoHDJM/DW2EeSdFsl2WuQO9S18
+oxAkeBV4xgEwB0gPvTEmAW0B2c5OGPryZFX4QksIYB4BoFhXq1jRMDBsHaKZBWs
cvP28MDxoabSkKcWWFtJrsbuJBrnxChmfzrHPhcbGdXY2xb1UJsTy1nP5vfHKQL9
VLKskxEbIeVoW4avZtDWw1pygyNz2HjFAblmnlBGubJ40PzfJdcrKFJ87rb4ZeU6
U62CSzWax/UiDTqIovh4D2OUWClgk7YRTntekQIDAQABAoIBACi9+CTB7DCift0o
fz+11bZ8J1ttf8wVMO3TecM4UvZujw1jYMwgEJFlbLm9wLFzbgKeFJLSm0qT28V5
xqtXzMsOcjKEbtIbGV7FQQNmwOSXWn7WnWspl4+VusblME/LnTQHeKPzQJDMwa7G
cfU2mHxm0C27HiiOX84WVajZMyVSqbi5dmKMU3bjIAZaQSMnYf+vYhBQ/QSQmNsU
y8x7VD2YygzcFvfpj4yoh+N3J4S756VTNXd7R+1dva+fElf0UdaWlYdf4lg91xOA
jSjHD182pOiuCNw9I7SHHrR5A76jXK3jqQpktN+Lci/N/mwDCgmehGpf/f3kxxJb
KQWSd50CgYEA/eHZ1BtPeC5/MVhm4gOTHn/tXYE2itJGHrx7bhQAKfDaXUoDm+pl
mmvPsjraxAzAIm6XwWojg5fY8mWlXY9Ao6kzD6Pg+bgR7XD+LqUcyUYC9wFQ7C/S
1Z8dz42Tplh2F7GZ6bZK6xX2lyasKhUOpPTkIMyNLcLCQ7arSZ3G4vsCgYEA0tH9
pFgmRNfk4emq6Ybp48dSr5YzNc4zXwQnlzFqWSD001j9PSkhTKg3Mca34BhzK7Wc
Y7uOyoOs16oYCEBsarzdvYrE8s6iAYlNjVWxE/fc+XVUjJBdvEckvIg/yTk9lX0k
d+H3LpX/vHa5mWpCvXrz2Ldu+qQuTgMajFdVLuMCgYBAR3uQYW3IfvVDOB+sX71S
/o7JmtqFYWHRjGUv5K557/pJnmC1jC43X86RUKds9dF7pkaT+NyPB9Ys4SFyQ7/Y
8BD2h8aBU2JunKougy17pFdB1Lp5Yk5eOdAhabYVatZTf2r5qmbjiIcLlAYJDZXM
nBhaWY/xIxtua4SIugLOGwKBgQCc2GoyePqPwWehw+zKLPuZ4VNdGwwifbSufjLO
Q49xnBlJnC1b8Vu64nOd7tAiQ058OHOPp5zGgkx3by7OBNAkYTs/pxx74MubBQHT
outJheC7H1W19jomt29XbK64EIQG0cHuBwmVeTd4iYPv5aSdv/nnRCGnC7r/g0Of
IeJYLQKBgQDKiIXarM1oDk54XroT4eqw28euEw9MSSzaW4ONI+nMlvjA48ViRSvG
96aC9zU1/U6PrHrBMoOVZqrKTEo0j3KUk3ScTIupJHgaFfUZ4qeIuDo/pHEysW1E
Nj/DmCXLTaoLM2AiMc6Md5yUF3VanKbnsJyJE+22V2uZUpdwxtdypw==
-----END RSA PRIVATE KEY-----
''';
  @override
  Future<dynamic> encryptData(dynamic data) async {
    try {
      // final publicPem =
      //     await rootBundle.loadString('assets/pem/public_key.pem');
      // final privatePem =
      //     await rootBundle.loadString('assets/pem/private_key.pem');
      // final publicKeyPem = File(key).readAsStringSync();
      // final privateKeyPem = File('assets/private_key.pem').readAsStringSync();

      final publicKey = RSAKeyParser().parse(key) as RSAPublicKey;
      final privateKey = RSAKeyParser().parse(privateKey1) as RSAPrivateKey;

      final signer = Signer(RSASigner(RSASignDigest.SHA256,
          publicKey: publicKey, privateKey: privateKey));

      print(signer.sign(data.toString()).base64);
      // print(signer.verify64('hello world', 'jfMhNM2v6hauQr6w3ji0xNOxGInHbeIH3DHlpf2W3vmSMyAuwGHG0KLcunggG4XtZrZPAib7oHaKEAdkHaSIGXAtEqaAvocq138oJ7BEznA4KVYuMcW9c8bRy5E4tUpikTpoO+okHdHr5YLc9y908CAQBVsfhbt0W9NClvDWegs='));;
    } catch (e) {
      print(e);
    }
  }
}
