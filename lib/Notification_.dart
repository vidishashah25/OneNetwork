import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:login_page/acknowlege.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:login_page/history_page.dart';

//All Notification

class Project{
  final String notification;
  final String id;
  final int flag;

  Project(this.notification, this.id, this.flag); 
}
// Notification-Class end....


class Notify extends StatefulWidget {
  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
new GlobalKey<RefreshIndicatorState>();

  SharedPreferences prefs;
  var userid;

  getdata() async {
    prefs = await SharedPreferences.getInstance();
    userid = prefs.getString("userid");
    //print(userid);
  }

  @override
  void initState() {
     WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    getdata();
    super.initState();
  }
  
  Project p;

  Future<List<Project>> _getProjects() async {
    String url ="http://onenetwork.ddns.net/api/view_notifications.php?userid="+userid;
    var data = await http.get(url);
    var JsonData = json.decode(data.body);
    List<Project> projects = [];
    // Project p;

    for(int i=0; i<JsonData.length; i++){
      p = new Project(
        JsonData[i]["notification"],
        JsonData[i]["project_id"],
        JsonData[i]["flag_value"]);
        projects.add(p);
    }
    

    print(projects.length);
    return projects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
        //  actions: <Widget>[
        //   new IconButton(
        //       icon: const Icon(Icons.refresh),
        //       tooltip: 'Refresh',
        //       onPressed: () {
        //         _refreshIndicatorKey.currentState.show();
        //       }),
        //     ],
      ),
      
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
          child: Container(
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
                    title: Text(snapshot.data[index].notification),
                    // subtitle: Text(snapshot.data[index].id),
                      onTap: (){
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Acknowledge(snapshot.data[index])));
                    },                    
                  );
                },
              );
             }             
            },
          ),
        ),
      ),
    );
  }

 Future<Null> _refresh() {
    return _getProjects().then((projects) {
      setState(() => projects = projects);
    });
  }

}

class User{  
  final int id;
  final String name;
  final String username;
  final String email;

  User(this.id, this.name, this.username, this.email);
}