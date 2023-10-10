class LoginRequest {
  String emailId;
  String password;
  LoginRequest({required this.emailId,required this.password});
  Map toMap(){
    var map = <String, dynamic>{};
    map["email_id"] = emailId;
    map["password"] = password;
    return map;
  }
}
