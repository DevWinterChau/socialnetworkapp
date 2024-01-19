import 'LoginData.dart';

class Login{
  final int? code;
  final LoginData? data;
  Login({this.code, this.data});
  factory Login.fromJson(Map<String, dynamic> json){
    final int? code = json['code'];
    var data;
    if(code == 200){
      data = LoginData.fromJson(json['data']);
    }
    return Login(code: code, data: data);
  }
}