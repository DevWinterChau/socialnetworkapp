import 'package:shared_preferences/shared_preferences.dart';

class TokenManeger{
  static final TokenManeger _intance = TokenManeger._internal();
  String key = 'access_token';
  String keyGmailtoken = 'gmail_token';

  String? accessToken = "";
  String? GmailToken = "";
  TokenManeger._internal();
  factory TokenManeger() => _intance;
  Future<void> Save() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, accessToken!);
  }
  load(SharedPreferences preferences){
    accessToken = preferences.getString(key) ?? "";
  }
  loadGmail_token(SharedPreferences preferences){
    GmailToken = preferences.getString(keyGmailtoken) ?? "";
  }

}