import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/model/theme_config.dart';
import 'package:flutter_easy_ride/service/api_helper.dart';
import 'package:flutter_easy_ride/service/network_utility.dart';
import 'package:http/http.dart' as http;

import '../utils/local_storage.dart';

class ApiProvider with ChangeNotifier {
  bool loading = false;
  ThemeConfig? themeConfig;
  ThemeConfig? get themeConfigg => themeConfig;

  Future<void> fetchAuth() async {
    loading = true;
    final String url = ApiHelper.authApi;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        loading = false;
        var jsondata = jsonDecode(response.body);
        List<dynamic> apiAuth = jsondata["api_auth"];
        var username = apiAuth[0]["username"];
        var password = apiAuth[0]["password"];
        await LocalStorage.saveUsername(username);
        await LocalStorage.savePassword(password);
      } else {
        loading = false;
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      loading = false;
    }
  }

  Future<void> fetchTheme() async {
    loading = true;

    final String url = ApiHelper.getTheme;

    try {
      final response = await NetworkUtility.sendGetRequest(url);

      if (response.statusCode == 200) {
        loading = false;

        //  var data=jsonDecode(response.body);
        final Map<String, dynamic> data = json.decode(response.body);

        themeConfig = ThemeConfig.fromJson(data);
        notifyListeners();
      } else {
        loading = false;

        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      loading = false;

      print('Error sending POST request: $e');
    }
  }
}
