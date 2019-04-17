import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:login_page/main.dart';

class ForgetPass extends StatefulWidget {
  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {

  TextEditingController userid = new TextEditingController();
  TextStyle style = TextStyle(fontFamily: 'Times New Roman', fontSize: 20.0,color: Colors.blue);
  final _formKey = GlobalKey<FormState>();

Future<String>_getPass(String userid) async{
      Dio dio = new Dio();
      FormData formdata = new FormData.from({
        "userid":userid,
      });

      final response = await 
      dio.post("http://onenetwork.ddns.net/api/forgot.php", data: formdata);

      String ans = response.toString();
      print(ans);

      var responseJson = jsonDecode(ans);

      var result = responseJson["error"];

      if (result == "false") {
        print(result);
        Fluttertoast.showToast(
            msg: "Mail has been sent",
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
        title: Text("Forget Password"),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Builder(
              builder: (context) => Form(
                key: _formKey,
                  child: Column(
                    children: <Widget>[
                      
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                          child: TextFormField(
                          controller: userid,
                          autocorrect: true,
                          style: style,
                          decoration: InputDecoration(
                            hintText: 'User Id',
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                          ),
                          
                          validator: (value){
                              if(value.isEmpty){
                                return 'Please enter your Id';
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
                           color: Color(0xff01A0C7),
                           onPressed: (){
                             final form = _formKey.currentState;
                             if(form.validate()){
                              _getPass(userid.text);
                             }
                           },
                           padding: const EdgeInsets.all(8.0),
                           child: Text('Enter',
                           style: TextStyle(
                             color:Colors.white,
                             fontSize: 20,
                           ),
                           ),
                         )
                        ),
                      ),
                    ],
                  )
            )
          )
        )
                  
      ),
    );
  }
}