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
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        // border:
        //     const Border.symmetric(vertical: BorderSide(color: Colors.black)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: const Offset(2, 0),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width >= 600 ? 220 : 80,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 20,
          ),
          NavigationItem(
            title: '홈',
            icon: Icon(
              Icons.home,
              color: Theme.of(context).primaryColor,
            ),
            routeName: routeHome,
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
