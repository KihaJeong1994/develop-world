import 'package:develop_world/model/lecture/lecture.dart';
import 'package:develop_world/routes/routes.dart';
import 'package:develop_world/widgets/common/five_star_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:image_card/image_card.dart';

const maxRate = 5;

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
  late final imageUrl;
  @override
  void initState() {
    super.initState();
    imageUrl = '${dotenv.env['IMAGE_URL']}/lectures';
  }

  @override
  Widget build(BuildContext context) {
    final double scale = _hover ? 1.01 : 1.0;
    var lecture = widget.lecture;
    return GestureDetector(
      onTap: () {
        context.push('$routeLectures/${lecture.id}');
      },
      child: MouseRegion(
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
                  width: double.infinity, // make child follow parent width
                  heightImage:
                      MediaQuery.of(context).size.width >= 800 ? 160 : 80,
                  imageProvider: NetworkImage(
                    '$imageUrl/${lecture.image}',
                  ),
                  // tags: [_tag('Category', () {}), _tag('Product', () {})],
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: lecture.title.replaceAll('', '\u{200B}'),
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
                  description: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lecture.site.name,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FiveStarRate(
                            rate: lecture.rate,
                            starSize: MediaQuery.of(context).size.width >= 800
                                ? null
                                : 18,
                          ),
                          Text(
                            ' (${lecture.reviewsCnt}명)',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
    // return OpenContainer(
    //   transitionType: ContainerTransitionType.fadeThrough,
    //   closedBuilder: (context, action) {
    //     var lecture = widget.lecture;
    //     return MouseRegion(
    //       onEnter: (_) {
    //         setState(() {
    //           _hover = true;
    //         });
    //       },
    //       onExit: (_) {
    //         setState(() {
    //           _hover = false;
    //         });
    //       },
    //       child: AnimatedContainer(
    //           transform: Matrix4.diagonal3Values(scale, scale, 1),
    //           duration: const Duration(milliseconds: 200),
    //           curve: Curves.easeInOut,
    //           child: Column(
    //             children: [
    //               FillImageCard(
    //                 // width: 320,
    //                 // heightImage: 160,
    //                 imageProvider: AssetImage(
    //                   'images/lectures/${lecture.image}',
    //                 ),
    //                 // tags: [_tag('Category', () {}), _tag('Product', () {})],
    //                 title: RichText(
    //                   text: TextSpan(
    //                     children: [
    //                       TextSpan(
    //                         text: lecture.title.replaceAll('', '\u{200B}'),
    //                         style: const TextStyle(
    //                           fontFamily: 'Diodrum',
    //                           color: Colors.black,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //                 // Text(
    //                 //   '${widget.lecture.title}',
    //                 //   overflow: TextOverflow.ellipsis,
    //                 // ),
    //                 description: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       lecture.site.name,
    //                       style: const TextStyle(
    //                         color: Colors.grey,
    //                       ),
    //                     ),
    //                     FiveStarRate(lecture: lecture),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           )),
    //     );
    //   },
    //   openBuilder: (context, action) {
    //     return Scaffold(
    //       appBar: AppBar(
    //         leading: IconButton(
    //           icon: const Icon(Icons.arrow_back_ios),
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //         ),
    //         title: Text(widget.lecture.title),
    //       ),
    //       body: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Image.asset(
    //                 'images/lectures/${widget.lecture.image}',
    //                 width: MediaQuery.of(context).size.width / 2,
    //                 height: MediaQuery.of(context).size.width / 4,
    //               ),
    //               Expanded(
    //                 child: Table(
    //                   border: TableBorder.all(),
    //                   columnWidths: const <int, TableColumnWidth>{
    //                     0: IntrinsicColumnWidth(),
    //                     1: FlexColumnWidth(),
    //                   },
    //                   defaultVerticalAlignment:
    //                       TableCellVerticalAlignment.middle,
    //                   children: <TableRow>[
    //                     TableRow(
    //                       children: <Widget>[
    //                         const SizedBox(
    //                           child: Text('제목'),
    //                         ),
    //                         TableCell(
    //                           verticalAlignment: TableCellVerticalAlignment.top,
    //                           child: SizedBox(
    //                             child: RichText(
    //                               text: TextSpan(
    //                                 children: [
    //                                   TextSpan(
    //                                     text: widget.lecture.title
    //                                         .replaceAll('', '\u{200B}'),
    //                                     style: const TextStyle(
    //                                       fontFamily: 'Diodrum',
    //                                       color: Colors.black,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                               maxLines: 2,
    //                               // overflow: TextOverflow.ellipsis,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     TableRow(
    //                       children: <Widget>[
    //                         const SizedBox(
    //                           child: Text('사이트'),
    //                         ),
    //                         Container(
    //                           child: Text(
    //                             widget.lecture.site.name,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
