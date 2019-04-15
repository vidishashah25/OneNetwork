import 'package:flutter/material.dart';
import 'package:login_page/subNotification.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


//All Notification

class Project{
  final String title;
  final String body;

  Project(this.title, this.body); 
}
// Notification-Class end....


class Notify extends StatefulWidget {
  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {

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
    // print(userid);
    super.initState();
  }

  Future<List<Project>> _getProjects() async {
    var data = await http.get('http://onenetwork.ddns.net/api/view_notifications.php?userid=201812017');
    var JsonData = json.decode(data.body);

    List<Project> projects = [];

    for(var u in JsonData){
      Project project = Project(u["title"],u["body"]);
      projects.add(project);
    }

    print(projects.length);
    return projects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Container(
        child:FutureBuilder(
          future: _getProjects(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.data ==  null){
              return Container(
                child: Center(
                  child: Text("Loading...")
                )
              );
            }
            else{
              return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(""),
                  ),
                  title: Text(snapshot.data[index].title),
                  subtitle: Text(snapshot.data[index].body),
                  onTap: (){
                    Navigator.push(context,
                      new MaterialPageRoute(builder:(context) => DetailPage(snapshot.data[index]))
                    );
                  },
                );
              },
            );
           }             
          },
        ),
      ),
    );
  }
}

class User{
  
  final int id;
  final String name;
  final String username;
  final String email;

  User(this.id, this.name, this.username, this.email);
}

class DetailPage extends StatelessWidget {
  
  final Project project;
  DetailPage(this.project);

  Future<List<User>> _getUserData() async {
    var data = await http.get('https://jsonplaceholder.typicode.com/users');
    var JsonData = json.decode(data.body);

    List<User> users = [];

    for(var u in JsonData){
      User user = User(u["id"], u["name"], u["username"], u["email"]);
      users.add(user);
    }

    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
      ),
      body: Container(
        child: FutureBuilder(
              future: _getUserData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.data ==  null){
                    return Container(
                      child: Center(
                        child: Text("Loading...")
                      )
                    );
                  }
                  else{
                       return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index){
                          return Card(
                            child:Row(
                              children: <Widget>[
                                 Container(
                                   margin: EdgeInsets.all(15),
                                   child: CircleAvatar(
                                      backgroundImage: NetworkImage(""),
                                      radius: 30,
                                    ),
                                 ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Column(
                                    children: <Widget>[
                                        Text(snapshot.data[index].name,
                                            style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: 'Times New Roman',
                                          ),
                                        ),
                                        Text(snapshot.data[index].username),
                                      ButtonTheme.bar(
                                        child: ButtonBar(
                                          children: <Widget>[
                                            FlatButton(
                                              child: const Text('Accept'),
                                              onPressed: (){},
                                            ),
                                            FlatButton(
                                              child: const Text('Reject',
                                              style: TextStyle(color: Colors.red)),
                                              onPressed: (){},
                                            )
                                          ],
                                        )
                                      )
                                    ]
                                ),
                                  )
                              ],
                            )
                          );
                      },
                    );
                  }             
              },
            ),
      ),
    );
  }
}


// return ListView.builder(
//                   itemCount: snapshot.data.length,
//                   itemBuilder: (BuildContext context, int index){
//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(""),
//                       ),
//                       title: Text(snapshot.data[index].name),
//                       subtitle: Text(snapshot.data[index].email),
                      
//                       onTap: (){
//                       //   Navigator.push(context, 
//                       //    // new MaterialPageRoute(builder:(context) => DetailPage(snapshot.data[index]))
//                       //     new MaterialPageRoute(builder:(context)=> SubNotify(snapshot.data[index]))
//                       // );
//                       },
//                     );
//                   },
//                 );

//F-up code

// body: Column(
//         children: <Widget>[
//           FutureBuilder(
//               future: _getUserData(),
//               builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   if(snapshot.data ==  null){
//                     return Container(
//                       child: Center(
//                         child: Text("Loading...")
//                       )
//                     );
//                   }
//                   else{
//                        return ListView.builder(
//                         itemCount: snapshot.data.length,
//                         itemBuilder: (BuildContext context, int index){
//                           return Card(
//                             child:Row(
//                               children: <Widget>[
//                                  Container(
//                                    margin: EdgeInsets.all(15),
//                                    child: CircleAvatar(
//                                       backgroundImage: NetworkImage(""),
//                                       radius: 30,
//                                     ),
//                                  ),
//                                   Container(
//                                     margin: EdgeInsets.only(left: 20),
//                                     child: Column(
//                                     children: <Widget>[
//                                         Text(snapshot.data[index].name,
//                                             style: TextStyle(
//                                             // fontWeight: FontWeight.bold,
//                                             fontSize: 20,
//                                             fontFamily: 'Times New Roman',
//                                           ),
//                                         ),
//                                         Text(snapshot.data[index].username),
//                                       ButtonTheme.bar(
//                                         child: ButtonBar(
//                                           children: <Widget>[
//                                             FlatButton(
//                                               child: const Text('Accept'),
//                                               onPressed: (){},
//                                             ),
//                                             FlatButton(
//                                               child: const Text('Reject',
//                                               style: TextStyle(color: Colors.red)),
//                                               onPressed: (){},
//                                             )
//                                           ],
//                                         )
//                                       )
//                                     ]
//                                 ),
//                                   )
//                               ],
//                             )
//                           );
//                       },
//                     );
//                   }             
//               },
//             ),
          
//         ],
//       )