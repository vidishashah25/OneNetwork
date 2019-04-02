import 'package:flutter/material.dart';
import 'homepage.dart';

class signUp extends StatefulWidget {
  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  @override
  Widget build(BuildContext context) {

    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    final first_name = TextField(
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "First Name",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final last_name = TextField(
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Last Name",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final user_id = TextField(
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "User Id",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final password_sign = TextField(
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
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder:(context)=>HomePage()));
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
