import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialnetworkapp/appstate_bloc.dart';
import 'package:socialnetworkapp/modules/authentication/bloc/authentication_bloc.dart';
import 'package:socialnetworkapp/modules/authentication/enum/LoginState.dart';
import '../../../providers/bloc_provider.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AppStateBloc? get appStateBloc => BloCProvider.of<AppStateBloc>(context);
  AuthenTicationBloc? get authenbloc =>
      BloCProvider.of<AuthenTicationBloc>(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng nhập"),
        centerTitle:true,
      ),
      body:  Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _signInWithGoogle();
              },

              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  )
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    // decoration: BoxDecoration(color: Colors.blue),
                      child:
                      Image.network(
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                        fit:BoxFit.cover,
                        height: 40,
                        width: 40,
                      )
                  ),
                  Text("Sign In with Google"
                    ,style: TextStyle(fontSize: 16),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _signInWithGoogle() async {
    try {
      final loginState = await authenbloc!.loginWithGmail();
      print('Trạng thái đăng nhập : $loginState');
      switch (loginState) {
        case LoginState.success:
          return _changeAppState();
        case LoginState.isNewUser:
        // Xử lý trường hợp isNewUser
          break;
        default:
        // Xử lý trường hợp khác (nếu cần)
          break;
      }
    } on PlatformException catch (e) {
      _handleErrorPlatform(e);
    } catch (e) {
      _showDialog(e.toString());
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
  Future<void> _changeAppState() async{
    await appStateBloc!.changeAppState(AppState.authorized);
  }
  void _handleErrorPlatform(PlatformException exception) {
    // Xử lý lỗi dựa trên exception từ nền tảng
    // Ví dụ: hiển thị thông báo cụ thể cho từng mã lỗi
    String errorMessage = "An error occurred.";
    if (exception.code == "your_specific_error_code") {
      errorMessage = "Specific error message for this code.";
    }
    _showDialog(errorMessage);
  }
}



