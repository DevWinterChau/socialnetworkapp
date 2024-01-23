import 'package:shared_preferences/shared_preferences.dart';

class TokenManeger{
  static final TokenManeger _intance = TokenManeger._internal();
  String key = 'access_token';
  String? accessToken = "";
  TokenManeger._internal();
  factory TokenManeger() => _intance;
  Future<void> Save() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, accessToken!);
    print("Đã lưu token vào bộ nhớ");
    load(prefs);
    print(accessToken);
  }
  load(SharedPreferences preferences){
    accessToken = preferences.getString(key) ?? "";
  }

}