import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';


class ViewProject extends StatefulWidget {
  final DataModel project;
  ViewProject(this.project);
  @override
  ViewProjectState createState() => ViewProjectState();
} 

class ViewProjectState extends State<ViewProject> {
  SharedPreferences prefs;
  var userid;

  getdata() async {
    prefs = await SharedPreferences.getInstance();
    userid = prefs.getString("userid");
    //print(userid);
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    print(userid);
    super.initState();
  }
  //=> fetch Data;
  List<AppliedUser> histories = [];

  Future<String> _sendData(String id, String pid) async {
  Dio d = new Dio();
  
  String url = "http://onenetwork.ddns.net/api/approve_student.php?userid="+id+"&projectid="+pid;

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
    if(histories.isEmpty){
    AppliedUser temp;
    String url = "http://onenetwork.ddns.net/api/view_project_details.php?projectid="+widget.project.id;
    var data = await http.get(url);
    var jsonData = json.decode(data.body);
        for(int i=0; i < jsonData["applied_user_names"].length;i++){
        temp = new AppliedUser(
          jsonData["applied_user_names"][i]["applied_user_name"],
          jsonData["applied_user_names"][i]["applied_student_id"],
          widget.project.id,jsonData["applied_users_count"]
          );
        histories.add(temp);
        print(jsonData["applied_user_names"][i]["applied_user_name"]);
        }
    print(histories.length);
    return histories;

    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        title: Text("More Details.."),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Text(
                widget.project.title,
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0),
                height: 200.0,
                child: Row(
                  children: <Widget>[
                    //Month
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                  Text("Description",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontFamily: "Montserrat"
                                      ),
                                    ),
                                    Text(widget.project.description,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: "Montserrat"
                                      ),                                    
                                    ),
                                  Text("Creator",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontFamily: "Montserrat"
                                      ),
                                    ),
                                    Text(widget.project.creator_name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: "Montserrat"
                                      ),                                    
                                    ),

                                    Text("Mentor",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontFamily: "Montserrat"
                                      ),
                                    ),
                                    Text(widget.project.mentor_name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: "Montserrat"
                                      ),                                    
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
    if(widget.project.creator == userid){
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
                                        Text(history.user,
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

class AppliedUser {

  final String user;
  final String id;
  final String pid;
  final int count;
  AppliedUser(this.user, this.id, this.pid, this.count);
}


