import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/changeuserprofile.dart';
import 'package:login_page/updateresume.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String name;
  var userprofile = null;
  void initState() {
    getusername();
  }




  Widget_getImage() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(color: Colors.blue.withOpacity(0.8)),
            clipper: getClipper(),
          ),

          Positioned(
            width: 350.0,
            top: MediaQuery.of(context).size.height / 8,
            child: Column(
              children: <Widget>[
                Widget_getImage(),
                SizedBox(height: 5.0),
                Text(
                  '$name',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 15.0),
                Container(
                  margin: EdgeInsets.only(left: 20.0,right:20.0),
                  alignment: FractionalOffset.center,
                  child: Column(
                    children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.blue))
                                ),
                                child:Row(
                                    children: <Widget>[
                                          Icon(Icons.verified_user),
                                        Container(
                                          width: 100.0,
                                          height: 20.0,
                                          child: Text('Student Id',textAlign: TextAlign.center,),
                                        ),
                                        SizedBox(width: 2.0),
                                        Text('201812101'),


                                    ],
                                ),
                            ),
                            SizedBox(height: 20.0,),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.blue))
                              ),
                              child:Row(
                                children: <Widget>[

                                  Icon(Icons.email),
                                  Container(
                                    width: 100.0,
                                    height: 20.0,

                                    child: Text('Email',textAlign: TextAlign.center,),
                                  ),
                                  SizedBox(width: 2.0,),
                                  SizedBox(width: 2.0),
                                  Text('201812101@daiict.ac.in'),

                                ],
                              ),
                            ),
                            SizedBox(height: 20.0,),
                            Container(

                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.blue))
                              ),
                              child:Row(
                                children: <Widget>[
                                  Icon(Icons.favorite),
                                  Container(
                                    width: 100.0,
                                    height: 20.0,
                                    child: Text('Intrests',textAlign: TextAlign.center,),
                                  ),
                                  SizedBox(width: 2.0,),
                                  SizedBox(width: 2.0),
                                  Text('Nodejs,php,mysql,java'),
                                  SizedBox(width: 16.0),
                                  Container(
                                      child:GestureDetector(
                                        child: Icon(Icons.edit),
                                        onTap: ()=>{
                                        showAlertDialog(context),
                                        },
                                      )
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0,),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.blue))
                              ),
                              child:Row(
                                children: <Widget>[
                                  Icon(Icons.assessment),
                                  Container(
                                    width: 100.0,
                                      height: 20.0,
                                    child: Text('No of project',textAlign: TextAlign.center,),
                                  ),
                                  SizedBox(width: 2.0,),
                                  SizedBox(width: 2.0),
                                  Text('20'),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0,),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.blue))
                              ),
                              child:Row(
                                children: <Widget>[
                                  Icon(Icons.local_activity),
                                  Container(
                                    width: 100.0,
                                    height: 20.0,
                                    child: Text('Resume',textAlign: TextAlign.center,),
                                  ),
                                  SizedBox(width: 2.0,),
                                  SizedBox(width: 2.0),
                                  Material(
                                      color: Colors.white70,
                                      child: MaterialButton(
                                          onPressed: null,
                                        minWidth: 25.0,
                                        color: Colors.grey,
                                        child: Text('Download',style: TextStyle(
                                        color: Colors.black,

                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(46.0)),
                                      ),
                                  ),
                                  SizedBox(width: 59.0),
                                  Container(
                                      child:GestureDetector(
                                        child: Icon(Icons.edit),
                                        onTap: ()=>{
                                        showAlertDialog1(context),
                                        },
                                      )
                                  ),

                                ],
                              ),
                            )
                    ],
                  ),
                ),
//                           
              ],
            ),
          ),
        ],
      ),
    );
  }
  //Checkbox variable Declartion
  bool val1=false;
  bool val2=false;
  bool val3= false;
  bool val4=false;
  bool val5= false;
  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            /// manage the state of each value
            setState(() {
              switch (title) {
                case "Mon":
//                  bool temp1=true;
                  val1 = value;
                  break;
                case "Tue":
                  val2 = value;
                  break;
                case "Wed":
                  val3 = value;
                  break;
                case "Thu":
                  val4 = value;
                  break;
                case "Fri":
                  val5 = value;
                  break;

              }
            });
          },
        )
      ],
    );
  }





  void showAlertDialog(BuildContext context){
      showDialog(
          context: context,
          builder: (BuildContext context)=>MySelection(),
      );
  }

  void showAlertDialog1(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context)=>UpdateResume(),
    );
  }
}




//This refers to the Intrest Field Dialog
class MySelection extends StatefulWidget {
  @override
  _MySelectionState createState() => _MySelectionState();
}





class _MySelectionState extends State<MySelection> {


  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;
  bool thurVal = false;
  bool friVal = false;
  bool satVal = false;
  bool sunVal = false;

  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            /// manage the state of each value
            setState(() {
              switch (title) {
                case "NodeJs":
                  monVal = value;
//                  print(monVal);
                  break;
                case "PHP":
                  tuVal = value;
//                  print(tuVal);
                  break;
                case "Mysql":
                  wedVal = value;
//                  print(wedVal);
                  break;
                case "Java":
                  thurVal = value;
                  print(thurVal);
                  break;
                case "Nosql":
                  friVal = value;
//                  print(friVal);
                  break;
                case "Java":
                  satVal = value;
                  break;
                case "Sun":
                  sunVal = value;
                  break;
              }
            });
          },
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
          title: Text('Update Your choise'),
          children: <Widget>[
            checkbox("NodeJs", monVal),
            checkbox("PHP", tuVal),
            checkbox("Mysql", wedVal),
            checkbox("Java", thurVal),
            checkbox("Nosql", friVal),
            Container(
              margin: EdgeInsets.all(35.0),
              height: 35.0,
              width: 35.0,
              child: FlatButton(
                textColor: Colors.white,
                color: Colors.blue,
                  onPressed: ()=>{},
                  child: Text('Update')),
            )
          ],
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
