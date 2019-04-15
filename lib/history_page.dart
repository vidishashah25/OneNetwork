import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/homepage.dart';
import 'dart:async';
import 'dart:convert';

class ViewProject extends StatefulWidget {
  final DataModel project;
  ViewProject(this.project);  
  @override
  ViewProjectState createState() => ViewProjectState();
}

class ViewProjectState extends State<ViewProject> {
  
  //=> fetch Data;
  List<AppliedUser> histories = [];
  
  Future<List<AppliedUser>> _getData() async {
    if(histories.length!=0){
      AppliedUser temp;
    String url = "http://onenetwork.ddns.net/api/view_project_details.php?projectid="+widget.project.id;
    var data = await http.get(url);
    var jsonData = json.decode(data.body);
    print(jsonData["applied_user_names"].length);
    for(int i=jsonData["applied_user_names"].length-1;i>=0;i--){
    temp = new AppliedUser(jsonData["applied_user_names"][i]["applied_user"]);
    histories.add(temp);
    }
    print(histories.length);
    return histories;

    }
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

  Widget _historyWidget(AppliedUser history) {
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
                            child:Row(
                              children: <Widget>[
                                 Container(
                                   margin: EdgeInsets.all(15),
                                   child: CircleAvatar(
                                      backgroundImage: NetworkImage(""),
                                      radius: 25,
                                    ),
                                 ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Column(
                                    children: <Widget>[
                                        Text(history.user,
                                            style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            fontFamily: 'Times New Roman',
                                          ),
                                        ),
                                      ButtonTheme.bar(
                                        child: ButtonBar(
                                          children: <Widget>[
                                            FlatButton(
                                              child: const Text('Accept'),
                                              onPressed: (){},
                                            ),
                                            FlatButton(
                                              child: const Text('Reject',
                                              style: TextStyle(color: Colors.red)),
                                              onPressed: (){},
                                            )
                                          ],
                                        )
                                      )
                                    ]
                                ),
                                  )
                              ],
                            ),
                          
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Text(
                  //       history.user,
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //       textAlign: TextAlign.left,
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

class AppliedUser {

  final String user;

  AppliedUser(this.user);
}


