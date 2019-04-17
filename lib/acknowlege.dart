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
    print(widget.project.id);
  }

  @override
  void initState() {
    _getData();
    print(widget.project.id);
    print(userid);
    super.initState();
  }
// List<ProjectDetails> histories = [];
List<AppliedUser> histories = [];

Future<String> _sendData(String id, String pid) async {
  Dio d = new Dio();
  
  String url = "http://onenetwork.ddns.net/api/view_project_details?projectid="+id+"&projectid="+pid;

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
 
// Future<List<ProjectDetails>> _getData() async {
    
//     if(histories.isEmpty){
//     ProjectDetails temp;
//     print("hey");
//     String url = "http://onenetwork.ddns.net/api/view_project_details.php?projectid="+widget.project_id;
//     var data = await http.get(url);
//     var jsonData = json.decode(data.body);
// print("hey");
//     print(jsonData["applied_user_count"]);
//         for(int i=0; i < jsonData["applied_user_count"];i++){
//         temp = new ProjectDetails(
//           jsonData["project_details"]["id"],
//           jsonData["project_details"]["title"],
//           jsonData["project_details"]["description"],
//           jsonData["project_details"]["creator"],
//           jsonData["project_details"]["mentor"],
//           jsonData["creator_name"],
//           jsonData["mentor_name"],
//           jsonData["applied_user_names"][i]["applied_student_id"],
//           jsonData["applied_user_names"][i]["applied_user_name"],
//           );
//         histories.add(temp);
//         // print(jsonData["applied_user_names"][i]["applied_user_name"]);
//         }
//     // print(histories.length);
//     return histories;

//     }
//   }
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
        print('reached');
        histories.add(temp);
        print(temp);
      }
    }
    return histories;
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
          children: <Widget>[
//remember to uncomment again            
            // Padding(
            //   padding:
            //   const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),

              // child: Text(
              //   widget.project.title,
              //   style: TextStyle(
              //     color: Colors.blue,
              //     fontFamily: 'Montserrat',
              //     fontWeight: FontWeight.w700,
              //     fontSize: 20.0
              //   ),
              // ),
            //),
//             Expanded(
//               child: FutureBuilder(
//                 future: _getData(),
//                 builder: (BuildContext context, AsyncSnapshot snapshot){
//                   if(snapshot.data == null){
//                     return Container(
//                       child: Center(
//                         child: Text("No Data..."),
//                       ),
//                     );
//                   }
//                   else{
// //remember to uncomment again                     
//                   //   return ListView.builder(
//                   //     shrinkWrap: true,
//                   //     itemCount: snapshot.data.length,
//                   //     itemBuilder: (BuildContext context, int index){
//                   //         return Container(
//                   //           child: Column(
//                   //             children: <Widget>[
//                   //               Text(snapshot.data[index].title),
//                   //               Text(snapshot.data[index].description),
//                   //               Text(snapshot.data[index].creator_name),
//                   //               Text(snapshot.data[index].mentor_name),
//                   //             ],
//                   //           )
//                   //         );
//                   //     },
//                   //   );
//                   // }
//                   }
//                 },
//               ),
//             ),
            
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
  final String creator_name;
  final String mentor_name;
  final String userid;
  final String username;

ProjectDetails(this.id, this.title, this.description, this.creator_id, this.mentor_id, this.creator_name, this.mentor_name, this.userid, this.username);
}

class AppliedUser {

  final String user;
  final String id;
  final String pid;
  // final int count;
  AppliedUser(this.user, this.id, this.pid);
}

// class OProject{
//   final String notification;
//   final String id;
//   final int flag;

//   OProject(this.notification, this.id, this.flag); 
// }