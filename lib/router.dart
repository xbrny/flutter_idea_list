import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:idea_list/api/idea_api.dart';
import 'package:idea_list/api/user_api.dart';
import 'package:idea_list/screen/idea_create_screen.dart';
import 'package:idea_list/screen/idea_details_screen.dart';
import 'package:idea_list/screen/idea_list_screen.dart';
import 'package:idea_list/screen/splash_screen.dart.dart';
import 'package:idea_list/screen/user_login_screen.dart';
import 'package:idea_list/screen/user_register_screen.dart';
import 'package:idea_list/view_model/idea_form_model.dart';
import 'package:idea_list/view_model/idea_list_model.dart';
import 'package:idea_list/view_model/login_model.dart';
import 'package:idea_list/view_model/register_model.dart';
import 'package:provider/provider.dart';

class Router {
  static const splashScreen = 'splash';
  static const ideaList = 'idea-list';
  static const ideaCreate = 'idea-create';
  static const ideaDetails = 'idea-details';
  static const userLogin = 'user-login';
  static const userRegister = 'user-register';

  static const initialRoute = splashScreen;

  static Route generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) {
        switch (settings.name) {
          case splashScreen:
            return SplashScreen();
          case ideaList:
            return IdeaListScreen();
          case ideaCreate:
            return ChangeNotifierProxyProvider3<IdeaListModel, FirebaseUser,
                IdeaApi, IdeaFormModel>(
              builder: (_, ideaNotifier, authUser, ideaApi, __) =>
                  IdeaFormModel(
                ideaListModel: ideaNotifier,
                authUser: authUser,
                ideaApi: ideaApi,
              ),
              child: IdeaCreateScreen(idea: settings.arguments),
            );
          case ideaDetails:
            return IdeaDetailsScreen(idea: settings.arguments);
          case userLogin:
            return ChangeNotifierProxyProvider<UserApi, LoginModel>(
              builder: (_, userApi, __) => LoginModel(userApi),
              child: UserLoginScreen(),
            );
          case userRegister:
            return ChangeNotifierProxyProvider<UserApi, RegisterModel>(
              builder: (_, userApi, __) => RegisterModel(userApi),
              child: UserRegisterScreen(),
            );
          default:
            return Scaffold(
              body: Container(
                child: Text('Page not found'),
              ),
            );
        }
      },
    );
  }
}
