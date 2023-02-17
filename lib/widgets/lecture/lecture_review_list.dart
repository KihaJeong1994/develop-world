import 'package:develop_world/model/lecture/lecture_review.dart';
import 'package:develop_world/services/lecture/lecture_api_service.dart';
import 'package:develop_world/widgets/lecture/lecture_review_item.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class LectureReviewList extends StatefulWidget {
  LectureReviewList({
    Key? key,
    required this.lectureId,
    required this.pagingController,
    required this.onDeletePressed,
  }) : super(key: key);

  String lectureId;
  PagingController<int, LectureReview> pagingController;
  Function({required String lectureId, required String id, required int index})
      onDeletePressed;

  @override
  State<LectureReviewList> createState() => _LectureReviewListState();
}

class _LectureReviewListState extends State<LectureReviewList> {
  @override
  void initState() {
    widget.pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newPage = await LectureApiService.getReviewsById(
          id: widget.lectureId, page: pageKey);
      final isLastPage = newPage.last;
      final newItems = newPage.content;
      if (isLastPage) {
        widget.pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        widget.pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      widget.pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: RefreshIndicator(
        child: PagedListView(
          builderDelegate: PagedChildBuilderDelegate<LectureReview>(
            itemBuilder: (context, lectureReview, index) {
              return LectureReviewItem(
                lectureReview: lectureReview,
                index: index,
                onDeletePressed: widget.onDeletePressed,
              );
            },
          ),
          pagingController: widget.pagingController,
        ),
        onRefresh: () => Future.sync(
          () => widget.pagingController.refresh(),
        ),
      ),
    );
  }
}
