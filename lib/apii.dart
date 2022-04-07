import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:weatherapptwo/ModelApiii.dart';

import 'ModelApiii.dart';
Future getApii({required String datas})async{
  // SharedPreferences prefrence = await SharedPreferences.getInstance();
  // prefrence.setString(, value)
  final _collection =  await http.get(Uri.parse('https://weatherapi-com.p.rapidapi.com/current.json?q=' +datas),
      headers: {
        'x-rapidapi-host': 'weatherapi-com.p.rapidapi.com',
        'x-rapidapi-key': '0cea17d0e5msh048048e2a8ede8bp1d0f59jsn74a8b4b56d8e'
      }
  );
  if(_collection.statusCode == 200){
    final _itemss = json.decode(_collection.body)as Map<String, dynamic>;
    final _valuee = ModelApiii.fromJson(_itemss);
    return _valuee;
  }else{
    print("something went wrong");
    return "something went wrong";
  }

}