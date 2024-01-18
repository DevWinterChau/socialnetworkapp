import 'package:flutter/material.dart';
import 'package:socialnetworkapp/modules/authentication/login/UserController.dart';
import 'package:socialnetworkapp/modules/authentication/login/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserController.user != null
          ? Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.network(
                  UserController.user!.photoURL ?? '',
                  height: 80,
                  width: 80,
                ),
              ),
              SizedBox(height: 5),
              Text('Xin chào ${UserController.user!.displayName ?? ''}'),
              SizedBox(height: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  textStyle: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                  ),
                ),
                onPressed: () async {
                  final result = await UserController.signOut();
                  if (result) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false,
                    );
                  }
                },
                child: Text("SignOut"),
              ),
            ],
          ),
        ),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
