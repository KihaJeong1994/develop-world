import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LecturePicture extends StatefulWidget {
  const LecturePicture({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  State<LecturePicture> createState() => _LecturePictureState();
}

class _LecturePictureState extends State<LecturePicture> {
  late final imageUrl;
  @override
  void initState() {
    super.initState();
    imageUrl = '${dotenv.env['IMAGE_URL']}/lectures';
  }

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
      child: Image.network(
        '$imageUrl/${widget.image}',
        width: width,
        height: width / 1.5,
      ),
    );
  }
}
