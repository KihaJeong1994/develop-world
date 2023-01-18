import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';

import '../../model/lecture.dart';

class LectureItem extends StatefulWidget {
  const LectureItem({
    Key? key,
    required this.lecture,
  }) : super(key: key);

  final Lecture lecture;

  @override
  State<LectureItem> createState() => _LectureItemState();
}

class _LectureItemState extends State<LectureItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final double scale = _hover ? 1.01 : 1.0;
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hover = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hover = false;
        });
      },
      child: AnimatedContainer(
          transform: Matrix4.diagonal3Values(scale, scale, 1),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Column(
            children: [
              FillImageCard(
                // width: 320,
                // heightImage: 160,
                imageProvider: AssetImage(
                  'images/lectures/${widget.lecture.image}',
                ),
                // tags: [_tag('Category', () {}), _tag('Product', () {})],
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.lecture.title.replaceAll('', '\u{200B}'),
                        style: const TextStyle(
                          fontFamily: 'Diodrum',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // Text(
                //   '${widget.lecture.title}',
                //   overflow: TextOverflow.ellipsis,
                // ),
                description: Text(
                  widget.lecture.site.name,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              // Image.asset(
              //   'images/lectures/${lecture.image}',
              //   width: 320,
              //   height: 160,
              // ), // chrome & macos path is different
            ],
          )),
    );
  }
}
