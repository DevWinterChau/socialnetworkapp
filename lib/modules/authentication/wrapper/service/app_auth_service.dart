import 'package:flutter/services.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/auth_credential/GmailAuCredential.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/auth_plugin/auth_plugin.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/auth_plugin/gmail_login.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/auth_provider/GmailAuthProvider.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/service/app_auth.dart';

import '../../../../appstate_bloc.dart';
import '../models/LoginData.dart';

class AppAuthService {
  final _appauth = AppAuth();
  @override
  Future<Data?> LoginWithGmail() async {
    final _authGmail = AuthGmail();
    final authResult = await _authGmail.login();
    if (authResult.accessToken != null) {
      final result = await _appauth.sigInWithCredential(
        GmailAuthProvider.getCredential(accessToken: authResult.accessToken),
      );
      return result;
    }
    return handlerError(authResult);
  }

  Data? handlerError(AuthResult authResult) {
    if (authResult.loginStatus == LoginStatus.cancelledByUser) {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Signin in aborted by user',
      );
    }
    // Provide a default value or return null
    return null;
  }
}
