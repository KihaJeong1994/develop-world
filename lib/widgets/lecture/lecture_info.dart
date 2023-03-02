import 'package:develop_world/model/lecture/lecture.dart';
import 'package:develop_world/widgets/common/five_star_rate.dart';
import 'package:flutter/material.dart';
import 'package:seo/seo.dart';
import 'package:url_launcher/url_launcher.dart';

class LectureInfo extends StatelessWidget {
  LectureInfo({
    Key? key,
    required this.lecture,
  }) : super(key: key);
  Lecture lecture;

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(lecture.url))) {
      throw Exception('Could not launch ${lecture.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Seo.text(
            text: lecture.title,
            child: Text(
              lecture.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(lecture.site.name),
          ),
          Row(
            children: [
              FiveStarRate(rate: lecture.rate),
              Text(
                ' (${lecture.reviewsCnt}명)',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              )
            ],
          ),
          Seo.text(
            text: lecture.description,
            child: Text(
              lecture.description,
            ),
          ),
        ],
      ),
    );
  }
}
