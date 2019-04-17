import 'package:flutter/material.dart';
import 'package:login_page/main.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {    
    bool _validate = false;

    TextEditingController firstnameControl = new TextEditingController();
    TextEditingController lastnameControl = new TextEditingController();
    TextEditingController useridControl = new TextEditingController();
    TextEditingController passwordControl = new TextEditingController();
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0,color: Colors.black87);

    final _formKey = GlobalKey<FormState>();

    Future<String>_signin(String fname,String lname,String userid,String pass,) async{
      Dio dio = new Dio();
      FormData formdata = new FormData.from({
        "firstname":fname,
        "lastname":lname,
        "userid":userid,
        "password":pass
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
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }

      return result.toString();

    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create an account"),
      ),
      body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Builder(
              builder: (context) => Form(
                key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: AssetImage("images/logo.jpeg"),
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.height/4,
                        width:  MediaQuery.of(context).size.width/2,
                    ),
                    Text('SignUp',
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Times new Roman',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
//Firstname                    
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                          child: TextFormField(
                          controller: firstnameControl,
                          autocorrect: true,
                          style: style,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                          ),
                          
                          validator: (value){
                              if(value.isEmpty){
                                return 'Please enter your First name';
                              }
                            },
                        ),
                      ),
//Lastname
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                          child: TextFormField(
                          controller: lastnameControl,
                          autocorrect: true,
                          style: style,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                          ),
                          validator: (value){
                              if(value.isEmpty){
                                return 'Please enter your Last name';
                              }
                            },
                        ),
                      ),
//User ID                   
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                          child: TextFormField(
                          controller: useridControl,
                          autocorrect: true,
                          style: style,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                          ),
                          validator: (value){
                              if(value.isEmpty){
                                return 'Please enter your User Id';
                              }
                         },
                        ),
                      ),
//Password                    
                      Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                          child: TextFormField(
                          controller: passwordControl,
                          autocorrect: true,
                          style: style,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                          ),
                          validator: (value){
                              if(value.isEmpty){
                                return 'Please enter your Password';
                              }
                          },

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
                        child: Container(
                         padding: const EdgeInsets.symmetric(
                           vertical: 16.0, horizontal: 16.0
                         ),
                         child: RaisedButton(
                           onPressed: (){
                             final form = _formKey.currentState;
                             if(form.validate()){
                              _signin(firstnameControl.text,lastnameControl.text,useridControl.text,passwordControl.text); 
                             }
                           },
                           padding: const EdgeInsets.all(8.0),
                           child: Text('Sign UP',
                           style: TextStyle(
                             color:Colors.white,
                             fontSize: 20,
                           ),
                           ),
                           color:Colors.blue,
                         )
                        ),
                      ),
                      FlatButton(
                        child: Text('Already have an account,Login',
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'Times new Roman',
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>LoginPage()));
                        },
                      )
                    ],
                  ),
              )
            )
        ),
      ),
    );
  }
}