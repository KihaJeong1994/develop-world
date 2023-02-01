import 'dart:math';

import 'package:flutter/material.dart';

class LecturePicture extends StatelessWidget {
  const LecturePicture({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    double width = max(300, MediaQuery.of(context).size.width / 3);
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(5, 5),
            blurRadius: 15,
          )
        ],
      ),
      child: Image.asset(
        'images/lectures/$image',
        width: width,
        height: width / 1.5,
      ),
    );
  }
}
