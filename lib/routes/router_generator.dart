import 'package:develop_world/routes/routes.dart';
import 'package:develop_world/screens/home/home_screen.dart';
import 'package:develop_world/screens/lecture/lecture_detail.dart';
import 'package:develop_world/screens/lecture/lecture_list.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == routeHome) {
      return PageRouteBuilder(
        settings: settings, // add settings to change the url
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    } else if (settings.name == routeLectures) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LectureList(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    } else if (settings.name == routeContacts) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            const Placeholder(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
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
