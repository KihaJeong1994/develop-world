import 'dart:math';

import 'package:develop_world/model/lecture.dart';
import 'package:develop_world/model/lecture_review.dart';
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
  List<LectureReview> reviews = [
    LectureReview(
      id: "bacd",
      lectureId: "63d722e5b7ced62feb22b86d",
      createdBy: 'cainaoewr',
      review: "너무너무 좋은 강의입니다!",
      rate: 5,
    ),
    LectureReview(
      id: "bacd",
      lectureId: "63d722e5b7ced62feb22b86d",
      createdBy: 'gecewd',
      review: "어서 다음 강의 출시 해주세요~",
      rate: 4.5,
    ),
    LectureReview(
      id: "bacd",
      lectureId: "63d722e5b7ced62feb22b86d",
      createdBy: 'gecaer',
      review: "별로인듯;;",
      rate: 2.5,
    ),
  ];

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
          MediaQuery.of(context).size.width >= 800
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: LecturePicture(id: widget.id, image: image)),
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
                  ],
                ),
          const SizedBox(
            height: 50,
          ),
          Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '수강평',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              LectureReviewList(reviews: reviews),
            ],
          ),
        ],
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

class LectureReviewItem extends StatelessWidget {
  const LectureReviewItem({
    Key? key,
    required this.lectureReview,
  }) : super(key: key);

  final LectureReview lectureReview;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(lectureReview.createdBy),
                  FiveStarRate(rate: lectureReview.rate),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text('${lectureReview.review} '),
            ],
          ),
        ),
      ),
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
