import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetworkapp/common/Loading/LoadingPage.dart';
import 'package:socialnetworkapp/modules/authentication/login/HomePage.dart';
import 'package:socialnetworkapp/modules/authentication/login/login_page.dart';
import 'package:socialnetworkapp/modules/food/blocs/ListFoodBloC.dart';
import 'package:socialnetworkapp/routes/RouteName.dart';

import '../modules/authentication/bloc/authentication_bloc.dart';
import '../modules/authentication/wrapper/service/app_auth_service.dart';
import '../modules/food/pages/FoodListPage.dart';
import '../providers/bloc_provider.dart';


class Routes {


  static Route<dynamic> authorizedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return _buildRoute(
          routeSettings,
          BloCProvider(
            child: HomePage(),
            bloc: AuthenTicationBloc(AppAuthService()),
          ),
        );
      default:
        return ErrorRoute();
    }
  }

  static Route<dynamic> UnauthorizedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return _buildRoute(
          routeSettings,
          LoginPage(),
        );
      default:
        return ErrorRoute();
    }
  }
  static Route<dynamic> loading(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return _buildRoute(
          routeSettings,
          LoadingPage(),
        );
      default:
        return ErrorRoute();
    }
  }
  static Route _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }

  static Route _buildRouteDialog(RouteSettings settings, Widget builder) {
    return CupertinoPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }

  static  Route<dynamic> ErrorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: Text('ERROR'),
          centerTitle: true,

        ),
        body: Center(
          child: Text('Route Not Found'),
      ),
      );
    });
  }
}


