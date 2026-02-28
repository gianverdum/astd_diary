import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_webapi_first_course/services/http_interceptors.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //TODO: Endpoint modularization needed
  static const String url = 'http://192.168.15.88:3000/';

  http.Client client =
      InterceptedClient.build(interceptors: [LoggerInterceptor()]);

  Future<void> login({required String email, required String password}) async {
    http.Response response = await client.post(Uri.parse('${url}login'), body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode != 200) {
      String content = json.decode(response.body);
      switch (content) {
        case 'Cannot find user':
          throw UserNotFindException();
      }
      throw HttpException(response.body);
    }

    saveUserInfo(response.body);
  }

  Future<void> register(
      {required String email, required String password}) async {
    http.Response response =
        await client.post(Uri.parse('${url}register'), body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode != 201){
      String content = json.decode(response.body);
      switch (content) {
        case 'User already exists':
          throw UserAlreadyExistsException();
      }
      throw HttpException(response.body);
    }

    saveUserInfo(response.body);
  }

  Future<void> saveUserInfo(String body) async {
    Map<String, dynamic> map = json.decode(body);

    String token = map['accessToken'];
    String email = map['user']['email'];
    int id = map['user']['id'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', token);
    prefs.setString('email', email);
    prefs.setInt('id', id);
  }
}

class UserNotFindException implements Exception {}
class UserAlreadyExistsException implements Exception {}
