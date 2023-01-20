import 'package:develop_world/widgets/lecture/lecture_item.dart';
import 'package:flutter/material.dart';

import '../../model/lecture.dart';

class LectureList extends StatelessWidget {
  LectureList({
    Key? key,
  }) : super(key: key);

  var lectures = [
    Lecture(
      title: '스프링 입문 - 코드로 배우는 스프링 부트, 웹 MVC, DB 접근 기술',
      site: Site.inflearn,
      image: 'lecture1.png',
      rate: 4.3,
    ),
    Lecture(
      title: '10개 프로젝트로 완성하는 백엔드 웹개발(Java/Spring)',
      site: Site.fastcampus,
      image: 'lecture2.png',
      rate: 3.5,
    ),
    Lecture(
      title: '[코드팩토리] [입문] Dart 언어 4시간만에 완전정복',
      site: Site.inflearn,
      image: 'lecture3.jpeg',
      rate: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio:
              MediaQuery.of(context).size.width >= 800 ? 300 / 330 : 300 / 390,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        children: [for (var lecture in lectures) LectureItem(lecture: lecture)],
      ),
    );
  }
}
