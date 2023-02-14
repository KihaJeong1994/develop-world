import 'package:develop_world/model/lecture/lecture_review.dart';
import 'package:develop_world/widgets/common/five_star_rate.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class LectureReviewItem extends StatelessWidget {
  const LectureReviewItem({
    Key? key,
    required this.lectureReview,
  }) : super(key: key);

  final LectureReview lectureReview;

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
                children: [
                  Text(lectureReview.createdBy),
                  const SizedBox(width: 5),
                  Text(
                    timeago.format(lectureReview.updatedAt, locale: 'kr'),
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(width: 5),
                  FiveStarRate(rate: lectureReview.rate),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text('${lectureReview.review} '),
            ],
          ),
        ),
      ),
    );
  }
}
