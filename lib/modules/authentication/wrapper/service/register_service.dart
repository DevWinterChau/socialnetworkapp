import 'package:flutter/services.dart';
import 'package:socialnetworkapp/modules/authentication/login/models/register_model.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/auth_credential/GmailAuCredential.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/auth_plugin/auth_plugin.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/auth_plugin/gmail_login.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/auth_provider/GmailAuthProvider.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/service/app_auth.dart';
import 'package:socialnetworkapp/providers/api_provider.dart';

import '../../../../appstate_bloc.dart';
import '../models/LoginData.dart';

class RegisterService {
  final _apiProvider = ApiProvider();
  @override
  Future<RegisterModel?> RegisterAccount(RegisterModel request) async {
    try{
        final reponse = await _apiProvider.post("auth/register", data: request.toJson());
        if(reponse.statusCode == 200){
          print(reponse.data);
          return RegisterModel.fromJson(reponse.data['data']);
        }
        return null;
    }catch(e){
      print(e);
    }
    return null;
  }

}
