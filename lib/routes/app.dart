import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:socialnetworkapp/modules/authentication/bloc/register_bloc.dart';
import 'package:socialnetworkapp/modules/authentication/login/register_account_page.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/service/register_service.dart';
import 'package:socialnetworkapp/modules/post/blocs/CreatePostBloc.dart';
import 'package:socialnetworkapp/modules/post/pages/CreatePostPage.dart';
import 'package:socialnetworkapp/modules/post/pages/HomePage_Paging.dart';
import 'package:socialnetworkapp/modules/post/repos/CreatePostRepo.dart';
import 'package:socialnetworkapp/routes/routes.dart';

import '../appstate_bloc.dart';
import '../modules/authentication/bloc/authentication_bloc.dart';
import '../modules/authentication/login/login_page.dart';
import '../modules/authentication/wrapper/service/app_auth_service.dart';
import '../modules/post/blocs/list_post_rxdart_bloc.dart';
import '../modules/post/pages/HomePage.dart';
import '../modules/post/repos/list_post_paging_repo.dart';
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
                  debugShowCheckedModeBanner: false,
                  initialRoute: '/',
                  onGenerateRoute: (settings) {
                    return Routes.UnauthorizedRoute(settings);
                  },
                  home: BloCProvider(
                    child: LoginPage(),
                    bloc: authenticationBloc,
                  ),
                );
              }
              if (snapshot.data == AppState.authorized) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  initialRoute: '/',
                   home: BloCProvider(
                     child: HomePage_Paging(),
                     bloc: ListPostRxDartBloc(ListPostPageRepo()),
                   ),
                  onGenerateRoute: (settings) {
                    return Routes.authorizedRoute(settings);
                  },
                );
              }
              if (snapshot.data == AppState.registerAccount) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  initialRoute: '/',
                  home: BloCProvider(
                    child: RegisterAccountPage(),
                    bloc: RegisterBloc(RegisterService()),
                  ),
                  onGenerateRoute: (settings) {
                    return Routes.registernewAccount(settings);
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
