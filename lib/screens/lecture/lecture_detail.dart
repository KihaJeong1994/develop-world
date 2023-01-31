import 'dart:math';

import 'package:develop_world/model/lecture.dart';
import 'package:develop_world/widgets/common/five_star_rate.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String image = 'lecture1.png';

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
        MediaQuery.of(context).size.width >= 800
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: LecturePicture(id: widget.id, image: image)),
                  Flexible(child: LectureInfo()),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Flexible(
                        child: LecturePicture(id: widget.id, image: image)),
                    Flexible(child: LectureInfo()),
                  ]),
      ],
    );
  }
}

class LectureInfo extends StatelessWidget {
  LectureInfo({
    Key? key,
  }) : super(key: key);

  String title = '스프링 입문 - 코드로 배우는 스프링 부트, 웹 MVC, DB 접근 기술';
  Site site = Site.inflearn;
  double rate = 4.3;
  String url =
      'https://www.inflearn.com/course/%EC%8A%A4%ED%94%84%EB%A7%81-%EC%9E%85%EB%AC%B8-%EC%8A%A4%ED%94%84%EB%A7%81%EB%B6%80%ED%8A%B8';
  String description =
      '스프링 입문자가 예제를 만들어가면서 스프링 웹 애플리케이션 개발 전반을 빠르게 학습할 수 있습니다.';
  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title),
          TextButton(
            onPressed: _launchUrl,
            child: Text(site.name),
          ),
          FiveStarRate(rate: rate),
          Text(
            description,
          ),
        ],
      ),
    );
  }
}

class LecturePicture extends StatelessWidget {
  const LecturePicture({
    Key? key,
    required this.id,
    required this.image,
  }) : super(key: key);

  final String id;
  final String image;

  @override
  Widget build(BuildContext context) {
    double width = max(300, MediaQuery.of(context).size.width / 3);
    return Hero(
      tag: id,
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
          ],
        ),
        child: Image.asset(
          'images/lectures/$image',
          width: width,
          height: width / 1.5,
        ),
      ),
    );
  }
}
