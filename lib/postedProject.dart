import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FetchPost extends StatefulWidget {
  @override
  _FetchPostState createState() => _FetchPostState();
}

class _FetchPostState extends State<FetchPost> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  SharedPreferences prefs;
  var userid;

  Future<void> _ackAlert(BuildContext context,String id) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: const Text('Would you like to delete post from list?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Confirm'),
              onPressed: () {
                _deletepost(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
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

  Future<List<DataDisp>> _getposts() async {
    DataDisp dataDisp;
    String url =
        "http://onenetwork.ddns.net/api/posted_project_by_user.php?userid=" +
            userid;
    if (userpost.isEmpty) {
      var data = await http.get(url);
      var JsonData = json.decode(data.body);
      var len = JsonData["projects"].length;
      print(JsonData["projects"][0]["project"]["description"]);
      print(JsonData["projects"][0]["interests_string"]);

      for (int i = 0; i < len; i++) {
        dataDisp = new DataDisp(
            JsonData["projects"][i]["project"]["title"],
            JsonData["projects"][i]["interests_string"],
            JsonData["projects"][i]["project"]["id"],
            JsonData["projects"][i]["project"]["description"]);
        userpost.add(dataDisp);
      }
    }
    // print(userpost);
    return userpost;
  }

  Future<String>_deletepost(String id) async {
    Dio dio = new Dio();
    String url = "http://onenetwork.ddns.net/api/delete_project.php?projectid="+id;

    print(id);

    final response = await dio.post(url);

    String ans = response.toString();
    print(ans);

    var responseJson = jsonDecode(ans);

    var result = responseJson["error"];

    if(result=="false")
      {
        print(result);

      }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getposts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text("My Projects"),
            ),
            body: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _refresh,
              child: Center(
                child: Text("Loading..."),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text("My Projects"),
              //    actions: <Widget>[
              //     new IconButton(
              //         icon: const Icon(Icons.refresh),
              //         tooltip: 'Refresh',
              //         onPressed: () {
              //           _refreshIndicatorKey.currentState.show();
              //         }),
              //       ],
            ),
            body: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _refresh,
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              snapshot.data[index].title,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.0,
                                fontFamily: 'times new roman',
                              ),
                            ),
                            Text(
                              "\nTechnology/Language: ",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                                fontFamily: 'times new roman',
                              ),
                            ),
                            Text(
                              snapshot.data[index].interest,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: 'times new roman',
                              ),
                            ),
                            Text(
                              "\nDescrition: ",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                                fontFamily: 'times new roman',
                              ),
                            ),
                            Text(
                              snapshot.data[index].description,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: 'times new roman',
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    icon: new Icon(Icons.delete_forever),
                                    onPressed: ()
                                {
                                  _ackAlert(context,snapshot.data[index].id);
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
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

class DataDisp {
  final String title;
  final String interest;
  final String id;
  final String description;

  DataDisp(this.title, this.interest, this.id,this.description);
}
