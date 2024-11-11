import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CheckApi extends StatefulWidget {
  const CheckApi({super.key});

  @override
  State<CheckApi> createState() => _CheckApiState();
}

class _CheckApiState extends State<CheckApi> {


  var data1;
  Future<void> featchdatafromapi() async {
    try {
      // final response = await http
      //     .get(Uri.parse("https://asatvindia.in/cab/Api/User/trip_history"));
       final response = await http
          .get(Uri.parse("https://asatvindia.in/cab/Api/User/get_theme"));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        setState(() {
          data1 = data;
        });
      } else {
        throw ('Failed data please');
      }
    } catch (e) {
      throw ('data is not found : $e');
    }
  }




  @override
  void initState() {
    featchdatafromapi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
