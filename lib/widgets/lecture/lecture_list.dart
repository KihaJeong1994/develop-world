import 'package:develop_world/services/lecture/lecture_api_service.dart';
import 'package:develop_world/widgets/lecture/lecture_item.dart';
import 'package:flutter/material.dart';

import '../../model/lecture.dart';
import 'lecture_search.dart';

class LectureList extends StatefulWidget {
  const LectureList({
    Key? key,
  }) : super(key: key);

  @override
  State<LectureList> createState() => _LectureListState();
}

class _LectureListState extends State<LectureList> {
  late Future<List<Lecture>> lecturesFuture;

  onSearchPressed(
      {String? titleSearch, Site? selectedSite, num? selectedRate}) {
    setState(() {
      if (titleSearch != null && titleSearch!.isEmpty) {
        titleSearch = null;
      }
      lecturesFuture = LectureApiService.searchLecture(
          title: titleSearch, site: selectedSite, rate: selectedRate);
    });
  }

  @override
  void initState() {
    super.initState();
    lecturesFuture = LectureApiService.searchLecture();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: lecturesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            child: Column(
              children: [
                LectureSearch(onSearchPressed: onSearchPressed),
                Expanded(
                  child: Center(
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio:
                            MediaQuery.of(context).size.width >= 800
                                ? 300 / 330
                                : 300 / 390,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                      children: [
                        for (var lecture in snapshot.data!)
                          LectureItem(lecture: lecture)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
