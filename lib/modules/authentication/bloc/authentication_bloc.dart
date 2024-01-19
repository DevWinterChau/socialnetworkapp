import 'package:socialnetworkapp/modules/authentication/wrapper/service/app_auth_service.dart';
import 'package:socialnetworkapp/providers/bloc_provider.dart';

import '../../../appstate_bloc.dart';
import '../enum/LoginState.dart';
import '../wrapper/models/LoginData.dart';

class AuthenTicationBloc extends BlocBase {
  final AppAuthService authService;
  AuthenTicationBloc(this.authService);
  Future<LoginState?> _signIn(Future<Data?> signInmethod) async {
    try {
      final logindata = await signInmethod;
      if (logindata != null) {

        return LoginState.success;
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
