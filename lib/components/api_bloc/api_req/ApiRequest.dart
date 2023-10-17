
class ApiRequest {
  String? dataString;

  ApiRequest({this.dataString});

  ApiRequest.fromJson(Map<String, dynamic> json) {
    dataString = json['dataString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataString'] = this.dataString;
    return data;
  }
}
