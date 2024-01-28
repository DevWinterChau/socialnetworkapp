import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/service/app_auth_service.dart';
import 'package:socialnetworkapp/providers/bloc_provider.dart';

import '../../../appstate_bloc.dart';
import '../enum/LoginState.dart';
import '../wrapper/models/LoginData.dart';

class AuthenTicationBloc extends BlocBase {
  final AppAuthService authService;
  AuthenTicationBloc(this.authService);

  Future<User?> getUserAuth() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<LoginState?> _signIn(Future<Data?> signInmethod) async {
    try {
      final logindata = await signInmethod;
      print('logindata ${logindata!.isNew!}');
      if (logindata != null) {
        if(logindata!.isNew! == false)
          return LoginState.success;
        else
          return LoginState.isNewUser;
      }
      else{
        return LoginState.fail;
      }
    } catch (e) {
      print(e);
      return LoginState.fail;
    }
  }

  Future<LoginState?> loginWithGmail() async {
    return _signIn(authService.LoginWithGmail());
  }

  @override
  void dispose() {
    // Dispose resources if needed
  }
}
