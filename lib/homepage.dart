import 'package:flutter/material.dart';
import 'package:login_page/Notification_.dart';
import 'package:login_page/userprofile.dart';
import 'package:login_page/post.dart';
import 'naviRoute.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home Page'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.search), onPressed: null),
          new IconButton(icon: new Icon(Icons.notifications), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Notify()));
          })
        ],
      ),

      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Taher M'),
              accountEmail: new Text('t@gmail.com'),
              currentAccountPicture: new CircleAvatar(backgroundColor: Colors.black26,child: new Text('V'),),
              decoration: new BoxDecoration(color: Colors.blue[300]),

            ),

            new ListTile(title: new Text('Page 1'),
                trailing: new Icon(Icons.arrow_forward),
                onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext)=>UserProfile()))
                ),
            new ListTile(title: new Text('New Post'),
                trailing: new Icon(Icons.arrow_forward),
                onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext)=>Post()))
                ),
            new ListTile(title: new Text('close'),trailing: new Icon(Icons.arrow_forward),onTap: (){Navigator.pop(context);}),
          ],
        ),
      ),

      body: feed(),
    );
  }
}

class feed extends StatefulWidget {
  @override
  _feedState createState() => _feedState();
}


class _feedState extends State<feed> {
Future<List<Project>> _getFeeds() async{
    List<Project> up = [];
    var data = await http.get('https://jsonplaceholder.typicode.com/posts');
    var jsonData = json.decode(data.body);

    for(var u in jsonData){
      //Project temp = Project(u["id"], u["name"], u["username"], u["email"]);
      Project temp = Project(u["title"], u["body"]);
      up.add(temp);
    }

    print(up.length);
    return up;
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
              future: _getFeeds(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.data == null){
                  return Container(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  );
                }
                else{
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                        return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage("url"),
                        radius: 25.0,
                      ),
                      title: Text(
                        snapshot.data[index].title,
                        style: TextStyle(color: Colors.blue,
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.data[index].body,
                        style: TextStyle(
                          fontSize: 15.0,
                        ),                        
                      ), 
                    );
                          
                      },
                  );
                }
              },
            );
  }
}


class Updates{
  
  final int id;
  final String name;
  final String username;
  final String email;
  
  Updates(this.id, this.name, this.username, this.email);
}

class Project{
  final String title;
  final String body;

  Project(this.title, this.body); 
}