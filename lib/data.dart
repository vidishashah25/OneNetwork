import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Interest{
  final Interest_array ia;
  Interest({this.ia});

  factory Interest.fromJson(Map<String, dynamic> json){
    return Interest(
      ia: Interest_array.fromJson(json['interests_array'])
    );
  }

}

class Interest_array{
  final int id;
  final String name;
  final int category;
Interest_array({this.id, this.name, this.category});

  factory Interest_array.fromJson(Map<String, dynamic> json){
    return Interest_array(
      id: json['id'],
      name: json['name'], 
      category: json['category']
      );
  }
  
}

class GetData extends StatefulWidget {
  @override
  _GetDataState createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  List<Interest> list;

Future<List<Interest>> _getLanguage() async {
    String link =
          "onenetwork.ddns.net/api/interests.php";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    print(res.body);
    setState(() {
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        var rest = data["interests"] as List;
        print(rest);
        list = rest.map<Interest>((json) => Interest.fromJson(json)).toList();
      }
    });
    print("List Size: ${list.length}");
    return list;
  }
Widget build(BuildContext context) {
  return Container(
    child: listViewWidget(list),
  );
}
Widget listViewWidget(List<Interest> interest) {
    return Container(
      child: ListView.builder(
          itemCount: 20,
          padding: const EdgeInsets.all(2.0),
          itemBuilder: (context, position) {
            return Card(
              child: ListTile(
                title: Text(
                  '${interest[position].ia.id}',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Text('${interest[position].ia.name}'),
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
               // onTap: () => _onTapItem(context, article[position]),
              ),
            );
          }),
    );
  }
  }