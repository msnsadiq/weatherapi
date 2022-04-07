import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:weatherapptwo/screenhome.dart';

import 'ModelApiii.dart';
import 'home.dart';
import 'home.dart';
ModelApiii? result;
main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "secondweather",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.grey
      ),
      home: ScreenHome(),
    );
  }
}
