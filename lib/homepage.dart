import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_page/Notification_.dart';
import 'package:login_page/history_page.dart';
import 'package:login_page/main.dart';
import 'package:login_page/userprofile.dart';
import 'package:login_page/post.dart';
import 'package:login_page/searchView.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  // HomePage(userid);
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
    print(userid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // title: new Text('userid'),
        title: new Text(userid),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.search), onPressed: (){
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ExamplePage()));
          }),
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
                onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext)=>Post()))),
              
            // new ListTile(
            //   title: Text('Posted Projects'),
            //   leading: new Icon(Icons.description),
            //   onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            //         builder: (BuildContext) => HistoryPage()))
            // ),
            
            new ListTile(
              title: Text('Applied Projects'),
              leading: new Icon(Icons.exit_to_app),
            ),
            new ListTile(
                title: Text('Log Out'),
                leading: new Icon(Icons.power_settings_new),
                onTap: () {
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (BuildContext) => LoginPage()));
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

  int i = 0;

  //=> fetch Data;
  List<DataModel> histories = [];

  Future<List<DataModel>> _getFeeds() async {
    DataModel temp;
    if(histories.isEmpty){
      var data =
      await http.get('http://onenetwork.ddns.net/api/display_projects.php');
      var jsonData = json.decode(data.body);
      // i = jsonData["projects"].length;
      // print('HI');
      // print(jsonData["projects"][0]["creator_name"]);
      // print(jsonData["projects"][0]["creator_name"]);
    
      for (int i = 0; i < jsonData["projects"].length; i++) {
        temp = new DataModel(
          jsonData["projects"][i]["project"]["id"],
          jsonData["projects"][i]["project"]["title"],
          jsonData["projects"][i]["project"]["description"],
          jsonData["projects"][i]["project"]["creator"],
          jsonData["projects"][i]["project"]["mentor"],
          jsonData["projects"][i]["interest_str"],
          jsonData["projects"][i]["creator_name"]
          );
        print('reached');
        histories.add(temp);
        print(temp.creator_name);
      }
    }
    return histories;
  }

  @override
  Widget build(BuildContext context) {
    
    return  FutureBuilder(
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
                if(snapshot.data[index].creator != userid){
                return Card(
                  child: Column(
                    children: <Widget>[
                        Text("Proposed By: "+snapshot.data[index].creator_name+"\n",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18.0,
                          fontFamily: 'times new roman',
                        ),
                        ),
                      Text("Project: "+snapshot.data[index].title+"\n",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                        fontFamily: 'times new roman',
                      ),
                      ),
                      Text("Technology: "+snapshot.data[index].interest_str,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontFamily: 'times new roman',
                        ),
                      ),
                      Text("\nAbout Project: "+snapshot.data[index].description,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontFamily: 'times new roman',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        FlatButton(
                            child: Text("Apply",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontFamily: 'times new Roman',
                            ),
                            ),
                            onPressed: (){
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Apply(snapshot.data[index])));
                            },
                        ),
                         FlatButton(
                              child: Text("More>>",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontFamily: 'times new Roman',
                              ),
                              ),
                              onPressed: (){
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => ViewProject(snapshot.data[index])));

                              },
                            ),
                        ],
                      )
                    ],
                  ),
                );
              }
              else{
                return Card(
                  child: Column(
                    children: <Widget>[
                      Text("Proposed By: "+snapshot.data[index].creator_name+"\n",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                        fontFamily: 'times new roman',
                      ),
                      ),
                      Text("Project: "+snapshot.data[index].title+"\n",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                        fontFamily: 'times new roman',
                      ),
                      ),
                      Text("Technology: "+snapshot.data[index].interest_str,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontFamily: 'times new roman',
                        ),
                      ),
                      Text("\nAbout Project: "+snapshot.data[index].description,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontFamily: 'times new roman',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        // FlatButton(
                        //     child: Text("Apply",
                        //     style: TextStyle(
                        //       color: Colors.blue,
                        //       fontSize: 14,
                        //       fontFamily: 'times new Roman',
                        //     ),
                        //     ),
                        //     onPressed: (){
                        //       Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (BuildContext context) => Apply(snapshot.data[index])));
                        //     },
                        // ),
                         FlatButton(
                              child: Text("More>>",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontFamily: 'times new Roman',
                              ),
                              ),
                              onPressed: (){
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => ViewProject(snapshot.data[index])));

                              },
                            ),
                        ],
                      )
                    ],
                  ),
                );
              }
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
  final String interest_str;
  final String creator_name;

  // final Address address;

  DataModel(this.id, this.title, this.description, this.creator, this.mentor, this.interest_str, this.creator_name);
}


// =>New Class for applying in project

class Apply extends StatefulWidget {
  final DataModel project;
  Apply(this.project);

  @override
  _ApplyState createState() => _ApplyState();
}

class _ApplyState extends State<Apply> {
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

TextEditingController _applyMsg = new TextEditingController();
bool _validate = false;

Future<String> _applyData(String msg, String projectid) async {
      Dio dio = new Dio();
      //You need to comment this id  ASA login issue resolved @taher
      // var userid = "201812017";
      print(msg);
      FormData formData = new FormData.from({
        "userid": userid,
        "projectid": projectid,
        "resume": 0,
        // Need to check after pratik make change in API
        "message": msg
      });
      final response = await dio
          .post("http://onenetwork.ddns.net/api/apply_student.php", data: formData);
      String ans = response.toString();
      print(ans);
      var responseJson = jsonDecode(ans);
      var result = responseJson["error"];

      if (result == "false") {
        Fluttertoast.showToast(
            msg: "Successfully Applied for project",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.black87,
            fontSize: 16.0);
      }
      return result;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
            child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20.0,20.0,20.0,10.0),
                  child: Text("Why you want to apply? ",
                    style: TextStyle(
                      color: Colors.blue,
                        fontFamily: "Times New Roman",
                        fontSize: 20,
                    ),
                    ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0,20.0,20.0,30.0),
                child: TextField(
                  maxLines: 4,
                  controller: _applyMsg,
                  autocorrect: true,
                  decoration: InputDecoration(
                    errorText: _validate ? 'Value Can\'t Be Empty' : null,
                  ),
                ),
              ),     
                Text("Your sure you want to apply? ",
                  style: TextStyle(
                    color: Colors.blue,
                      fontFamily: "Times New Roman",
                      fontSize: 20,
                  ),
                  ),
                SizedBox(
                  height: 20.0,
                ),
              
              Padding(
                padding: EdgeInsets.fromLTRB(60.0,20.0,60.0,00.0),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.blue,
                      child: Text("Yes",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Times New Roman",
                        fontSize: 15,
                      ),
                      ),
                      onPressed: (){
                        setState(() {
                          _applyMsg.text.isEmpty ? _validate = true : _validate = false;
                        });
                        if(_applyMsg.text.isNotEmpty){
                          _applyData(_applyMsg.text, widget.project.id);
                        }
                        
                      },
                    ),

                  RaisedButton(
                    color: Colors.red,
                      child: Text("No",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Times New Roman",
                        fontSize: 15,
                      ),
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                )
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}