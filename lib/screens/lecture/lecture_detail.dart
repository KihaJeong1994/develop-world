import 'package:develop_world/model/lecture.dart';
import 'package:develop_world/model/lecture_review.dart';
import 'package:develop_world/services/lecture/lecture_api_service.dart';
import 'package:develop_world/widgets/lecture/lecture_info.dart';
import 'package:develop_world/widgets/lecture/lecture_picture.dart';
import 'package:develop_world/widgets/lecture/lecture_review_form.dart';
import 'package:develop_world/widgets/lecture/lecture_review_list.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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

  @override
  void initState() {
    super.initState();
    lectureFuture = LectureApiService.getLectureDetailById(widget.id);
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
                LectureReviewPart(lectureId: widget.id),
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
  }) : super(key: key);

  String lectureId;

  @override
  State<LectureReviewPart> createState() => _LectureReviewPartState();
}

class _LectureReviewPartState extends State<LectureReviewPart> {
  bool isWritingReview = false;
  final pagingController = PagingController<int, LectureReview>(
    firstPageKey: 0,
  );
  onSubmitPressed({
    required String review,
    required double rate,
  }) {
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
      final oldList = pagingController.itemList;
      if (oldList != null) {
        final newList = oldList..insert(0, reviewInstance);
        pagingController.itemList = newList;
      }
      isWritingReview = false;
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
        LectureReviewList(
          lectureId: widget.lectureId,
          pagingController: pagingController,
        ),
      ],
    );
  }
}
