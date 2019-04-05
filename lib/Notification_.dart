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
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(""),
                  ),
                  title: Text(snapshot.data[index].name),
                  subtitle: Text(snapshot.data[index].email),
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
  final User user;
  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Center(
        child: Text("loading...")
      ),
      
    );
  }
}
