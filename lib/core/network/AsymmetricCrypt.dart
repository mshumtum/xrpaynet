// import 'package:encrypt/encrypt.dart';
// import 'package:encrypt/encrypt_io.dart';
// import 'package:flutter/services.dart';
// import 'package:pointycastle/asymmetric/api.dart';
// import 'package:fast_rsa/fast_rsa.dart';

import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/oaep.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/pointycastle.dart';

abstract class BaseAuth {
  Future<dynamic> encryptData(dynamic data);
}

class AsymmetricCrypt extends BaseAuth {
//   @override
//   Future<dynamic> encryptData1(dynamic message) async {
//     var publicKey = '''-----BEGIN PUBLIC KEY-----
// MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0ROFngTzPgOjYhwIGj26
// cuXMJ3dvYk1viHUOlkMdn0qUInJXv7YqpVWdzQOYyk0A8W3FxCDBqZZT207NKs5u
// L9AoHDJM/DW2EeSdFsl2WuQO9S18+oxAkeBV4xgEwB0gPvTEmAW0B2c5OGPryZFX
// 4QksIYB4BoFhXq1jRMDBsHaKZBWscvP28MDxoabSkKcWWFtJrsbuJBrnxChmfzrH
// PhcbGdXY2xb1UJsTy1nP5vfHKQL9VLKskxEbIeVoW4avZtDWw1pygyNz2HjFAblm
// nlBGubJ40PzfJdcrKFJ87rb4ZeU6U62CSzWax/UiDTqIovh4D2OUWClgk7YRTnte
// kQIDAQAB
// -----END PUBLIC KEY-----''';
//     var result =
//         await RSA.encryptOAEP(message.toString(), "", Hash.SHA256, publicKey);
//     var result1 = await RSA.encryptPKCS1v15(message.toString(), publicKey);
//     print(result);
//     print(result1);
//
//     // var result2 = await RSA.encryptOAEPBytes(messageBytes, label, Hash.SHA256, publicKey)
//     // var result3 = await RSA.encryptPKCS1v15Bytes(messageBytes, publicKey)
//     return result1;
//   }
  @override
  Future<dynamic> encryptData(dynamic data) async {
    try {
      final publicPem = await rootBundle.loadString('assets/public_key.pem');
      final privatePem = await rootBundle.loadString('assets/private_key.pem');
      RSAPrivateKey privateKey =
          RSAKeyParser().parse(privatePem) as RSAPrivateKey;
      RSAPublicKey publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;
      // signPKCS1v15-
      final encrypter = Encrypter(RSA(
        publicKey: publicKey,
        encoding: RSAEncoding.OAEP,
        // digest: RSADigest.SHA1,
      ));
      final plainText = 'sadasxzfxfdzfz';

      final encrypted = encrypter.encrypt(plainText);
      print(encrypted.base64);
      // final decrypted = encrypter.decrypt(Encrypted.fromBase64(
      //     "ZtwFlX//Y7bC0hfzSzaNen+Xp9W2ArnESwmrMsKPS7I9GoyBb3aYcATZb70bRUTp5DdbrkSEO2TROHzrCyCXmAPCLZYWhJI3nPPObFOon3PHX51vGDYyaq5btXeNWukhYTaF3jYLw7slhLn24MvOud6uWim5x4wdjySvEBklzKw="));

      // print("DAT " + decrypted);
    } catch (e) {
      print("ERROR");
      print(e);
    }
//     String str = """-----BEGIN PUBLIC KEY-----
// MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0ROFngTzPgOjYhwIGj26
// cuXMJ3dvYk1viHUOlkMdn0qUInJXv7YqpVWdzQOYyk0A8W3FxCDBqZZT207NKs5u
// L9AoHDJM/DW2EeSdFsl2WuQO9S18+oxAkeBV4xgEwB0gPvTEmAW0B2c5OGPryZFX
// 4QksIYB4BoFhXq1jRMDBsHaKZBWscvP28MDxoabSkKcWWFtJrsbuJBrnxChmfzrH
// PhcbGdXY2xb1UJsTy1nP5vfHKQL9VLKskxEbIeVoW4avZtDWw1pygyNz2HjFAblm
// nlBGubJ40PzfJdcrKFJ87rb4ZeU6U62CSzWax/UiDTqIovh4D2OUWClgk7YRTnte
// kQIDAQAB
// -----END PUBLIC KEY-----""";
//     RSAPublicKey a = RSAKeyParser().parse(str) as RSAPublicKey;
//
//     RSAPublicKey myPublic =
//         RSAPublicKey(a.modulus as BigInt, a.exponent as BigInt);
//     // Uint8List rsaEncrypt( Uint8List dataToEncrypt) {
//     final encryptor = OAEPEncoding(RSAEngine())
//       ..init(true, PublicKeyParameter<RSAPublicKey>(myPublic)); // true=encrypt
//
//     String source = 'Błonie';
//
//     List<int> list = utf8.encode(source);
//     Uint8List bytes = Uint8List.fromList(list);
//     var a11 = _processInBlocks(encryptor, bytes);
//     print(a11);
//     // }
//   }
//
//   Uint8List _processInBlocks(AsymmetricBlockCipher engine, Uint8List input) {
//     final numBlocks = input.length ~/ engine.inputBlockSize +
//         ((input.length % engine.inputBlockSize != 0) ? 1 : 0);
//
//     final output = Uint8List(numBlocks * engine.outputBlockSize);
//
//     var inputOffset = 0;
//     var outputOffset = 0;
//     while (inputOffset < input.length) {
//       final chunkSize = (inputOffset + engine.inputBlockSize <= input.length)
//           ? engine.inputBlockSize
//           : input.length - inputOffset;
//
//       outputOffset += engine.processBlock(
//           input, inputOffset, chunkSize, output, outputOffset);
//
//       inputOffset += chunkSize;
//     }
//
//     return (output.length == outputOffset)
//         ? output
//         : output.sublist(0, outputOffset);
  }
}
