import 'package:develop_world/model/lecture_review.dart';
import 'package:develop_world/services/lecture/lecture_api_service.dart';
import 'package:develop_world/widgets/lecture/lecture_review_item.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class LectureReviewList extends StatefulWidget {
  LectureReviewList({
    Key? key,
    required this.lectureId,
  }) : super(key: key);

  String lectureId;

  @override
  State<LectureReviewList> createState() => _LectureReviewListState();
}

class _LectureReviewListState extends State<LectureReviewList> {
  final _pagingController = PagingController<int, LectureReview>(
    firstPageKey: 0,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
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
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
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
              return LectureReviewItem(lectureReview: lectureReview);
            },
          ),
          pagingController: _pagingController,
        ),
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
      ),
    );
  }
}
