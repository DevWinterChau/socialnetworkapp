
import 'package:socialnetworkapp/modules/authentication/wrapper/auth_credential/AuthCredential.dart';
import 'package:socialnetworkapp/providers/api_provider.dart';
import 'package:socialnetworkapp/resource/tokenmanager.dart';

import '../models/Login.dart';
import '../models/LoginData.dart';

class AppAuth{
  final _apiProvider = ApiProvider();

  Future<Data?> sigInWithCredential(AuthenCredential credential) async{
    final login = await _signIn(credential);
    if(login == null){
      return null;
    }
    await SaveData(login!);
    return login!.data!;
  }

  Future<void> SaveData(LoginData data) async{
    final tm = TokenManeger()..accessToken = data.data!.accessToken ?? '';
    tm.Save();
  }

  Future<LoginData?> _signIn(AuthenCredential credential)
  async{
    try{
      final response = await _apiProvider.post(
        credential.url,
        data: credential.asMap(),
      );
      if(response.statusCode == 200){
        return LoginData.fromJson(response.data);
      }
      return null;

    }catch(e){
      throw UnimplementedError(
        'sigInWithCredential() is not implemented with err = $e'
      );
    }

  }
}