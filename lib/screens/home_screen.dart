import 'package:develop_world/widgets/common/navigation_bar_web.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;
  const HomeScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.accessibility_new_rounded),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: (() {}),
              child: TextButton.icon(
                  onPressed: (() {}),
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  icon: const Icon(Icons.login),
                  label: const Text('로그인')),
            )
          ],
          title: const Text(
            'D.W.D',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
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
