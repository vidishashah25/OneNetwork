import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_page/Notification_.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Acknowledge extends StatefulWidget {
  final Project project;
  Acknowledge(this.project);
  @override
  _AcknowledgeState createState() => _AcknowledgeState();
}

class _AcknowledgeState extends State<Acknowledge> {

  SharedPreferences prefs;
  var userid;

  getdata() async {
    prefs = await SharedPreferences.getInstance();
    userid = prefs.getString("userid");
  }

  @override
  void initState() {

    getdata();
    super.initState();
  }
// List<ProjectDetails> histories = [];
List<AppliedUser> histories = [];

Future<String> _sendData(String id, String pid) async {
  Dio d = new Dio();
  
  String url = "http://onenetwork.ddns.net/api/view_project_details?userid="+id+"&projectid="+pid;

  final response = d.post(url);
  String ans = response.toString();
      print(ans);

      var responseJson = jsonDecode(ans);

      var result = responseJson["error"];

      if (result == "false") {
        print(result);
        Fluttertoast.showToast(
            msg: "Accept msg sent",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.black87,
            fontSize: 16.0
        );
      }

      return result.toString();
}
  

Future<String> _sendRejectData(String id, String pid) async {
  Dio d = new Dio();
  
  String url = "http://onenetwork.ddns.net/api/reject_student.php?userid="+id+"&projectid="+pid;

  final response = d.post(url);
  String ans = response.toString();
      print(ans);

      var responseJson = jsonDecode(ans);

      var result = responseJson["error"];

      if (result == "false") {
        print(result);
        Fluttertoast.showToast(
            msg: "Reject msg sent",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.black87,
            fontSize: 16.0
        );
      }

      return result.toString();
}
 
Future<List<AppliedUser>> _getData() async {
    AppliedUser temp;
    String url = "http://onenetwork.ddns.net/api/view_applied_users_for_project.php?projectid="+widget.project.id;
              
    if(histories.isEmpty){
      var data =
      await http.get(url);
      var jsonData = json.decode(data.body);
      var i = jsonData["applied_users"].length;
      print(i);          
    
      for (int i = 0; i < jsonData["applied_users"].length; i++) {
        temp = new AppliedUser(
          jsonData["applied_users"][i]["name"],
          jsonData["applied_users"][i]["id"],
          widget.project.id
          );
          print(temp.id);
          print(userid);
        print('reached');
        histories.add(temp);
        print(temp);
      }
    }
    return histories;
  }

List<ProjectDetails> pdata = [];
Future<List<ProjectDetails>> _getProjectDetails() async {
  ProjectDetails pd;
  String url = "http://onenetwork.ddns.net/api/fetch_specific_project.php?projectid="+widget.project.id;
  if(pdata.isEmpty){
    var data = await http.get(url);
    var jsonData = json.decode(data.body);

    pd = new ProjectDetails(jsonData["project_detail"]["id"], jsonData["project_detail"]["title"], jsonData["project_detail"]["description"], jsonData["project_detail"]["creator_id"], jsonData["project_detail"]["mentor_id"]);
// print(pd);
    pdata.add(pd);
  }
return pdata;
}


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      // backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        title: Text("More Details.."),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[           
            Expanded(
              child: FutureBuilder(
                future: _getProjectDetails(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.data == null){
                    return Container(
                      child: Center(
                        child: Text("No Data..."),
                      ),
                    );
                  }
                  else{                  
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                          return Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              child: Card(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Title",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20
                                      ),
                                    ),
                                    Text(snapshot.data[index].title,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18
                                      ),
                                    ),
                                    Text("Description",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20
                                      ),
                                    ),
                                    Text(snapshot.data[index].description,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18
                                      ),
                                    ),
                                    Text("Creator",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20
                                      ),
                                    ),
                                    // Text(snapshot.data[index].creator_name),
                                    Text("Mentor",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20
                                      ),
                                    ),
                                    // Text(snapshot.data[index].mentor_name),
                                  ],
                                ),
                              )
                            ),
                          );
                      },
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.data == null){
                    return Container(
                      child: Center(
                        child: Text("No Data..."),
                      ),
                    );
                  }
                  else{
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                          return _historyWidget(snapshot.data[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _historyWidget(AppliedUser history) {
    if(history.id == userid){
      return Container(
      margin: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                            child:Row(
                              children: <Widget>[
                                 Container(
                                   margin: EdgeInsets.all(15),
                                   child: CircleAvatar(
                                      backgroundImage: NetworkImage(""),
                                      radius: 25,
                                    ),
                                 ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Column(
                                    children: <Widget>[
                                        Text(history.user,
                                            style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ButtonTheme.bar(
                                        child: ButtonBar(
                                          children: <Widget>[
                                            FlatButton(
                                              child: const Text('Accept'),
                                              onPressed: (){
                                                _sendData(history.id,history.pid);
                                              },
                                            ),
                                            FlatButton(
                                              child: const Text('Reject',
                                              style: TextStyle(color: Colors.red)),
                                              onPressed: (){
                                                _sendRejectData(history.id,history.pid);
                                              },
                                            )
                                          ],
                                        )
                                      )
                                    ]
                                ),
                                  )
                              ],
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  else{
    return Container(
      margin: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                            child:Row(
                              children: <Widget>[
                                 Container(
                                   margin: EdgeInsets.all(15),
                                   child: CircleAvatar(
                                      backgroundImage: NetworkImage(""),
                                      radius: 25,
                                    ),
                                 ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Column(
                                    children: <Widget>[
                                        Text(history.user,   //check again
                                            style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                    ]
                                ),
                                  )
                              ],
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  }
}

class ProjectDetails {
  final String id;
  final String title;
  final String description;
  final String creator_id;
  final String mentor_id;
  // final String creator_name;
  // final String mentor_name;

// ProjectDetails(this.id, this.title, this.description, this.creator_id, this.mentor_id, this.creator_name, this.mentor_name);
ProjectDetails(this.id, this.title, this.description, this.creator_id, this.mentor_id,);
}

class AppliedUser {

  final String user;
  final String id;
  final String pid;
  // final int count;
  AppliedUser(this.user, this.id, this.pid);
}
