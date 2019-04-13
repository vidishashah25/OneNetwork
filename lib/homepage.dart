import 'package:flutter/material.dart';
import 'package:login_page/Notification_.dart';
import 'package:login_page/userprofile.dart';
import 'package:login_page/post.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_page/history_page.dart';

class HomePage extends StatelessWidget {
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
            new ListTile(title: new Text('History'),
                trailing: new Icon(Icons.arrow_forward),
                onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext)=>HistoryPage()))
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
Future<List<Projects>> _getFeeds() async{
    List<Projects> up = [];
    var data = await http.get('http://onenetwork.ddns.net/api/display_projects.php');
    var jsonData = json.decode(data.body);

    for(var u in jsonData){
      Projects temp = Projects(u["projects"]["id"], u["projects"]["title"], u["projects"]["description"], u["projects"]["mentor"], u["projects"]["projectType"], u["projects"]["creator"], u["projects"]["time"], u["projects"]["status"]);
      up.add(temp);
      print(temp.title);
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
                        snapshot.data[index].description,
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

class Projects{

  final String id;
  final String title;
  final String description;
  final String mentor;
  final String projectType;
  final String creator;
  final String time;
  final String status;

  Projects(this.id, this.title, this.description, this.mentor,this.projectType,this.creator,this.time,this.status);
}

class Tempo{
  final  String title;
  final String description;
  Tempo(this.title,this.description);
}