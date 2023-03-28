import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';
import 'dart:async';

import '../globals/endpoints.dart';
import '../globals/headers.dart';

class Auth with ChangeNotifier {
  int? _userId;
  String? _token;

  bool get isAuth {
    return getToken != null;
  }

  int? get getUserId {
    return _userId;
  }

  String? get getToken {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  Future<String> signup(String username, String email, String password,
      String matchingPassword) async {
    print('Register');
    Map<String, String> header = Headers().getPOSTHeaders;
    var finalUrl = Endpoints().register;
    String? responseData;
    try {
      var response = await http.post(
        Uri.parse(finalUrl),
        headers: header,
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
          'matchingPassword': matchingPassword
        }),
      );
      responseData = (response.body);
    } catch (error) {
      print(error);
      throw error;
    }
    return responseData;
  }

  Future<void> login(String username, String password) async {
    print('Login');
    Map<String, String> header = Headers().getPOSTHeaders;
    var finalUrl = Endpoints().login;
    print(finalUrl);
    var responseData;
    try {
      var response = await http
          .post(
            Uri.parse(finalUrl),
            headers: header,
            body: json.encode({'username': username, 'password': password}),
          )
          .timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        responseData = json.decode(response.body);
      } else {
        throw Exception('Unexpected error occured!');
      }
      _token = responseData['token'];
      notifyListeners();
      final storage = FlutterSecureStorage();
      final jwt = json.encode({
        'token': _token,
      });
      print(jwt);
      await storage.write(key: "token", value: jwt);
    } on TimeoutException catch (error) {
      throw error;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<String?> resetPassword(String email) async {
    print('reset pwd');
    Map<String, String> header = Headers().getPOSTHeaders;
    var finalUrl = Endpoints().resetPassword;
    String? responseData;
    try {
      var response = await http
          .post(
            Uri.parse(finalUrl),
            headers: header,
            body: json.encode({
              'email': email,
            }),
          )
          .timeout(const Duration(seconds: 3));
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw Exception(response.body);
      } else {
        print(response.body);
      }
    } catch (error) {
      throw error;
    }
    return responseData;
  }

  void logout() async {
    _token = null;
    _userId = null;
    notifyListeners();
    final storage = await FlutterSecureStorage();
    storage.deleteAll();
  }
}
