import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialnetworkapp/modules/authentication/login/models/register_model.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/service/app_auth_service.dart';
import 'package:socialnetworkapp/providers/bloc_provider.dart';

import '../../../appstate_bloc.dart';
import '../enum/LoginState.dart';
import '../wrapper/models/LoginData.dart';
import '../wrapper/service/register_service.dart';

class RegisterBloc extends BlocBase {
  final RegisterService registerServiceervice;
  RegisterBloc(this.registerServiceervice);

  Future<RegisterModel?> registerAccount(RegisterModel request) async {
    try {
        return await registerServiceervice.RegisterAccount(request);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {

  }
}
