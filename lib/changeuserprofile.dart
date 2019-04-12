import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';
import 'package:flutter/material.dart';

class ChangeUserProfile extends StatefulWidget {
  @override
  _ChangeUserProfileState createState() => _ChangeUserProfileState();
}

class _ChangeUserProfileState extends State<ChangeUserProfile> {
  String name;
  var userprofile = null;
  void initState() {
    getusername();
  }

  Future<String> getusername() async {
    var url = await http.get("https://api.github.com/users/vishweshsoni");
    var responseJson = json.decode(url.body);
    var name1 = responseJson['login'];
    var image = responseJson['avatar_url'];
    setState(() {
      name = name1;
      userprofile = image;
    });
  }
  Widget _getImage(){
    if (userprofile == null) {
      return Container(
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(75.0)),
          boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)],
        ),
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
            image: NetworkImage(
              '$userprofile',
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(75.0)),
          boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:Colors.blue,title:Text('User Profile'),actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.power_settings_new),
            ),
        ],
      ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              color:Colors.white,
              child: Padding(
                  padding: EdgeInsets.only(top: 15.0,bottom: 7.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          children:<Widget>[

                            Container(
                              margin: EdgeInsets.only(left: 8.0,right: 5.0,bottom: 8.0),
                              width: 120.0,
                              height:120.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
//                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: _getImage(),
                            ),
                            SizedBox(width: 15.0,),
                            Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text('Name :',style: TextStyle(
                                          color: Colors.black,
                                        fontSize: 18.0,
                                      ),),
                                      SizedBox(width: 5.0,),
                                      Text('$name',style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(height: 20.0,),
                                  Row(
                                      children: <Widget>[
                                          Text('Student Id :',style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                          ),
                                    ),
                                          SizedBox(width: 5.0,),
                                          Text('201812101',style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                          ),),
                                      ],
                                  ),


                                ],
                            ),
                          ],
                      ),
                      SizedBox(height: 5.0,),
                      Container(
                        margin: EdgeInsets.only(left: 0.0,right: 0.0),
                        height: 1.1,width: double.infinity,color: Colors.black,),
                      SizedBox(height: 5.0,),
                      Container(
                        margin: EdgeInsets.only(left: 30.0,top: 10.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.favorite),
                            Text('Intrests'),
                            TextField(

                            ),
                          ],
                        ),
                      )
                    ],

                  ),

              ),

            ),

          ),
        ),
    );
  }
}
class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 2.5);
    path.lineTo(size.width + 100, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
