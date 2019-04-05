import 'package:flutter/material.dart';

class notification extends StatefulWidget {
  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                title: Text("Student Name"),
                subtitle: Text("Programme")
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text("Accept"),
                      onPressed: (){},
                    ),
                    FlatButton(
                      child: const Text("Reject"),
                      onPressed: (){},
                    )
                  ],
                ),
              )
            ],
          ),
        )
        ]
        )
        
      )
    );
  }
}