import 'package:develop_world/model/lecture/lecture.dart';
import 'package:develop_world/services/lecture/lecture_api_service.dart';
import 'package:develop_world/widgets/lecture/lecture_item.dart';
import 'package:develop_world/widgets/lecture/lecture_search.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class LectureList extends StatefulWidget {
  const LectureList({
    Key? key,
  }) : super(key: key);

  @override
  State<LectureList> createState() => _LectureListState();
}

class _LectureListState extends State<LectureList> {
  String? title;
  Site? site;
  num? rate;
  final _pagingController = PagingController<int, Lecture>(
    firstPageKey: 0,
  );

  onSearchPressed(
      {String? titleSearch, Site? selectedSite, num? selectedRate}) {
    setState(() {
      if (titleSearch != null && titleSearch!.isEmpty) {
        titleSearch = null;
      }
      title = titleSearch;
      site = selectedSite;
      rate = selectedRate;
      _pagingController.refresh();
    });
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newPage = await LectureApiService.searchLecture(
          title: title, site: site, rate: rate, page: pageKey);
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
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          LectureSearch(onSearchPressed: onSearchPressed),
          Expanded(
            child: RefreshIndicator(
              child: PagedGridView(
                builderDelegate: PagedChildBuilderDelegate<Lecture>(
                  itemBuilder: (context, lecture, index) {
                    return LectureItem(lecture: lecture);
                  },
                ),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: MediaQuery.of(context).size.width >= 800
                      ? 300 / 340
                      : 300 / 390,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                pagingController: _pagingController,
              ),
              onRefresh: () => Future.sync(
                () => _pagingController.refresh(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
