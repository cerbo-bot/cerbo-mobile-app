// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../ui/views/home/home_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/news/news_view.dart';
import '../ui/views/startup/startup_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String homeView = '/home-view';
  static const String loginView = '/login-view';
  static const String newsView = '/news-view';
  static const all = <String>{
    startUpView,
    homeView,
    loginView,
    newsView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.newsView, page: NewsView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartUpView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    NewsView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => NewsView(),
        settings: data,
      );
    },
  };
}
