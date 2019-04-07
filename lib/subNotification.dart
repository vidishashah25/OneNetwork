import 'package:flutter/material.dart';
import 'package:login_page/Notification_.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User{
  
  final int id;
  final String name;
  final String username;
  final String email;

  User(this.id, this.name, this.username, this.email);
}


class SubNotify extends StatefulWidget {

  final User user;
  // final Project project;
  SubNotify(this.user);

  Future <List<User>> _getUserData() async {
    var data = await http.get('https://jsonplaceholder.typicode.com/users');
    var JsonData = json.decode(data.body);
    List<User> users = [];

    for(var u in JsonData){
      User user = User(u["id"],u["name"],u["username"],u["email"]);
      users.add(user);
    }

    print(users.length);
    return users;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
      ),
       body: Center(
        child: Column(
          children:<Widget>[
          Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                // leading: ,
                title: Text("Project Name"),
                subtitle: Text("Project Description"),
              ),
            ],
          )
        ),
        Card(
          child: FutureBuilder(
            future: _getUserData(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
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
                    );
                  },
                );
              }
            },
          )
          )
        ]
        )
      ) 
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}