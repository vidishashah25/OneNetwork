// TODO Implement this library.
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:login_page/Models/intrest.dart';
class Post{
  Intrests i;
  Future<String> getHttp() async {
      Dio dio= new Dio();
      final response = await dio.get("http://onenetwork.ddns.net/api/interests.php");
      String ans = response.toString();
      var responseJson = jsonDecode(ans);
      i= Intrests.fromJson(responseJson);
      print(i);
      return i.toString();
  }
}
