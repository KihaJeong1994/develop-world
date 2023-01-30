import 'package:develop_world/routes/routes.dart';
import 'package:develop_world/widgets/lecture/lecture_list.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return PageRouteBuilder(
          settings: settings, // add settings to change the url
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LectureList(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
      case routeLectures:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LectureList(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
      case routeContacts:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const Placeholder(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
      default:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LectureList(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
    }
  }
}
