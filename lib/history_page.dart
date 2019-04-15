import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/homepage.dart';
import 'dart:async';
import 'dart:convert';

class HistoryPage extends StatefulWidget {
  final DataModel project;
  HistoryPage(this.project);  
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  // HistoryPage(this.project); 
  //=> fetch Data;
  List<HistoryModel> histories = [];
  Future<List<HistoryModel>> _getData() async {
    HistoryModel temp;
    
    var data = await http.get('http://onenetwork.ddns.net/api/display_projects.php');
    var jsonData = json.decode(data.body);
    print(jsonData["projects"].length);
    for(int i=0;i<jsonData["projects"].length;i++){
      print(jsonData["projects"][i]["id"]);
      temp= new HistoryModel(jsonData["projects"][i]["id"], jsonData["projects"][i]["title"],);
      print('reached');
      histories.add(temp);
      print(temp.id);

    }
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
                widget.project.title,
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
                                child: Text(
                                  widget.project.description+
                                  "\n Technology: "+widget.project.interest_str+
                                  "\n Creator: "+widget.project.creator),
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

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        history.id.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Text(history.title)
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

  final String id;
  final String title;

  HistoryModel(this.id, this.title);
}


