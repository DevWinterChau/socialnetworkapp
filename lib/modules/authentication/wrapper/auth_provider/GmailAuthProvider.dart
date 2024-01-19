import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/auth_credential/AuthCredential.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/auth_credential/GmailAuCredential.dart';

class GmailAuthProvider{
  static AuthenCredential getCredential({String? accessToken}){
    return GmailAuthenCredential(accessToken: accessToken);
  }
}