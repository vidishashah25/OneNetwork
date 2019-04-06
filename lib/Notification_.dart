import 'package:flutter/material.dart';
import 'package:login_page/subNotification.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Notify extends StatefulWidget {
  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {

  Future<List<User>> _getUsers() async {
    var data = await http.get('https://jsonplaceholder.typicode.com/users');
    var JsonData = json.decode(data.body);

    List<User> users = [];

    for(var u in JsonData){
      User user = User(u["id"], u["name"],u["username"],u["email"]);
      users.add(user);
    }

    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Container(
        child:FutureBuilder(
          future: _getUsers(),
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
                  title: Text(snapshot.data[index].name),
                  subtitle: Text(snapshot.data[index].email),
                  onTap: (){
                    Navigator.push(context, 
                      //new MaterialPageRoute(builder:(context) => DetailPage(snapshot.data[index]))
                      new MaterialPageRoute(builder:(context) => SubNotify())
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

//All Notification
class User{
  
  final int id;
  final String name;
  final String username;
  final String email;

  User(this.id, this.name, this.username, this.email);
}
// Selected User Data
class SingleUser{
  
final String title;
final String body;
SingleUser(this.title, this.body);

  // final String projectName;
  // final String projectDetails;
  // final String student;

  // SingleUser(this.projectName, this.projectDetails, this.student);
}

class DetailPage extends StatelessWidget {
  final User user;
  DetailPage(this.user);

  Future<List<SingleUser>> _getUserData() async {
    var data = await http.get('https://jsonplaceholder.typicode.com/posts');
    var JsonData = json.decode(data.body);

    List<SingleUser> users = [];

    for(var u in JsonData){
      SingleUser user = SingleUser(u["title"],u["body"]);
      users.add(user);
    }

    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Center(
        // child: Text("loading...")
        child:FutureBuilder(
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
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(""),
                  ),
                  title: Text(snapshot.data[index].title),
                  subtitle: Text(snapshot.data[index].body),
                  onTap: (){
                    //Navigator.push(context, 
                      // new MaterialPageRoute(builder:(context) => DetailPage(snapshot.data[index]))
                      //new MaterialPageRoute(builder:(context)=> SubNotify())
                  // );
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