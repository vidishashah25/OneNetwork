import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  //=> fetch Data;

  Future<List<HistoryModel>> _getData() async {
    List<HistoryModel> histories = [];
    
    var data = await http.get('https://jsonplaceholder.typicode.com/users');
    var jsonData = json.decode(data.body);

    for(var u in jsonData){
      HistoryModel temp = HistoryModel(u["id"], u["name"], u["username"], u["email"],u["address"]["street"]);
      histories.add(temp);
      print(temp.street);
      print(u["address"]["street"]);
    }

    print(histories.length);
    return histories;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        title: Text("More Details.."),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Text(
                'Project Title',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0),
                height: 200.0,
                child: Row(
                  children: <Widget>[
   //Month
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 16.0),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Text("Project Description"),
                              ),
                              // Icon(Icons.description)
                            ],
                          ),
                        ),
                      ),
                    ),                 
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _getData(),
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
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      return _historyWidget(snapshot.data[index]);
                    },
                  );
                }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _historyWidget(HistoryModel history) {
    return Container(
//      height: 100.0,
        margin: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
          child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Image.asset(
                  "history.historyAssetPath",
                  height: 40.0,
                  width: 40.0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        history.username,
                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                      ),
                      Text(history.street)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  
  }
}

class HistoryModel {
  
  final int id;
  final String name;
  final String username;
  final String email;
  final String street;
  // final Address address;

 HistoryModel(this.id, this.name, this.username, this.email,this.street);
}

// class Project_details {
  
  
//   final String title;
//   final String description;
//   final String mentor;
//   final String creator;
//   final String creatorname;
//   final String applied_user;

//  Project_details(this.title, this.description, this.mentor, this.creator, this.creatorname, this.applied_user);
// }