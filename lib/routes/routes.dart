import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetworkapp/common/Loading/LoadingPage.dart';
import 'package:socialnetworkapp/modules/authentication/bloc/register_bloc.dart';
import 'package:socialnetworkapp/modules/authentication/login/login_page.dart';
import 'package:socialnetworkapp/modules/authentication/wrapper/service/register_service.dart';
import 'package:socialnetworkapp/modules/comments/blocs/comment_bloc.dart';
import 'package:socialnetworkapp/modules/comments/repos/comment_repo.dart';
import 'package:socialnetworkapp/modules/food/blocs/ListFoodBloC.dart';
import 'package:socialnetworkapp/modules/post/blocs/CreatePostBloc.dart';
import 'package:socialnetworkapp/modules/post/blocs/list_post_rxdart_bloc.dart';
import 'package:socialnetworkapp/modules/post/pages/CreatePostPage.dart';
import 'package:socialnetworkapp/modules/post/pages/HomePage_Paging.dart';
import 'package:socialnetworkapp/modules/post/pages/detail_post_page.dart';
import 'package:socialnetworkapp/modules/post/repos/CreatePostRepo.dart';
import 'package:socialnetworkapp/modules/post/repos/list_post_paging_repo.dart';
import 'package:socialnetworkapp/modules/profile/page/ProfilePage.dart';
import 'package:socialnetworkapp/routes/RouteName.dart';

import '../modules/authentication/bloc/authentication_bloc.dart';
import '../modules/authentication/login/register_account_page.dart';
import '../modules/authentication/wrapper/service/app_auth_service.dart';
import '../modules/food/pages/FoodListPage.dart';
import '../modules/post/pages/HomePage.dart';
import '../providers/bloc_provider.dart';


class Routes {


  static Route<dynamic> authorizedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return _buildRoute(
          routeSettings,
          BloCProvider(
            bloc: ListPostRxDartBloc(ListPostPageRepo()),
            child: HomePage_Paging(),
            // ,
          ),
        );
      case "/create-post"://RouteName.createPostPage:
        return _buildRoute(
          routeSettings,
          BloCProvider(
            child: CreatePostPage(),
            bloc: CreatePostBloc(CreatePostRepo()),
          ),
        );
      case "/detailsPost":
        return _buildRoute(
          routeSettings,
          BloCProvider(
            child: DetailPostPage(),
            bloc: CommentRxDartBloc(CommentRepo()),
          ),
        );
      case "/profile":
        return _buildRoute(
          routeSettings,
          BloCProvider(
            child: ProfilePage(),
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
          BloCProvider(
            child: RegisterAccountPage(),
            bloc: RegisterBloc(RegisterService()),
          ),
        );
      default:
        return ErrorRoute();
    }
  }

  static Route<dynamic> registernewAccount(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return _buildRoute(
          routeSettings,
          RegisterAccountPage(),
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
          child: Text('Trang không tồn tại ...'),
      ),
      );
    });
  }
}


