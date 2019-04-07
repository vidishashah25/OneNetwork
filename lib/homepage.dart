import 'package:flutter/material.dart';
import 'package:login_page/Notification_.dart';
import 'package:login_page/userprofile.dart';
import 'naviRoute.dart';

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
              accountName: new Text('Vidisha Shah'),
              accountEmail: new Text('v@gmail.com'),
              currentAccountPicture: new CircleAvatar(backgroundColor: Colors.black26,child: new Text('V'),),
              decoration: new BoxDecoration(color: Colors.blue[300]),
            ),

            new ListTile(title: new Text('Page 1'),
                trailing: new Icon(Icons.arrow_forward),
                onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext)=>UserProfile()))),
            new ListTile(title: new Text('Page 2'),
                trailing: new Icon(Icons.arrow_forward),
                onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext)=>new op('Page 2')))
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feeds"),
      ),


    );
  }
}