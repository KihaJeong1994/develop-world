import 'package:develop_world/routes/routes.dart';
import 'package:develop_world/screens/account/sign_in_screen.dart';
import 'package:develop_world/screens/account/sign_up_screen.dart';
import 'package:develop_world/screens/home/home_screen.dart';
import 'package:develop_world/screens/lecture/lecture_detail.dart';
import 'package:develop_world/screens/lecture/lecture_list.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //home
    if (settings.name == routeHome) {
      return PageRouteBuilder(
        settings: settings, // add settings to change the url
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
      // sign in
    } else if (settings.name == routeSignIn) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
      // sign up
    } else if (settings.name == routeSignUp) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => SignUpScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
      // lectures
    } else if (settings.name == routeLectures) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LectureList(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
      // contacts
    } else if (settings.name == routeContacts) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            const Placeholder(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
      // lecture detail
    } else if (isLectureDetail(settings.name)) {
      var id = settings.name!.split('/').last;
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            LectureDetail(id: id),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    } else {
      // home(default)
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }
  }

  static bool isLectureDetail(String? name) {
    return name != null &&
        name.split('/').length == 3 &&
        name.split('/')[1] == 'lecture';
  }
}
