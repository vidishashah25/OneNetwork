import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/forgetPassword.dart';
import 'package:login_page/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'signup.dart';

class Login1 extends StatefulWidget {
  @override
  _Login1State createState() => _Login1State();
}

class _Login1State extends State<Login1> {
  SharedPreferences prefs;
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black87);
  bool _validate = false;
  TextEditingController useridControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<String> _signin(
      String userid,
      String pass,
      ) async {
    Dio dio = new Dio();
    FormData formdata = new FormData.from({"userid": userid, "password": pass});
    final response = await dio
        .post("http://onenetwork.ddns.net/api/login/login.php", data: formdata);
    String ans = response.toString();
    print(ans);
    var responseJson = jsonDecode(ans);
    var result = responseJson["error"];

    if (result == "false") {
      prefs = await SharedPreferences.getInstance();
      //print(emailController.text);
      prefs.setString("userid", useridControl.text);
      prefs.commit();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    return result.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Builder(
            builder: (context) => Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage("images/logo.jpeg"),
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                    child: TextFormField(
                      controller: useridControl,
                      autocorrect: true,
                      decoration: InputDecoration(
                          hintText: 'First Name',
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your UserID';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: TextFormField(
                      controller: passwordControl,
                      autocorrect: true,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Last Name',
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter password';
                        }
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width/50),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xff01A0C7),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          _signin(useridControl.text, passwordControl.text);
                        }
                      },
                      child: Text("Login",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.width/50),
                  FlatButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>ForgetPass()));
                    },
                    child: Text("Forgot Password ?"),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width/15),
                  FlatButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>SignUp()));
                    },
                    child: Text("Don't Have an account?  SignUp"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}