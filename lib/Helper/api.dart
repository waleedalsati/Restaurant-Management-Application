import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth/login/Bloc/Exception.dart';
import '../Auth/login/Bloc/model-login.dart';

class api {

  Future<Map<String, String>> _getBaseHeaders({String? token}) async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString("lang") ?? "en";

    Map<String, String> headers = {
      "Accept": "application/json",
      "Accept-Language": lang,
    };

    if (token != null && token.isNotEmpty) {
      headers.addAll({"Authorization": "Bearer $token"});
    }

    return headers;
  }

  // GET
  Future<dynamic> get({required String url, String? token}) async {
    final headers = await _getBaseHeaders(token: token);
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }

  // POST
  Future<dynamic> post({
    required String url,
     @required dynamic body,
    String? token,
    Map<String, String>? extraHeaders,
  }) async {
    final headers = await _getBaseHeaders(token: token);
    if (extraHeaders != null) headers.addAll(extraHeaders);

    final response =
    await http.post(Uri.parse(url), body: body, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw serverexception(
        error: errormassage.fromJeson(response.body).toString(),
      );
    }
  }

  // PUT
  Future<dynamic> put({
    required String url,
    required dynamic body,
    String? token,
    Map<String, String>? extraHeaders,
  }) async {
    final headers = await _getBaseHeaders(token: token);
    headers.addAll({"Content-Type": "application/x-www-form-urlencoded"});
    if (extraHeaders != null) headers.addAll(extraHeaders);

    final response =
    await http.put(Uri.parse(url), body: body, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }
}
