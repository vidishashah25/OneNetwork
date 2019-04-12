import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

class forgetPass extends StatefulWidget {
  @override
  _forgetPassState createState() => _forgetPassState();
}

class _forgetPassState extends State<forgetPass> {
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black87);
    TextEditingController useridController = new TextEditingController();

    Future<String> _changepass(String text) async {
      Dio dio = new Dio();

      FormData formData = new FormData.from({
        "userid": text,
      });
      final response = await dio
          .post("http://onenetwork.ddns.net/api/forgot.php", data: formData);
      String ans = response.toString();
      print(ans);
      var responseJson = jsonDecode(ans);
      var result = responseJson["error"];

      if (result == "false") {
        Fluttertoast.showToast(
            msg: "Email has been sent",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.black87,
            fontSize: 16.0);
      }
      return result;
    }

    final userid = TextField(
      controller: useridController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "User Id",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final resetButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _changepass(useridController.text);
        },
        child: Text("Reset Password",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Forgot Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      fontSize: 40.0,
                      color: Color(0xff01A0C7)),
                ),
                SizedBox(height: MediaQuery.of(context).size.width / 5),
                userid,
                SizedBox(height: MediaQuery.of(context).size.width / 15),
                resetButton,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
