import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetworkapp/modules/authentication/login/HomePage.dart';
import 'package:socialnetworkapp/routes/routes.dart';

import '../appstate_bloc.dart';
import '../modules/authentication/bloc/authentication_bloc.dart';
import '../modules/authentication/login/login_page.dart';
import '../modules/authentication/wrapper/service/app_auth_service.dart';
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

  @override
  Widget build(BuildContext context) {
    return BloCProvider(
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
              onGenerateRoute: (settings) {
                return Routes.authorizedRoute(settings);
              },
              initialRoute: '/',
              home: BloCProvider(
                child: HomePage(),
                bloc: authenticationBloc,
              ),
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
    );
  }

  @override
  void dispose() {
    appStateBloc.dispose();
    authenticationBloc.dispose();
    super.dispose();
  }
}
