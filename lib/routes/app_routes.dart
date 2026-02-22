import 'package:flutter/widgets.dart';
import 'package:wifi/homepage.dart';
import 'package:wifi/screens/intro_screens/intro_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const IntroPage(),
    '/homepage': (context) => Homepage(),
  };
}
