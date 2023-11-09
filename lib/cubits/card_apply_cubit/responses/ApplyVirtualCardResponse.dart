class ApplyVirtualCardResponse {
  String? message;
  String? result;
  String? status;

  ApplyVirtualCardResponse({this.message, this.result, this.status});

  ApplyVirtualCardResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result = json['result'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['result'] = this.result;
    data['status'] = this.status;
    return data;
  }
}
