import 'package:develop_world/model/lecture/lecture_review.dart';
import 'package:develop_world/routes/routes.dart';
import 'package:develop_world/widgets/common/five_star_rate.dart';
import 'package:develop_world/widgets/lecture/lecture_review_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class LectureReviewItem extends StatefulWidget {
  LectureReviewItem({
    Key? key,
    required this.lectureReview,
    required this.index,
    required this.onDeletePressed,
    required this.onUpdatePressed,
  }) : super(key: key);

  final LectureReview lectureReview;
  final int index;
  Function({required String lectureId, required String id, required int index})
      onDeletePressed;
  Function({required LectureReview lectureReview, required int index})
      onUpdatePressed;

  @override
  State<LectureReviewItem> createState() => _LectureReviewItemState();
}

class _LectureReviewItemState extends State<LectureReviewItem> {
  late SharedPreferences prefs;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(1, 1),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(widget.lectureReview.createdBy),
                          const SizedBox(width: 5),
                          Text(
                            timeago.format(widget.lectureReview.updatedAt,
                                locale: 'kr'),
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                      FiveStarRate(
                        rate: widget.lectureReview.rate,
                        starSize: MediaQuery.of(context).size.width >= 800
                            ? null
                            : 15,
                      ),
                    ],
                  ),
                  if (prefs.getString('id') == widget.lectureReview.createdBy)
                    Row(
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (prefs.getString('token') == null) {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('로그인을 해주세요'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => context.pop(),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              context.push(routeSignIn),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                  return;
                                }
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => LectureReviewForm(
                                    onUpdatePressed: widget.onUpdatePressed,
                                    index: widget.index,
                                    lectureReview: widget.lectureReview,
                                  ),
                                );
                              });
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              askDelete(context);
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text('${widget.lectureReview.review} '),
            ],
          ),
        ),
      ),
    );
  }

  void askDelete(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('삭제하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onDeletePressed(
                  lectureId: widget.lectureReview.lectureId!,
                  id: widget.lectureReview.id!,
                  index: widget.index);
              context.pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
