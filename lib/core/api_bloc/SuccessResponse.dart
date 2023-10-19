class SuccessResponse<T> {
  String status = "0";
  String msg = "";

  SuccessResponse();

  SuccessResponse.exception(String message) {
    this.msg = message;
  }

  SuccessResponse.fromJson(Map<String, dynamic> parsedJson) {
    status = parsedJson['statusCode'];
    msg = parsedJson['message'];
  }
}
