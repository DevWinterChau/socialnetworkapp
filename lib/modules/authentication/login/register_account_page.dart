import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialnetworkapp/appstate_bloc.dart';
import 'package:socialnetworkapp/modules/authentication/bloc/authentication_bloc.dart';
import 'package:socialnetworkapp/modules/authentication/bloc/register_bloc.dart';
import 'package:socialnetworkapp/modules/authentication/enum/LoginState.dart';
import 'package:socialnetworkapp/modules/authentication/login/models/register_model.dart';
import 'package:socialnetworkapp/resource/tokenmanager.dart';
import '../../../providers/bloc_provider.dart';
class RegisterAccountPage extends StatefulWidget {
  const RegisterAccountPage({Key? key}) : super(key: key);
  @override
  _RegisterAccountPageState createState() => _RegisterAccountPageState();
}

class _RegisterAccountPageState extends State<RegisterAccountPage> {
  AppStateBloc? get appStateBloc => BloCProvider.of<AppStateBloc>(context);
  RegisterBloc? get registerBloc =>
      BloCProvider.of<RegisterBloc>(context);
  String? Email = FirebaseAuth.instance.currentUser!.email;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController  fullNamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailcontroller.text = Email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng ký tài khoản'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(

              controller: emailcontroller,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: fullNamecontroller,
              decoration: InputDecoration(
                labelText: 'Họ và tên',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: phonecontroller,
              decoration: InputDecoration(
                labelText: 'Số điện thoại',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                checkValue();
                String email = emailcontroller.text;
                String fullName = fullNamecontroller.text;
                String phone = phonecontroller.text;
                TokenManeger().loadGmail_token(await SharedPreferences.getInstance());
                final request = RegisterModel(email: email, fullname: fullName, phoneNumber: phone, gmail_token: TokenManeger().GmailToken);
                await _register(request);
              },
              child: Text('Đăng ký'),
            ),
          ],
        ),
      ),
    );
  }
  void _showDialog(String message, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
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
  bool checkValue(){
    if(emailcontroller.text =="" || phonecontroller.text == "" || fullNamecontroller.text==""){
      _showDialog("Vui lòng điền đủ thông tin", "Thông báo");
      return false;
    }
    return true;
  }
  Future<void> _changeAppState() async{
    await appStateBloc!.changeAppState(AppState.authorized);
  }
   Future<void> _register(RegisterModel request) async {
      final results = await registerBloc!.registerAccount(request);
      if(results != null){
        _showDialog("Bạn đã đăng ký thành công !", "Đăng ký thành công");
        _changeAppState();
      }
      else{
        _showDialog("Đăng ký không thành công ... Vui lòng thử lại !", "Đăng ký không thành công");
      }
   }

  void _handleErrorPlatform(PlatformException exception) {
    String errorMessage = "An error occurred.";
    if (exception.code == "your_specific_error_code") {
      errorMessage = "Specific error message for this code.";
    }
    _showDialog(errorMessage, "Error");
  }
}



