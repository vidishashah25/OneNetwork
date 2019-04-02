import 'package:flutter/material.dart';
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
          new IconButton(icon: new Icon(Icons.notifications), onPressed: null)
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

      body: cardContain(),


    );
  }
}


class cardContain extends StatelessWidget {
  @override
  Widget build_card(BuildContext context,int index) {
    return Center(

      child: Card(
        elevation: 50,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () { /* ... */ },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('Person Name'),
                subtitle: Text('Deatils About Project'),
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('Like'),
                      onPressed: (){},
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: build_card,itemCount: 20);
  }
}
