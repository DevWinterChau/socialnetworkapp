import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:socialnetworkapp/modules/post/blocs/CreatePostBloc.dart';
import 'package:socialnetworkapp/modules/post/pages/CreatePostPage.dart';
import 'package:socialnetworkapp/modules/post/repos/CreatePostRepo.dart';
import 'package:socialnetworkapp/routes/routes.dart';

import '../appstate_bloc.dart';
import '../modules/authentication/bloc/authentication_bloc.dart';
import '../modules/authentication/login/login_page.dart';
import '../modules/authentication/wrapper/service/app_auth_service.dart';
import '../modules/post/pages/HomePage.dart';
import '../providers/bloc_provider.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainAppStateState();
  }
}

class _MainAppStateState extends State<MainApp> {
  final appStateBloc = AppStateBloc();
  final authenticationBloc = AuthenTicationBloc(AppAuthService());
  final createpostbloc = CreatePostBloc(CreatePostRepo());

  @override
  Widget build(BuildContext context) {
    return
      OverlaySupport.global(
        child:   BloCProvider(
          child: StreamBuilder<AppState>(
            stream: appStateBloc.appStateBloc,
            initialData: appStateBloc.initState,
            builder: (context, snapshot) {
              if (snapshot.data == AppState.unAuthorized) {
                return MaterialApp(
                  onGenerateRoute: (settings) {
                    return Routes.UnauthorizedRoute(settings);
                  },
                  initialRoute: '/',
                  home: BloCProvider(
                    child: LoginPage(),
                    bloc: authenticationBloc,
                  ),
                );
              }
              if (snapshot.data == AppState.authorized) {
                return MaterialApp(
                  initialRoute: '/',
                   home: BloCProvider(
                     child: HomePage(),
                     bloc: createpostbloc,
                   ),
                  onGenerateRoute: (settings) {
                    return Routes.authorizedRoute(settings);
                  },
                );
              }
              return MaterialApp(
                onGenerateRoute: (settings) {
                  return Routes.loading(settings);
                },
                initialRoute: '/',
                home: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            },
          ),
          bloc: appStateBloc,
        ) ,
      );
  }
  @override
  void dispose() {
    appStateBloc.dispose();
    authenticationBloc.dispose();
    super.dispose();
  }
}
