import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'message.dart';

// class ApiService {
//   final InterceptedClient client;
//   final String baseUrl;
//
//   ApiService({
//     required this.client,
//     required this.baseUrl,
//   });
//
//   Future<dynamic> get(
//       String endpoint, {
//         Map<String, String?>? queryParams,
//         Map<String, String>? additionalHeaders,
//       }) async {
//     dynamic responseJson;
//     try {
//       final uri = Uri.https(baseUrl, '/$endpoint', queryParams);
//       final response = await client.get(uri, headers: additionalHeaders);
//       responseJson = _response(response);
//     } catch (e) {
//       rethrow;
//     }
//     return responseJson;
//   }
//
//   dynamic _response(http.Response response) {
//     switch (response.statusCode) {
//       case HttpStatus.ok: //200
//         var responseJson = json.decode(response.body);
//         return responseJson;
//
//       case HttpStatus.created: //201
//         var responseJson = json.decode(response.body);
//         return responseJson;
//
//       case HttpStatus.unprocessableEntity: //422
//         var responseJson = json.decode(response.body) as Map<String, dynamic>;
//         final listOfErrors = responseJson['errors'] as Map<String, dynamic>;
//         var buffer = StringBuffer();
//         listOfErrors.forEach((key, value) {
//           final result = value as List;
//           for (int i = 0; i < result.length; i++) {
//             final element = result[i];
//             buffer.write(element);
//           }
//         });
//         throw ApiException(buffer.toString());
//
//       default:
//         {
//           final builder = StringBuffer();
//           builder.write('Response Code: ${response.statusCode}');
//           builder.writeln('Result: ${response.body}');
//           throw ApiException(response.body.toString());
//         }
//     }
//   }
// }
//
// class ApiException implements Exception {
//   final String message;
//
//   ApiException(this.message);
// }
class ApiService {
  static final Duration _timeoutDuration = Duration(seconds: 10);
  static Map<String, String> _userHeader = Map();
  // static Alice alice;

  static Map errorMap(String statusCode, String message) {
    Map<String, dynamic> map = Map();
    map['status'] = statusCode;
    map['message'] = message;

    return map;
  }

  // static setInterceptor(){
  //   alice = Alice(showNotification: true, navigatorKey: locator<NavigationService>().navigatorKey);
  // }

  ApiService(String token) {
    if (token != "") {
      _userHeader = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
    } else {
      _userHeader = {
        'Content-Type': 'application/json',
      };
    }
  }

  static hit({
    required Uri url,
    required Map<String, String> header,
    dynamic body,
    bool encodeData = true,
  }) async {
    try {
      http.Response response;
      var jsonBody = body;

      if (encodeData) {
        jsonBody = json.encode(body);
      }

      switch (apiType.post) {
        case apiType.get:
          response = await http
              .get(url, headers: _userHeader)
              .timeout(_timeoutDuration);
          break;
        case apiType.put:
          response = await http
              .put(url, headers: _userHeader, body: jsonBody)
              .timeout(_timeoutDuration);
          break;
        case apiType.post:
          response = await http
              .post(url, headers: _userHeader, body: jsonBody)
              .timeout(_timeoutDuration);
          break;
      }

      print('~~~RESPONSE BODY~~~~ : ${response.body} ${jsonBody}');
      // alice.onHttpResponse(response);
      if (response.statusCode == 200) {
        var mapResponse = json.decode(response.body);
        return mapResponse;
      } else if (response.statusCode == 400) {
        var mapResponse = json.decode(response.body);
        throw new Exception(mapResponse["errors"]["message"]);
      } else {
        throw new Exception("EXCEPTION");
      }
      return response;
    } on TimeoutException {
      print(CONNECTION_TIMEOUT);
      return errorMap("408", CONNECTION_TIMEOUT);
    } on SocketException {
      print(SOCKET_EXCEPTION);
      return errorMap("408", SOCKET_EXCEPTION);
    } catch (e) {
      // var d = json.encode(e);
      return errorMap("400", e.toString().substring(11));
    }
  }
}

/*~~~~~this method is used for when access token is exp~~~~*/
expiredAccessToken(response) {
  if (response.statusCode == 401) {
    // logOut();
  }
}

enum apiType { get, post, put }
