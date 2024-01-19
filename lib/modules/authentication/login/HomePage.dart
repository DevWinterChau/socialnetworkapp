import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialnetworkapp/modules/authentication/login/login_page.dart';

import '../../../appstate_bloc.dart';
import '../../../providers/bloc_provider.dart';
import '../bloc/authentication_bloc.dart';
import 'UserController.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  AppStateBloc? get appStateBloc => BloCProvider.of<AppStateBloc>(context);
  AuthenTicationBloc? get authenbloc =>
      BloCProvider.of<AuthenTicationBloc>(context);
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.network(
                  user!.photoURL ?? '',
                  height: 80,
                  width: 80,
                ),
              ),
              SizedBox(height: 5),
              Text('Xin chào ${user!.displayName ?? ''}'),
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
                  await _changeAppState();
                },
                child: Text("SignOut"),
              ),
            ],
          ),
        ),
      ),
     );
  }
    Future<void> _changeAppState() async{
      await appStateBloc!.changeAppState(AppState.unAuthorized);

  }
}


