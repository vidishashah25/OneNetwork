import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login_page/userprofile.dart';
import 'package:http/http.dart' as http;
import 'homepage.dart';
import 'signup.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgetPassword.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(

      debugShowCheckedModeBanner: false,
        home: new LoginPage(),
        theme: new ThemeData(primarySwatch: Colors.blue));
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {

    bool login=false;
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();


    Future<String> _getSignin(String text, String text2) async {
      Dio dio= new Dio();
      FormData formData =new FormData.from(
          {
            "userid" : text,
            "password" : text2,
          }
      );
       final response = await dio.post("http://onenetwork.ddns.net/api/login/login.php", data: formData);
       String ans = response.toString();
       print(ans);
       var responseJson = jsonDecode(ans);
       var result= responseJson["error"];
       print(result);

      login=true;
        if(result=="false"){
          prefs = await SharedPreferences.getInstance();
          //print(emailController.text);
          prefs.setString("userid", emailController.text);
          prefs.commit();
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>HomePage()));
        }
      return result;
    }



    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0,color: Colors.black87);


    final imageField= Image(
        image: AssetImage("images/logo.jpeg"),
        fit: BoxFit.contain,
        height: MediaQuery.of(context).size.height/4,
        width:  MediaQuery.of(context).size.width/2,
    );

    final emailField = TextField(
      controller: emailController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),

    );

    final passwordField = TextField(
      controller: passwordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
//          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>HomePage()));
         _getSignin(emailController.text,passwordController.text);
        // if(login){
//          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>HomePage()));
        // }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );


  

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color:Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  imageField,
                  emailField,
                  SizedBox(height: MediaQuery.of(context).size.width/15),
                  passwordField,
                  SizedBox(height: MediaQuery.of(context).size.width/15),
                  loginButon,
                  SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width/50),
                  FlatButton(
                    onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>forgetPass()));
                    },
                    child: Text("Forgot Password ?"),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width/15),
                  FlatButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>signUp()));
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
