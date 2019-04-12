import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {

  //=> create Data;

  List<HistoryModel> histories = [
    HistoryModel("1","taher","how are you", "P_name"),
    HistoryModel("2","Vishwesh","how are you", "P_name"),
  ];

  Future<List<HistoryModel>> _getData() async {
    List<HistoryModel> histories = [];
    // var temp = await http.get('onenetwork.ddns.net/api/view_project_details.php');
    var data = await http.get('https://jsonplaceholder.typicode.com/posts');
    var jsonData = json.decode(data.body);
    
    for(var u in jsonData){
      HistoryModel temp = HistoryModel(u["userId"], u["id"], u["title"], u["body"]);
      histories.add(temp);
      print(temp);
    }

    print("tot. data: $histories.length");
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
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
            //   child: Text(
            //     'Project Title',
            //     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
            //   ),
            // ),
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
                    itemCount: histories.length,
                    itemBuilder: (BuildContext context, int index){
                      return _historyWidget(histories[index]);
                    },
                  );
                }
                },
              ),
              
//old code
              // child: ListView.builder(
              //     itemCount: histories.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return _historyWidget(histories[index]);
              //     }),
//old code
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
                        history.title.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                      ),
                      Text(history.body)
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
  // final String historyAssetPath;
  // final String historyType;
  // final String receiverName;
  // final double amount;
  // final String date;
  // final String cardLogoPath;

  // HistoryModel(this.historyAssetPath, this.historyType, this.receiverName,
      // this.amount, this.date, this.cardLogoPath);
  
  // final int id;
  // final String name;
  // final String msg;
  // final String p_name;
  
  // HistoryModel(this.id, this.name, this.msg, this.p_name);

  final String userid;
  final String id;
  final String title;
  final String body;

  HistoryModel(this.userid, this.id, this.title, this.body);
}

// List<HistoryModel> histories = [
//     HistoryModel('images/ico_send_money.png', 'Paid to', 'Salina', 999.0,
//         '08 May 2018', 'images/ico_logo_red.png'),
//     HistoryModel('images/ico_pay_elect.png', 'Electricity\nbill paid',
//         'Fantasy lights', 830.0, '08 May 2018', 'images/ico_logo_red.png'),
//     HistoryModel('images/ico_pay_phone.png', 'Mobile\nrecharged',
//         'Fantasy mobile', 830.0, '08 May 2018', 'images/ico_logo_red.png'),
//     HistoryModel('images/ico_receive_money.png', 'Received from', 'Salina',
//         30.0, '08 May 2018', 'images/ico_logo_blue.png'),
//     HistoryModel('images/ico_send_money.png', 'Paid to', 'Salina', 999.0,
//         '08 May 2018', 'images/ico_logo_red.png'),
//     HistoryModel('images/ico_pay_elect.png', 'Electricity\nbill paid',
//         'Fantasy lights', 830.0, '08 May 2018', 'images/ico_logo_red.png'),
//     HistoryModel('images/ico_pay_phone.png', 'Mobile\nrecharged',
//         'Fantasy mobile', 830.0, '08 May 2018', 'images/ico_logo_red.png'),
//     HistoryModel('images/ico_receive_money.png', 'Received from', 'Salina',
//         30.0, '08 May 2018', 'images/ico_logo_blue.png'),
//   ];