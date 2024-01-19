import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialnetworkapp/appstate_bloc.dart';
import 'package:socialnetworkapp/modules/authentication/bloc/authentication_bloc.dart';
import 'package:socialnetworkapp/modules/authentication/enum/LoginState.dart';
import 'package:socialnetworkapp/modules/authentication/login/HomePage.dart';

import '../../../providers/bloc_provider.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  LoadingPageState createState() => LoadingPageState();

}


class LoadingPageState extends State<LoadingPage> {
  AppStateBloc? get appStateBloc => BloCProvider.of<AppStateBloc>(context);
  AuthenTicationBloc? get authenbloc =>
      BloCProvider.of<AuthenTicationBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

}



