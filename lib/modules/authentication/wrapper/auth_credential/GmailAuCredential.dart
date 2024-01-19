
import 'AuthCredential.dart';

class GmailAuthenCredential extends AuthenCredential{
  const GmailAuthenCredential({this.accessToken}): super(_url);
  static const String  _url = 'auth';
  final String? accessToken;
  @override
  Map<String, dynamic> asMap() {
    return {'gmail_token': accessToken};
  }

}