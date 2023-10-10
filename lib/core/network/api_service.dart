import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'message.dart';

class ApiService {
  static final Duration _timeoutDuration = Duration(seconds: 10);
  static Map<String, String> _userHeader = Map();
  // static Alice alice;

  static Map errorMap(int statusCode, String message) {
    Map<String, dynamic> map = Map();
    map['statusCode'] = statusCode;
    map['message'] = message;

    return map;
  }

  // static setInterceptor(){
  //   alice = Alice(showNotification: true, navigatorKey: locator<NavigationService>().navigatorKey);
  // }

  ApiService(String token) {
    if(token!=""){
      _userHeader = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
    }else{
      _userHeader = {};
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
              .put(url , headers: _userHeader, body: jsonBody)
              .timeout(_timeoutDuration);
          break;
        case apiType.post:
          response = await http
              .post(url, headers: _userHeader, body: jsonBody)
              .timeout(_timeoutDuration);
          break;
      }

      print('~~~RESPONSE BODY~~~~ : ${response.body}');
      // alice.onHttpResponse(response);
      if (response.statusCode == 200) {
        var mapResponse = json.decode(response.body);
        if(mapResponse['statusCode'] == 401){
          expiredAccessToken(response);
          return;
        }
        return mapResponse;

      } else {
        throw new Exception('EXCEPTION');
      }
    } on TimeoutException {
      print(CONNECTION_TIMEOUT);
      return errorMap(408, CONNECTION_TIMEOUT);
    } on SocketException {
      print(SOCKET_EXCEPTION);
      return errorMap(408, SOCKET_EXCEPTION);
    } catch (e) {
      print("Exceptioin ::$e");
      return errorMap(400, ERROR);
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
