import 'package:cocktails/ui/cocktail-detail.dart';
import 'package:cocktails/ui/home_page.dart';
import 'package:cocktails/ui/splash_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    case '/':
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case 'home' :
      return MaterialPageRoute(builder: (context) => const HomePage());
    default :
      return MaterialPageRoute(builder: (context) => const HomePage());
  }

}