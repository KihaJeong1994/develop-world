import 'package:develop_world/routes/routes.dart';
import 'package:flutter/material.dart';

class NavigationItem extends StatelessWidget {
  final String title, routeName;
  final Icon icon;
  const NavigationItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        navKey.currentState!.pushNamed(routeName);
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: MouseRegion(
          onHover: (event) {}, // TODO: add hover effect
          child: MediaQuery.of(context).size.width >= 600
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    icon,
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                )
              : icon,
        ),
      ),
    );
  }
}
