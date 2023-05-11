import 'package:flutter/widgets.dart';
import 'package:flutter_chat_app/splashpage.dart';
import 'package:flutter_chat_app/login/loginscreen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (context) => SplashPage(),
  LoginScreen.routeName: (context) => LoginScreen(),
  // SignUpPage.routeName: (context) => SignUpPage(),
  // HomePage.routeName: (context) => HomePage(),
  // ProductPage.routeName: (context) => ProductPage(),
  // CartPage.routeName: (context) => CartPage(),
};