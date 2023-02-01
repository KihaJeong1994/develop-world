import 'dart:convert';

import 'package:develop_world/model/lecture.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LectureApiService {
  static final baseUrl = '${dotenv.env['SITE_URL']}/api/lecture';
  static Future<List<Lecture>> searchLecture({
    String? title,
    Site? site,
    num? rate,
  }) async {
    List<Lecture> lectures = [];
    var url = '$baseUrl?';

    if (title != null) {
      url = '${url}title=$title&';
    }
    if (site != null) {
      url = '${url}site=${site.siteToString()}&';
    }
    if (rate != null) {
      url = '${url}rate=$rate&';
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> lecturesJson =
          jsonDecode(utf8.decode(response.bodyBytes)); // korean broken
      for (var json in lecturesJson) {
        lectures.add(Lecture.fromJson(json));
      }
      return lectures;
    } else {
      throw Error();
    }
  }

  static Future<Lecture> getLectureDetailById(String id) async {
    var url = '$baseUrl/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      return Lecture.fromJson(json);
    } else {
      throw Error();
    }
  }
}
