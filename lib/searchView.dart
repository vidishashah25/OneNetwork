import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:login_page/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:login_page/homepage.dart';



class ExamplePage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _ExamplePageState createState() => new _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
new GlobalKey<RefreshIndicatorState>();
SharedPreferences prefs;

  var userid;

  Future<String> _getNames() async {
      print("hey");
      String url = "http://onenetwork.ddns.net/api/display_projects.php?userid="+userid;
      final response = await dio.get(url);
      List tempList = new List();
      for (int i = 0; i < response.data['projects'].length; i++) {
        print(response.data['projects'][i]['project']);
        tempList.add(response.data['projects'][i]['project']);
      }
      setState(() {
        names = tempList;
        names.shuffle();
        filteredNames = names;
      });
    }

  getdata() async {
    prefs = await SharedPreferences.getInstance();
    userid = prefs.getString("userid");
    
  }
  
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Search Here' );

  _ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    getdata();
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return  RefreshIndicator(
       key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Scaffold(
        appBar: _buildBar(context),
        body: Container(
          child: _buildList(),
        ),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }
    Future<Null> _refresh() {
    return _getNames().then((histories) {
      setState(() => histories = histories);
    });
  }
  

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      actions: <Widget>[
          new IconButton(
            icon: _searchIcon,
            onPressed: _searchPressed,
          ),
        
      ],
    );
  }

    Widget _buildList() {
      if (!(_searchText.isEmpty)) {
        List tempList = new List();
        for (int i = 0; i < filteredNames.length; i++) {
          if (filteredNames[i]['title'].toLowerCase().contains(_searchText.toLowerCase())) {
            tempList.add(filteredNames[i]);
          }
        }
        filteredNames = tempList;
      }
      return ListView.builder(
        itemCount: names == null ? 0 : filteredNames.length,
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
            title: Text(
              filteredNames[index]['title'],
              style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Times New Roman',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
            ),
            
            onTap: () => print(filteredNames[index]['title']),
          );
        },
      );
    }

    void _searchPressed() {
      setState(() {
        if (this._searchIcon.icon == Icons.search) {
          this._searchIcon = new Icon(Icons.close);
          this._appBarTitle = new TextField(
            controller: _filter,
            decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'
            ),
          );
        } else {
          this._searchIcon = new Icon(Icons.search);
          this._appBarTitle = new Text( 'Search Here' );
          filteredNames = names;
          _filter.clear();
        }
      });
    }

    // void _getNames() async {
    //   print("hey");
    //   String url = "http://onenetwork.ddns.net/api/display_projects.php?userid="+userid;
    //   final response = await dio.get(url);
    //   List tempList = new List();
    //   for (int i = 0; i < response.data['projects'].length; i++) {
    //     print(response.data['projects'][i]['project']);
    //     tempList.add(response.data['projects'][i]['project']);
    //   }
    //   setState(() {
    //     names = tempList;
    //     names.shuffle();
    //     filteredNames = names;
    //   });
    // }

  }


// class DataModel {
//   final String id;
//   final String title;
//   final String description;
//   final String creator;
//   final String mentor;

//   // final Address address;

//   DataModel(this.id, this.title, this.description, this.creator, this.mentor);
// }
    