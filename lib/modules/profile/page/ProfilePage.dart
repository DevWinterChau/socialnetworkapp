import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialnetworkapp/modules/authentication/bloc/authentication_bloc.dart';
import 'package:socialnetworkapp/modules/post/blocs/CreatePostBloc.dart';
import 'package:socialnetworkapp/modules/post/models/PostReadRequest.dart';
import '../../../appstate_bloc.dart';
import '../../../providers/bloc_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {
  AppStateBloc? get appStateBloc => BloCProvider.of<AppStateBloc>(context);
  AuthenTicationBloc? get authenBloc => BloCProvider.of<AuthenTicationBloc>(context);
  Future<User?> _getCurrentUser () {
    return authenBloc!.getUserAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body:
      Center(
        child:  FutureBuilder<User?>(
            future: _getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data! == null) {
                return Text('Dữ liệu không có sẵn ...');
              } else {
                // Dữ liệu đã sẵn sàng, xây dựng giao diện người dùng ở đây
                final currentUser = snapshot.data!;
                return Center(child:  Column(children: [
                  Container(
                    height: 100,
                    width: 100,
                    child:   ClipOval(
                      child: Image.network(currentUser!.photoURL!),
                    ),
                  ),
                  Text(currentUser!.displayName!),
                  ElevatedButton(onPressed:() async{
                      await appStateBloc!.logout();
                      Navigator.pop(context);
                  }, child: Text('Đăng xuất')),
                ],),);
              }
            }
        ),
      ),
    );
  }
  @override
  void dispose(){
    super.dispose();
    //appStateBloc!.dispose();
    //authenBloc!.dispose();
  }
}


