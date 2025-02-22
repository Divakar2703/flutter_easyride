import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custombutton.dart';
import 'newdialogbox.dart';

class Checkdialob extends StatefulWidget {
  const Checkdialob({super.key});

  @override
  State<Checkdialob> createState() => _CheckdialobState();
}

class _CheckdialobState extends State<Checkdialob> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Check dialob"),
      ),
      body: Column(
        children: [
          Customtbutton(
            text: "succes",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SweetDialog()));
            },
          ),

          SizedBox(height: 10,),

          Customtbutton(
            text: "alert",

            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AlertDialobbox()));
            },
          )




        ],
      ),
    );
  }
}
