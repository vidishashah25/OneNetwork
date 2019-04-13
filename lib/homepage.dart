import 'package:flutter/material.dart';
import 'package:login_page/Notification_.dart';
import 'package:login_page/history_page.dart';
import 'package:login_page/userprofile.dart';
import 'package:login_page/post.dart';
import 'naviRoute.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(userid),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.search), onPressed: null),
          new IconButton(
              icon: new Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Notify()));
              })
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Taher M'),
              accountEmail: new Text('t@gmail.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.black26,
                child: new Text('V'),
              ),
              decoration: new BoxDecoration(color: Colors.blue[300]),
            ),
            new ListTile(
                title: new Text('Profile'),
                leading: Icon(Icons.account_circle),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext) => UserProfile()))),
            new ListTile(
                title: new Text('Add Post'),
                leading: new Icon(Icons.edit),
//                onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext)=>Post()))
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext) => HistoryPage()))),
            new ListTile(
              title: Text('Posted Projects'),
              leading: new Icon(Icons.description),
            ),
            new ListTile(
              title: Text('Applied Projects'),
              leading: new Icon(Icons.exit_to_app),
            ),
            new ListTile(
                title: Text('Log Out'),
                leading: new Icon(Icons.power_settings_new),
                onTap: () {
                  Navigator.pop(context);
                }),
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
  int i = 0;

  //=> fetch Data;
  List<DataModel> histories = [];

  Future<List<DataModel>> _getFeeds() async {
    DataModel temp;
    if(histories.isEmpty){
      //    var data = await http.get('http://onenetwork.ddns.net/api/view_project_details.php?projectid=4');
      var data =
      await http.get('http://onenetwork.ddns.net/api/display_projects.php');
      var jsonData = json.decode(data.body);
      i = jsonData["projects"].length;
      print(jsonData["projects"].length);
      for (int i = 0; i < jsonData["projects"].length; i++) {
        print(jsonData["projects"][i]["id"]);
        temp = new DataModel(
            jsonData["projects"][i]["id"],
            jsonData["projects"][i]["title"],
            jsonData["projects"][i]["description"],
            jsonData["projects"][i]["mentor"],
            jsonData["projects"][i]["creator"]);
        print('reached');
        histories.add(temp);
        print(temp.id);
      }


    }
    return histories;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getFeeds(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text("Loading..."),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage("url"),
                  radius: 25.0,
                ),
                title: Text(
                  snapshot.data[index].title,
                  style: TextStyle(
                    color: Colors.blue,
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

class Updates {
  final int id;
  final String name;
  final String username;
  final String email;

  Updates(this.id, this.name, this.username, this.email);
}

class DataModel {
  final String id;
  final String title;
  final String description;
  final String creator;
  final String mentor;

  // final Address address;

  DataModel(this.id, this.title, this.description, this.creator, this.mentor);
}
