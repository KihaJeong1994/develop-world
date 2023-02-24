import 'dart:convert';
import 'dart:io';

import 'package:develop_world/model/contacts/contact.dart';
import 'package:develop_world/model/page_object.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ContactApiService {
  static final baseUrl = '${dotenv.env['SITE_URL']}/api/contact';
  static Future<PageObject> searchContacts({
    String? title,
    String? description,
    String? createdBy,
    int page = 0,
    int size = 10,
  }) async {
    List<Contact> contacts = [];
    var url = '$baseUrl?';

    if (title != null) {
      url = '${url}title=$title&';
    }
    if (description != null) {
      url = '${url}description=$description&';
    }
    if (createdBy != null) {
      url = '${url}createdBy=$createdBy&';
    }
    url = '${url}page=$page&';
    url = '${url}size=$size&';
    url = '${url}sort=updatedAt,desc&';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final pageJson = jsonDecode(utf8.decode(response.bodyBytes));
      final PageObject page = PageObject.fromJson(pageJson);
      final List<dynamic> contactsJson = page.content;
      // jsonDecode(utf8.decode(response.bodyBytes)); // korean broken
      for (var json in contactsJson) {
        contacts.add(Contact.fromJson(json));
      }
      page.content = contacts;
      return page;
    } else {
      throw Error();
    }
  }

  static Future<Contact> getContactDetailById(String id) async {
    var url = '$baseUrl/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      return Contact.fromJson(json);
    } else {
      throw Error();
    }
  }

  static Future<Contact> insertContact(Contact contact) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = baseUrl;
    var header = {HttpHeaders.contentTypeHeader: "application/json"};
    var token = prefs.getString('token');
    if (token != null) {
      header.addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});
    }
    final response = await http.post(
      Uri.parse(url),
      headers: header,
      body: jsonEncode(contact.toJson()),
    );
    if (response.statusCode == 201) {
      var json = jsonDecode(utf8.decode(response.bodyBytes));
      return Contact.fromJson(json);
    }
    throw Error();
  }

  static Future<Contact> updateContact(Contact contact) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = baseUrl;
    var header = {HttpHeaders.contentTypeHeader: "application/json"};
    var token = prefs.getString('token');
    if (token != null) {
      header.addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});
    }
    final response = await http.put(
      Uri.parse(url),
      headers: header,
      body: jsonEncode(contact.toJson()),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(utf8.decode(response.bodyBytes));
      return Contact.fromJson(json);
    }
    throw Error();
  }

  static Future<void> deleteContact(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = '$baseUrl?';
    url = '${url}id=$id&';
    Map<String, String> header = {};
    var token = prefs.getString('token');
    if (token != null) {
      header.addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});
    }
    final response = await http.delete(
      Uri.parse(url),
      headers: header,
    );
    if (response.statusCode == 200) {
      return;
    }
    throw Error();
  }
}
