import 'package:flutter/material.dart';
import 'package:login_page/Notification_.dart';
import 'package:login_page/history_page.dart';
import 'package:login_page/userprofile.dart';
import 'package:login_page/post.dart';
import 'naviRoute.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewHomePage extends StatefulWidget {
  @override
  NewHomePageState createState() {
    return new NewHomePageState();
  }
}

class NewHomePageState extends State<NewHomePage> {
  int j = 0,k=0;

  //=> fetch Data;
  List<DataModel> histories = [];

  Future<List<DataModel>> _getFeeds() async {
    DataModel temp;
    if(histories.isEmpty){
      //    var data = await http.get('http://onenetwork.ddns.net/api/view_project_details.php?projectid=4');
      var data =
      await http.get('http://onenetwork.ddns.net/api/display_projects.php');
      var jsonData = json.decode(data.body);

      print(jsonData["projects"].length);
      for (int i = 0; i < jsonData["projects"].length; i++) {
        print(jsonData["projects"][j]["id"]);
        temp = new DataModel(
            jsonData["projects"][j]["id"],
            jsonData["projects"][j]["title"],
            jsonData["projects"][j]["description"],
            jsonData["projects"][j]["mentor"],
            jsonData["projects"][j]["creator"]);

        j++;
        print('reached');
        histories.add(temp);
        print(temp.id);
      }


    }
    return histories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder(
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
              itemCount: snapshot.data.length+1,
              itemBuilder: (BuildContext context, int index) {
                return index == 0 ? _searchbar(snapshot.data) : _listitem(index-1,snapshot.data);


              },

            );
          }
        },
      ),
    );
  }

  _searchbar(List<DataModel> histories1){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Search.....'
        ),
        onChanged: (text){
        text= text.toLowerCase();
        setState(() {
            histories1 = histories1.where((his){
              var histitle = his.title.toLowerCase();
              return histitle.contains(text);
          }).toList();
        });
        },
      ),
    );

  }
  _listitem(int index,List<DataModel> histories){
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage("url"),
        radius: 25.0,
      ),
      title: Text(
        histories[index].title,
        style: TextStyle(
          color: Colors.blue,
          fontFamily: 'Times New Roman',
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      subtitle: Text(
        histories[index].description,
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
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

  // final Address address;

  DataModel(this.id, this.title, this.description, this.creator, this.mentor);
}
