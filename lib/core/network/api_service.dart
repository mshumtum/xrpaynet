import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/WelcomeScreen.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'message.dart';

class ApiService {
  static const Duration _timeoutDuration = Duration(seconds: 25);
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
        'api-access-token': token,
        'Content-Type': 'application/json',
      };
    } else {
      _userHeader = {
        'Content-Type': 'application/json',
      };
    }
  }

  static hit(
      {required Uri url,
      Map<String, String>? header,
      dynamic body,
      bool encodeData = true,
      type = "post"}) async {
    try {
      http.Response response;
      var jsonBody = body;

      if (encodeData) {
        jsonBody = json.encode(body);
      }

      switch (type) {
        case "get":
          response = await http
              .get(url, headers: _userHeader)
              .timeout(_timeoutDuration);
          break;
        case "put":
          response = await http
              .put(url, headers: _userHeader, body: jsonBody)
              .timeout(_timeoutDuration);
          break;
        case "post":
          response = await http
              .post(url, headers: _userHeader, body: jsonBody)
              .timeout(_timeoutDuration);
        default:
          response = await http
              .get(url, headers: _userHeader)
              .timeout(_timeoutDuration);
          break;
      }

      print(
          '~~~RESPONSE BODY~~~~ : ${type} ${response.body}');
      print(response.statusCode);
      // alice.onHttpResponse(response);
      if (response.statusCode == 200) {
        var mapResponse = json.decode(response.body);
        return mapResponse;
      } else if (response.statusCode == 400) {
        var mapResponse = json.decode(response.body);
        if (mapResponse["error"] != null) {
          return throw new Exception(mapResponse["error"]);
        }
        throw new Exception(mapResponse["errors"]["message"]);
      } else if(response.statusCode == 403){
        expiredAccessToken();
        return errorMap("403", INVALID_ACCESS_TOKEN);
      } else if (response.statusCode == 429) {
        throw new Exception("Maximum limit reached. Try again in one minute.");
      }else {
        throw new Exception(CONNECTION_TIMEOUT);
      }
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

/*~~~~~this method is used for when access token is expire~~~~*/
expiredAccessToken() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(Constants.accessToken, "");
  final NavigationService _navigationService = locator<NavigationService>();
  _navigationService.navigateWithRemovingAllPrevious(WelcomeScreen.routeName);
}

enum apiType { get, post, put }
