import 'dart:convert';
import 'dart:io';

import 'package:develop_world/model/lecture/lecture.dart';
import 'package:develop_world/model/lecture/lecture_review.dart';
import 'package:develop_world/model/page_object.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LectureApiService {
  static final baseUrl = '${dotenv.env['SITE_URL']}/api/lecture';
  static Future<PageObject> searchLecture({
    String? title,
    Site? site,
    num? rate,
    int page = 0,
    int size = 12,
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
    url = '${url}page=$page&';
    url = '${url}size=$size&';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final pageJson = jsonDecode(utf8.decode(response.bodyBytes));
      final PageObject page = PageObject.fromJson(pageJson);
      final List<dynamic> lecturesJson = page.content;
      // jsonDecode(utf8.decode(response.bodyBytes)); // korean broken
      for (var json in lecturesJson) {
        lectures.add(Lecture.fromJson(json));
      }
      page.content = lectures;
      return page;
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

  static Future<PageObject> getReviewsById({
    required String id,
    int page = 0,
    int size = 5,
  }) async {
    List<LectureReview> reviews = [];
    var url = '$baseUrl/$id/review?';
    url = '${url}page=$page&';
    url = '${url}size=$size&';
    url = '${url}sort=updatedAt,desc&';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final pageJson = jsonDecode(utf8.decode(response.bodyBytes));
      final PageObject page = PageObject.fromJson(pageJson);
      final List<dynamic> jsonList = page.content;
      for (var json in jsonList) {
        reviews.add(LectureReview.fromJson(json));
      }
      page.content = reviews;
      return page;
    } else {
      throw Error();
    }
  }

  static Future<LectureReview> insertReview(LectureReview lectureReview) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = '$baseUrl/${lectureReview.lectureId}/review';
    var header = {HttpHeaders.contentTypeHeader: "application/json"};
    // var token = window.localStorage['token'];
    var token = prefs.getString('token');
    if (token != null) {
      header.addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});
    }
    final response = await http.post(
      Uri.parse(url),
      headers: header,
      body: jsonEncode(lectureReview
          .toJson()), // jsonEncode(lectureReview) fails because cannot turn to json directly
    );
    if (response.statusCode == 201) {
      var json = jsonDecode(utf8.decode(response.bodyBytes));
      return LectureReview.fromJson(json);
    }
    throw Error();
  }
}
