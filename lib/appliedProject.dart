import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FetchAppliedPost extends StatefulWidget {
  @override
  _FetchAppliedPostState createState() => _FetchAppliedPostState();
}

class _FetchAppliedPostState extends State<FetchAppliedPost> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
new GlobalKey<RefreshIndicatorState>();

  SharedPreferences prefs;
  var userid;

  getdata() async {
    prefs = await SharedPreferences.getInstance();
    userid = prefs.getString("userid");
  }

  @override
  void initState() {
    getdata();
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }
  List<DataDisp> userpost = [];

  Future<List<DataDisp>> _getposts() async{
    
    DataDisp dataDisp;
    String url = "http://onenetwork.ddns.net/api/applied_into_projects.php?userid="+userid;
    if(userpost.isEmpty){
      var data = await http.get(url);
      var JsonData = json.decode(data.body);
      var len = JsonData["projects"].length;
      print(JsonData["projects"]);
      print(JsonData["projects"][0]["project_detail"]["description"]);
      print(JsonData["projects"][0]["project_detail"]["title"]);
      print(JsonData["projects"][0]["interests_string"]);

        for(int i=0; i< len; i++){
          dataDisp = new DataDisp(
            JsonData["projects"][i]["project_detail"]["title"],
            JsonData["projects"][i]["interests_string"],
            JsonData["projects"][i]["project_detail"]["description"]);
          userpost.add(dataDisp);
        }
    }
    // print(userpost);
  return userpost;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getposts(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.data==null)
          {
            return Scaffold(
              appBar: AppBar(
                title: Text("Applied Projects"),
              ),
             body: RefreshIndicator(
                key:_refreshIndicatorKey,
                onRefresh: _refresh,
                  child: Center(
                  child: Text("Loading..."),
                ),
              ),
            );
          }
        else
          {
            return Scaffold(
              appBar: AppBar(
                title: Text("Applied Projects"),
              ),
              body: RefreshIndicator(
                key:_refreshIndicatorKey,
                onRefresh: _refresh,
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index)
                    {
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0,10,0,10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(snapshot.data[index].title,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Text("Technology/Language: ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Text(snapshot.data[index].interest,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Text("Description: ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Text(snapshot.data[index].description,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),
            );
          }
      },
    );
  }
  Future<Null> _refresh() {
    return _getposts().then((userpost) {
      setState(() => userpost = userpost);
    });
  }
}



class DataDisp{
  final String title;
  final String interest;
  final String description;
  DataDisp(this.title,this.interest,this.description);
}