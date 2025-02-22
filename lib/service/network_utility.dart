import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/local_storage.dart';



class NetworkUtility {

  static Future<String?> fetchGetUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        // Successful response, return the body
        return response.body;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error making request: $e');
    }
    // Return null for any error or failure
    return null;
  }
  static  Future<http.Response> sendPostRequest(
      String baseUrl,
      Map<String, dynamic> params,
      ) async {
    var url = Uri.parse(baseUrl);
    print("url---$url");
    final String username = await LocalStorage.getUsername();
    final String password = await LocalStorage.getPassword();
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

   var headers={
      'Content-Type': 'application/json',
    'Authorization': basicAuth,
  };
   print("headers===${headers}");
    try {
      var response = await http.post(
        url,
        body: jsonEncode(params),
        headers: headers,
      );
      print("res===${response.body}");
      return response;
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    }
  }
  static  Future<http.Response> sendPutRawRequest(
      String baseUrl,
      String params,
      Map<String, String> headers,
      ) async {
    var url = Uri.parse(baseUrl);
    try {
      var response = await http.put(
        url,
        body: params,
        headers: headers,
      );
      return response;
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    }
  }
  static  Future<http.Response> sendPutRequest(
      String baseUrl,
      Map<String, dynamic> params,
      Map<String, String> headers,
      ) async {
    var url = Uri.parse(baseUrl);
    try {
      var response = await http.put(
        url,
        body: params,
        headers: headers,
      );
      return response;
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    }
  }

  static  Future<http.Response> sendGetRequest(
      String baseUrl,
      ) async {
    var url = Uri.parse(baseUrl);
    print("url===${url}");
    final String username = await LocalStorage.getUsername();
    final String password = await LocalStorage.getPassword();
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    var headers={
      'Content-Type': 'application/json',
      'Authorization': basicAuth,
    };
    try {
      var response = await http.get(
        url,
        headers: headers,
      );
      return response;
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    }
  }
}




