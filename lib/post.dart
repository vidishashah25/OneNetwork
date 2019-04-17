import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:login_page/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';




class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
SharedPreferences prefs;
var userid;
bool java = false;
bool php = false;
bool mysql = false;
bool ai = false;
bool ip = false;
List<String> interest_arr = new List();


void onChanged(bool value, String title) {
  setState(() {
    switch(title)
    {
      case "Java":
        java = value;
        break;
      case "PHP":
        php = value;
        break;
      case "MySQL":
        mysql = value;
        break;
      case "AI":
        ai = value;
        break;
      case "ImageProcessing":
        ip = value;
        break;
    }
  });
}

Widget checkbox(String title, bool boolValue)
{
  return Container(
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Text(title),
              Checkbox(
                value: boolValue,
                onChanged: (bool value) {onChanged(value, title);},
              )
            ],
          )
        ],
      ),
    ),
  );
}


@override
void initState(){
  //-> uncomment this when login starts working for @taher
    _getData1();
    super.initState();
}
  void _getData1() async{
    prefs = await SharedPreferences.getInstance();
    userid = prefs.getString("userid");
  }

Future<String> _postData(String name,String description,String val) async {
      Dio dio = new Dio();

      String url1 = "http://onenetwork.ddns.net/api/post_project.php?userid="+userid+"&title="+name+"&description="+description+"&project_type="+val;

      print(interest_arr.length);
      for(int i=0;i<interest_arr.length;i++)
        {
          //print("vidisha");
          url1=url1+"&arr[$i]="+interest_arr[i];
        }

      print(url1);

      print(name);
      print(description);
      print(userid);
      print(val);


       final response = await dio.get(url1.trim());
       String ans = response.toString();
       print(ans);
       var responseJson = jsonDecode(ans);
       var result = responseJson["error"];

       if (result == "false") {
         Fluttertoast.showToast(
             msg: "Post has been added",
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.CENTER,
             timeInSecForIos: 1,
             backgroundColor: Colors.grey,
             textColor: Colors.black87,
             fontSize: 16.0);
       }

      return result;
    }


 int _value2 = 0;
 void _setvalue2(int value) => setState(() => 
 _value2 = value
 );


final _formKey = GlobalKey<FormState>();
final _pd = ProjectData();
TextEditingController _title = new TextEditingController();
TextEditingController _description = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.done)
          ),
        ],
      ),
      body: SingleChildScrollView(
            child: Container(
            padding: 
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
              builder: (context) => Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
//Project Title
                    TextFormField(
                      decoration: 
                      InputDecoration(labelText: 'Project Title'),
                        autocorrect: true,
                        // autofocus: true,
                        controller: _title,
                        validator: (value){
                          if(value.isEmpty){
                            return 'Please enter your Project Title';
                          }
                        },
                        onSaved: (val) => setState(() => _pd.name = val),
                    ),
//Project Description
                    TextFormField(
                      decoration: 
                      InputDecoration(labelText: 'Project Description',),
                        autocorrect: true,
                        // autofocus: true,
                        controller: _description,
                        maxLines: 3,
                        validator: (value){
                          if(value.isEmpty){
                            return 'Please enter your Project Description';
                          }
                        },
                    ),
//Project Technology
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                      child: Text('Languages',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman'
                        ),
                      ),
                    ),

                    checkbox("Java", java),
                    checkbox("PHP", php),
                    checkbox("MySQL", mysql),

                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                      child: Text('Languages',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times New Roman'
                        ),
                      ),
                    ),

                    checkbox("AI", ai),
                    checkbox("ImageProcessing", ip),
//radio button

                    Container(
                      padding: new EdgeInsets.fromLTRB(3, 20, 20, 20),
                      child: Text('Project Type(Internship)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman',
                        color: Colors.blue,
                      ),
                      ),
                    ),
                    Container(
                      padding: new EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Center(
                           child: Column(
                                children: <Widget>[
                                  RadioListTile(
                                        value: 101,
                                        groupValue: _value2,
                                        onChanged: _setvalue2,
                                        activeColor: Colors.green,
                                        controlAffinity: ListTileControlAffinity.trailing,
                                        title: new Text('Winter'),
                                      ),
                                      RadioListTile(
                                        value: 102,
                                        groupValue: _value2,
                                        onChanged: _setvalue2,
                                        activeColor: Colors.green,
                                        controlAffinity: ListTileControlAffinity.trailing,
                                        title: new Text('Summer'),
                                      ),
                                ],
                              )
                      ),
                  ),
//Submit button                    
                    Container(
                     padding: const EdgeInsets.symmetric(
                       vertical: 16.0, horizontal: 16.0
                     ),
                     child: RaisedButton(
                       onPressed: (){
                         final form = _formKey.currentState;
                         if(form.validate()){
                           if(java==true)
                           {
                             print(java);
                             interest_arr.add("6");
                           }

                           if(php==true)
                           {
                             interest_arr.add("7");

                           }

                           if(mysql==true)
                           {
                             interest_arr.add("8");
                           }

                           if(ai==true)
                           {
                             interest_arr.add("9");
                           }
                           if(ip==true)
                           {
                             interest_arr.add("10");
                           }
                           print(interest_arr);
                           _postData(_title.text,_description.text,_value2.toString());
                           //form.save();
                         } 
                       },
                       padding: const EdgeInsets.all(8.0),
                       child: Text('Add Post',
                       style: TextStyle(
                         color:Colors.white,
                         fontSize: 20,
                       ),
                       ),
                       color:Colors.blue,
                     )
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

class ProjectType {
  final String name;
  final int id; 
  ProjectType(this.id, this.name);
}


class ProjectData {
  static const String Php = 'php';
  static const String Java = 'java';
  static const String Ai = 'ai';

  String name = '';
  String description = '';

  Map<String, bool> technology = {
    Php : false,
    Java : false,
    Ai : false,
  };

}