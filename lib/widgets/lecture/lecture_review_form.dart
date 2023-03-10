import 'package:develop_world/model/lecture/lecture_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LectureReviewForm extends StatefulWidget {
  Function({required String review, required double rate})? onSubmitPressed;
  Function({required LectureReview lectureReview, required int index})?
      onUpdatePressed;
  int? index;
  LectureReview? lectureReview;
  LectureReviewForm({
    Key? key,
    this.onSubmitPressed,
    this.onUpdatePressed,
    this.index,
    this.lectureReview,
  }) : super(key: key);

  @override
  State<LectureReviewForm> createState() => _LectureReviewFormState();
}

class _LectureReviewFormState extends State<LectureReviewForm> {
  String? id = '익명';
  late SharedPreferences prefs;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final lectureReviewController = TextEditingController();
    String review = '';
    double rate = 5;
    if (widget.lectureReview != null) {
      lectureReviewController.text = widget.lectureReview!.review;
      review = widget.lectureReview!.review;
      rate = widget.lectureReview!.rate;
    }
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 220,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(id ?? '익명'),
            const SizedBox(height: 5),
            TextField(
              controller: lectureReviewController,
              onChanged: (value) {
                review = value;
              },
              maxLines: 7,
              decoration: const InputDecoration.collapsed(
                filled: true,
                fillColor: Colors.white,
                hintText: "수강평을 입력해주세요",
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingBar.builder(
                  itemSize: 25,
                  initialRating: rate,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    rate = rating;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (widget.onSubmitPressed != null) {
                      widget.onSubmitPressed!(
                        review: review,
                        rate: rate,
                      );
                    } else if (widget.onUpdatePressed != null) {
                      widget.lectureReview!.review = review;
                      widget.lectureReview!.rate = rate;
                      widget.onUpdatePressed!(
                        lectureReview: widget.lectureReview!,
                        index: widget.index!,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.8)),
                  child: const Text('입력'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
