import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'homepage.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class signUp extends StatefulWidget {
  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  @override
  Widget build(BuildContext context) {
    bool signup;

    TextEditingController firstnameControl = new TextEditingController();
    TextEditingController lastnameControl = new TextEditingController();
    TextEditingController useridControl = new TextEditingController();
    TextEditingController passwordControl = new TextEditingController();


    Future<String> _getsignup(String tx1,String tx2,String tx3,String tx4) async
    {
      Dio dio = new Dio();
      FormData formdata = new FormData.from({
        "firstname":tx1,
        "lastname":tx2,
        "userid":tx3,
        "password":tx4
      });

      final response = await dio.post("http://onenetwork.ddns.net/api/register.php", data: formdata);

      String ans = response.toString();
      print(ans);

      var responseJson = jsonDecode(ans);

      var result = responseJson["error"];

      if (result == "false") {
        print(result);
        Fluttertoast.showToast(
            msg: "Registered",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.black87,
            fontSize: 16.0
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }

      return result.toString();
    }


    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0,color: Colors.black87);
    final first_name = TextField(
      controller: firstnameControl,
      style: style,
      decoration: InputDecoration(

          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "First Name",

          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final last_name = TextField(
      controller: lastnameControl,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Last Name",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final user_id = TextField(
      controller: useridControl,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "User Id",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final password_sign = TextField(
      controller: passwordControl,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0,),
        ),
      ),
    );


    final signupButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),

      color: Colors.blue.shade800,
      child: MaterialButton(
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
            print(firstnameControl.text);
            print(lastnameControl.text);
            print(useridControl.text);
            print(passwordControl.text);
          _getsignup(firstnameControl.text, lastnameControl.text, useridControl.text,
              passwordControl.text);
        },
        child: Text("Sign Up",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),

      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25.0),
                first_name,
                SizedBox(height: 25.0),
                last_name,
                SizedBox(height: 25.0),
                user_id,
                SizedBox(height: 25.0),
                password_sign,
                SizedBox(height: 25.0),
                signupButon
              ],
            ),
          ),
        ),
      ),

    );
  }
}