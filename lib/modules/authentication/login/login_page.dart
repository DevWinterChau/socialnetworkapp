import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialnetworkapp/modules/authentication/login/HomePage.dart';
import 'package:socialnetworkapp/modules/authentication/login/UserController.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
              onPressed: () async{
                final user = await UserController.signInWithGoogle();
                if(user != null) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const HomePage()));
                }
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
}
