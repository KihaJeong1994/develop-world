import 'package:develop_world/config/event_bus.dart';
import 'package:develop_world/model/lecture/lecture.dart';
import 'package:develop_world/model/lecture/lecture_review.dart';
import 'package:develop_world/routes/routes.dart';
import 'package:develop_world/screens/screen_frame.dart';
import 'package:develop_world/services/lecture/lecture_api_service.dart';
import 'package:develop_world/widgets/lecture/lecture_info.dart';
import 'package:develop_world/widgets/lecture/lecture_picture.dart';
import 'package:develop_world/widgets/lecture/lecture_review_form.dart';
import 'package:develop_world/widgets/lecture/lecture_review_list.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              horizontal: 30,
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
  late SharedPreferences prefs;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  onSubmitPressed({
    required String review,
    required double rate,
  }) {
    var reviewInstance = LectureReview(
      id: null,
      lectureId: widget.lectureId,
      // createdBy: window.localStorage['id'] ?? '익명',
      createdBy: prefs.getString('id') ?? '익명',
      review: review,
      rate: rate,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    LectureApiService.insertReview(reviewInstance).then((value) {
      final oldList = pagingController.itemList;
      if (oldList != null) {
        final newList = oldList..insert(0, value);
        pagingController.itemList = newList;
      }
      setState(() {
        isWritingReview = false;
      });
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      SingleEventBus.singleEventBus.fire(SignOutEvent());
      askToLogin();
    });
  }

  onUpdatePressed({
    required LectureReview lectureReview,
    required int index,
  }) {
    LectureApiService.updateReview(lectureReview).then((value) {
      final oldList = pagingController.itemList;
      if (oldList != null) {
        oldList.removeAt(index);
        final newList = oldList..insert(0, value);
        pagingController.itemList = newList;
      }
      setState(() {
        isWritingReview = false;
      });
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      SingleEventBus.singleEventBus.fire(SignOutEvent());
      askToLogin();
    });
  }

  onDeletePressed({
    required String lectureId,
    required String id,
    required int index,
  }) {
    LectureApiService.deleteReview(lectureId, id).then((value) {
      final oldList = pagingController.itemList;
      oldList!.removeAt(index);
      final newList = oldList;
      pagingController.itemList = newList;
      setState(() {});
    }).onError((error, stackTrace) {
      SingleEventBus.singleEventBus.fire(SignOutEvent());
      askToLogin();
    });
  }

  Future<String?> askToLogin() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('로그인을 해주세요'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => navKey.currentState!.pushNamed(routeSignIn),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
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
                  if (prefs.getString('token') == null && !isWritingReview) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('로그인을 해주세요'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () =>
                                navKey.currentState!.pushNamed(routeSignIn),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  isWritingReview = !isWritingReview;
                  showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        LectureReviewForm(onSubmitPressed: onSubmitPressed),
                  );
                });
              }),
              child: const Text('쓰기'),
            )
          ],
        ),
        LectureReviewList(
          lectureId: widget.lectureId,
          pagingController: pagingController,
          onDeletePressed: onDeletePressed,
          onUpdatePressed: onUpdatePressed,
        ),
      ],
    );
  }
}
