import 'dart:convert';

import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

class JournalService {
  static const String url = 'http://192.168.15.88:3000/';
  static const String resource = 'journals/';

  http.Client client =
      InterceptedClient.build(interceptors: [LoggerInterceptor()]);

  String getUrl() {
    return url + resource;
  }

  Future<void> register(Journal journal, {required String token}) async {
    String content = json.encode(journal.toMap());
    await client.post(Uri.parse(getUrl()),
        headers: {
          'Content-type': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: content);
  }

  Future<List<Journal>> getAll(
      {required String id, required String token}) async {
    http.Response response = await client.get(
        Uri.parse("${getUrl()}?userId=$id"),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 401) {
      throw Exception("unauthorized");
    }
    if (response.statusCode == 403) {
      // User has no journals yet, return empty list
      return [];
    }
    if (response.statusCode != 200) {
      throw Exception("Failed to load journals");
    }

    List<Journal> list = [];
    List<dynamic> decoded = json.decode(response.body);

    for (var jsonMap in decoded) {
      list.add(Journal.fromMap(jsonMap));
    }
    return list;
  }

  Future<void> edit(String id, Journal journal, {required String token}) async {
    String content = json.encode(journal.toMap());
    await client.put(Uri.parse("${getUrl()}$id"),
        headers: {
          'Content-type': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: content);
  }

  Future<void> delete(String id, {required String token}) async {
    await client.delete(Uri.parse("${getUrl()}$id"),
    headers: {"authorization": "Bearer $token"});
  }
}
