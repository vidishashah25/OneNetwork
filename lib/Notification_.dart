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
    var data = await http.get('https://jsonplaceholder.typicode.com/posts');
    var JsonData = json.decode(data.body);

    List<User> users = [];

    for(var u in JsonData){
      User user = User(u["userId"], u["id"],u["title"],u["body"]);
      users.add(user);
    }

    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificaiton"),
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
                  //leading: CircleAvatar(
                  //   backgroundImage: 
                  // ),
                  title: Text(snapshot.data[index].title),
                  subtitle: Text(snapshot.data[index].body),
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
  final int userId;
  final int id;
  final String title;
  final String body;

  User(this.userId, this.id, this.title, this.body);
}

// onPressed: (){
//   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => notification()));
// },