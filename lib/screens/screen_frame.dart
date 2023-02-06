import 'package:develop_world/routes/routes.dart';
import 'package:develop_world/widgets/common/navigation_bar_web.dart';
import 'package:flutter/material.dart';

class ScreenFrame extends StatelessWidget {
  final Widget child;
  const ScreenFrame({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(Icons.accessibility_new_rounded),
          //   onPressed: () {
          //     navKey.currentState!.pushNamed(routeHome);
          //   },
          // ),
          actions: <Widget>[
            TextButton.icon(
              onPressed: (() {
                navKey.currentState!.pushNamed(routeSignIn);
              }),
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              icon: const Icon(Icons.login),
              label: const Text('로그인'),
            )
          ],
          title: TextButton(
            onPressed: () {
              navKey.currentState!.pushNamed(routeHome);
            },
            child: const Text(
              'D.W.D',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: false,
        ),
        body: Row(
          children: [
            const SafeArea(child: NavigationBarWeb()),
            Expanded(child: child),
          ],
        ));
  }
}
