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
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Email và mật khẩu
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Nhập địa chỉ Email ...'
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                        hintText: 'Nhập mật khẩu ...'
                    ),
                  ),
                  SizedBox(height: 16),

                  // Nút đăng nhập bằng Email
                  ElevatedButton(
                    onPressed: () {

                    },
                    child: Text('Đăng nhập'),
                  ),
                ],
              ),
            ),
            // Đăng nhập bằng Google
            Text("Hoặc", style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
            SizedBox(height: 10),
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
                  Text("Đăng nhập với Google"
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
      print('loginState $loginState');
      switch (loginState) {
        case LoginState.success:
          return _changeAppState();
        case LoginState.isNewUser:
          return _changeAppStateIsnew();
          default:
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
  Future<void> _changeAppStateIsnew() async{
    await appStateBloc!.changeAppState(AppState.registerAccount);
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


