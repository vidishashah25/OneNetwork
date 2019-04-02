import 'package:flutter/material.dart';
import 'homepage.dart';
import 'signup.dart';

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

class _LoginPageState extends State<LoginPage>
{
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color : Colors.black87);
    final emailField = TextField(
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
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

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),

      color: Colors.blue.shade800,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder:(context)=>HomePage()));
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return Stack(

      children: <Widget>[

    Scaffold(
    body: Center(
    child: Container(
    color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height:90.0,
              child: Image.asset(
                "images/logo.jpeg",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 25.0),
            emailField,
            SizedBox(height: 25.0),
            passwordField,
            SizedBox(
              height: 25.0,
            ),
            loginButon,
            SizedBox(
              height:10.0,
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0,left:190.0 ),
              height: 30.0,
              width: 300.0,
              child: GestureDetector(
                child: Container(
//                      height: 20.0,
//                      width: 10.0,
                  child: Text('Forgot Password?',style: TextStyle(color: Colors.blue.shade900,
                    fontSize: 15.0,

                  ),
                  ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>HomePage()));
                },
              ),
            ),

            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top:70.0,left:30.0),
                  child: Text("Don't have an Accout?",style: TextStyle(
                      fontSize: 20.0,
                    color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 25.0,),
                Container(
                  margin: EdgeInsets.only(top: 80.0),
                  height: 30.0,
                  width: 70.0,
                  child: GestureDetector(
                    child: Container(
                      child: Text('SignUp',style: TextStyle(color: Colors.blue.shade900,
                        fontSize: 20.0,

                      ),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>signUp()));
                    },
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    ),
    ),
    ),
      ],

    );
  }
}



