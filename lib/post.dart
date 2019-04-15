// import 'package:fluttertoast/fluttertoast.dart';
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

@override
void initState(){
  //-> uncomment this when login starts working for @taher
    _getData1();
    _getdata();

    super.initState();
}
  void _getData1() async{
    prefs = await SharedPreferences.getInstance();
    userid = prefs.getString("userid");
  }

Future<String> _postData(String name,String description,String val) async {
      Dio dio = new Dio();
      print(name);
      print(description);
      print(userid);
      print(val);

      // FormData formData = new FormData.from({
      //   "title": name,
      //   "description": description,
      //   "userid": userid,
      //   "project_type": 102
      // });
      // final response = await dio
      //     .post("http://onenetwork.ddns.net/api/post_project.php", data: formData);
      // String ans = response.toString();
      // print(ans);
      // var responseJson = jsonDecode(ans);
      // var result = responseJson["error"];

      // if (result == "false") {
      //   Fluttertoast.showToast(
      //       msg: "Post has been added",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.CENTER,
      //       timeInSecForIos: 1,
      //       backgroundColor: Colors.grey,
      //       textColor: Colors.black87,
      //       fontSize: 16.0);
      // }
      var result ="nothing";
      return result;
    }

    List<String> l =new List(3);
    List<String> lname =new List(3);
    Map<int,String> mp = new Map<int,String>();
    void _getdata() async{
        Dio dio = new Dio();
        final response = await dio.get("http://onenetwork.ddns.net/api/interests.php");
        String ans = response.toString();
        var data = jsonDecode(ans);

//print(data["interests"][0]["interests_array"][0]["name"]);
//instead of 3 put count, Don't worry Pratik will send in api.
        
        for(int i=0;i<3;i++){
          l[i]=data["interests"][0]["interests_array"][i]["id"];
          lname[i]=data["interests"][0]["interests_array"][i]["name"];
        }
          print(l);
          print(lname);
    }


  List<ProjectType> _getProjectTypes() {
    List<ProjectType> ptype = [];
    ProjectType temp;
    Dio dio = new Dio();
      var data =
       dio.get('http://onenetwork.ddns.net/api/get_project_types.php');
      var jsonData = json.decode(data.toString());
      print(jsonData);
      
      for(var u in jsonData){
        ProjectType p = ProjectType(u["id"], u["name"]);
        ptype.add(p);
      }
    print(ptype);
    return ptype;    
  }



 int _value2 = 0;
 void _setvalue2(int value) => setState(() => 
 _value2 = value
 );

Widget makeRadioTiles() {  
  List<Widget> list = new List<Widget>();
  // List<ProjectType> ptype = _getProjectTypes();
  // print(ptype);
    int val=101;
      for(int i = 0; i < 2; i++){
        list.add(new RadioListTile(
          value: val++,
          groupValue: _value2,
          onChanged: _setvalue2,
          activeColor: Colors.green,
          controlAffinity: ListTileControlAffinity.trailing,
          title: new Text('Summer'),
        ));
   }

   Column column = new Column(children: list,);
   return column;
 }

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
                      child: Text('Technology',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman'
                        ),
                      ),
                    ),
                    CheckboxListTile(
                      title: const Text('PHP'),
                      value: _pd.technology[ProjectData.Php],
                      onChanged: (val){
                        setState(() {
                        _pd.technology[ProjectData.Php] = val;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Java'),
                      value: _pd.technology[ProjectData.Java],
                      onChanged: (val){
                        setState(() {
                        _pd.technology[ProjectData.Java] = val;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('AI'),
                      value: _pd.technology[ProjectData.Ai],
                      onChanged: (val){
                        setState(() {
                        _pd.technology[ProjectData.Ai] = val;
                        });
                      },
                    ),
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