import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FetchPost extends StatefulWidget {
  @override
  _FetchPostState createState() => _FetchPostState();
}

class _FetchPostState extends State<FetchPost> {

  SharedPreferences prefs;
  var userid;

  getdata() async {
    prefs = await SharedPreferences.getInstance();
    userid = prefs.getString("userid");
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }



  List<DataDisp> userpost = [];

  Future<List<DataDisp>> _getposts() async{

    DataDisp dataDisp;
    String url = "http://onenetwork.ddns.net/api/posted_project_by_user.php?userid="+userid;
    if(userpost.isEmpty){
      var data = await http.get(Uri.encodeFull(url));
      var jsonData = json.decode(data.body);
      print(jsonData["projects"].length);

      for(int i=0;i<jsonData["projects"].length;i++)
        {
          dataDisp = new DataDisp(
              jsonData["projects"][i]["project"]["title"],
              jsonData["projects"][i]["interest_str"],
              jsonData["projects"][i]["project"]["description"]
          );
          print('reached');
          userpost.add(dataDisp);
        }
    }
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
              body: Center(
                child: Text("Loading..."),
              ),
            );
          }
        else
          {
            return Scaffold(
              body: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index)
              {
                return Card(

                  child: Column(
                    children: <Widget>[
                      Text(snapshot.data[index].title,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18.0,
                          fontFamily: 'times new roman',
                        ),
                      ),
                      Text(snapshot.data[index].description,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18.0,
                          fontFamily: 'times new roman',
                        ),
                      ),
                      Text(snapshot.data[index].interest,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18.0,
                          fontFamily: 'times new roman',
                        ),
                      )
                    ],
                  ),
                );
              }),
            );
          }
      },
    );
  }
}



class DataDisp{
  final String title;
  final String interest;
  final String description;
  DataDisp(this.title,this.interest,this.description);
}