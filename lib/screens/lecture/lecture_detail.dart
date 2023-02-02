import 'package:develop_world/model/lecture.dart';
import 'package:develop_world/model/lecture_review.dart';
import 'package:develop_world/services/lecture/lecture_api_service.dart';
import 'package:develop_world/widgets/lecture/lecture_info.dart';
import 'package:develop_world/widgets/lecture/lecture_picture.dart';
import 'package:develop_world/widgets/lecture/lecture_review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class LectureDetail extends StatefulWidget {
  final String id;
  const LectureDetail({
    super.key,
    required this.id,
  });

  @override
  State<LectureDetail> createState() => _LectureDetailState();
}

class _LectureDetailState extends State<LectureDetail> {
  late Future<Lecture> lectureFuture;
  late Future<List<LectureReview>> reviewListFuture;

  @override
  void initState() {
    super.initState();
    lectureFuture = LectureApiService.getLectureDetailById(widget.id);
    reviewListFuture = LectureApiService.getReviewsById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: Column(
              children: [
                FutureBuilder(
                  future: lectureFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return LectureDetailPart(lecture: snapshot.data!);
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                FutureBuilder(
                  future: reviewListFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return LectureReviewPart(
                          lectureId: widget.id, reviews: snapshot.data!);
                    }
                    return const CircularProgressIndicator();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LectureDetailPart extends StatelessWidget {
  const LectureDetailPart({
    Key? key,
    required this.lecture,
  }) : super(key: key);

  final Lecture lecture;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MediaQuery.of(context).size.width >= 800
          ? Row(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: LecturePicture(image: lecture.image)),
                Flexible(child: LectureInfo(lecture: lecture)),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: LecturePicture(image: lecture.image)),
                Flexible(child: LectureInfo(lecture: lecture)),
              ],
            ),
    );
  }
}

class LectureReviewPart extends StatefulWidget {
  LectureReviewPart({
    Key? key,
    required this.lectureId,
    required this.reviews,
  }) : super(key: key);

  String lectureId;
  final List<LectureReview> reviews;

  @override
  State<LectureReviewPart> createState() => _LectureReviewPartState();
}

class _LectureReviewPartState extends State<LectureReviewPart> {
  bool isWritingReview = false;
  onSubmitPressed({required String review, required double rate}) {
    setState(() {
      var reviewInstance = LectureReview(
        id: null,
        lectureId: widget.lectureId,
        createdBy: "Spring master",
        review: review,
        rate: rate,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      LectureApiService.insertReview(reviewInstance);
      isWritingReview = false;
      widget.reviews.insert(0, reviewInstance);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '수강평',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (() {
                setState(() {
                  isWritingReview = !isWritingReview;
                });
              }),
              child: Text(!isWritingReview ? '쓰기' : '취소'),
            )
          ],
        ),
        if (isWritingReview)
          LectureReviewForm(onSubmitPressed: onSubmitPressed),
        LectureReviewList(reviews: widget.reviews),
      ],
    );
  }
}

class LectureReviewForm extends StatelessWidget {
  Function({required String review, required double rate}) onSubmitPressed;
  LectureReviewForm({
    Key? key,
    required this.onSubmitPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lectureReviewController = TextEditingController();
    String review = '';
    double rate = 5;
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
            const Text('Spring master'),
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
                  initialRating: 5,
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
                  onPressed: () => onSubmitPressed(
                    review: review,
                    rate: rate,
                  ),
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

class LectureReviewList extends StatelessWidget {
  const LectureReviewList({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  final List<LectureReview> reviews;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return LectureReviewItem(lectureReview: reviews[index]);
        },
      ),
    );
  }
}
