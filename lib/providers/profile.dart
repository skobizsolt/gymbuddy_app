import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';
import 'dart:async';

import '../providers/auth.dart';
import '../globals/endpoints.dart';
import '../globals/headers.dart';

class Profile with ChangeNotifier {
  String? _token;
  int? _userId;

  final storage = const FlutterSecureStorage();

  Future<void> updateUser(String fullName) async {
    _userId = Auth().getUserId;
    _token = await storage.read(key: 'token');
    Map<String, String> header = Headers().getPOSTHeadersWithToken(_token!);
    final requestUrl = Endpoints().getOrUpdateUser(_userId!);
    print(requestUrl);
    print(_token);
    try {
      var response = await http.put(
        Uri.parse(requestUrl),
        headers: header,
        body: json.encode({'fullName': fullName}),
      );
      print('updated full name${response.body}');
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
