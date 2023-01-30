import 'package:develop_world/routes/routes.dart';
import 'package:flutter/material.dart';

import 'navigation_item.dart';

class NavigationBarWeb extends StatefulWidget {
  const NavigationBarWeb({
    super.key,
  });

  @override
  State<NavigationBarWeb> createState() => _NavigationBarWebState();
}

class _NavigationBarWebState extends State<NavigationBarWeb> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width >= 600 ? 220 : 80,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 20,
          ),
          NavigationItem(
            title: '인강',
            icon: Icon(
              Icons.computer,
              color: Theme.of(context).primaryColor,
            ),
            routeName: routeLectures,
          ),
          NavigationItem(
            title: '문의',
            icon: Icon(
              Icons.mail,
              color: Theme.of(context).primaryColor,
            ),
            routeName: routeContacts,
          ),
        ],
      ),
    );
  }
}