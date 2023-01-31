import 'package:develop_world/model/lecture.dart';
import 'package:develop_world/widgets/common/five_star_rate.dart';
import 'package:flutter/material.dart';

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
  String title = '스프링 입문 - 코드로 배우는 스프링 부트, 웹 MVC, DB 접근 기술';
  Site site = Site.inflearn;
  double rate = 4.3;
  String image = 'lecture1.png';
  String url =
      'https://www.inflearn.com/course/%EC%8A%A4%ED%94%84%EB%A7%81-%EC%9E%85%EB%AC%B8-%EC%8A%A4%ED%94%84%EB%A7%81%EB%B6%80%ED%8A%B8';
  String description =
      '스프링 입문자가 예제를 만들어가면서 스프링 웹 애플리케이션 개발 전반을 빠르게 학습할 수 있습니다.';
  @override
  Widget build(BuildContext context) {
    return Column(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: widget.id,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(5, 5),
                        blurRadius: 15,
                      )
                    ]),
                child: Image.asset(
                  'images/lectures/$image',
                  width: 500,
                ),
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            Column(
              children: [
                Text(title),
                Text(site.name),
                Row(
                  children: [
                    FiveStarRate(rate: rate),
                  ],
                ),
                Text(description),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
