import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/changeuserprofile.dart';
import 'package:login_page/updateresume.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserProfile extends StatefulWidget {
  var studentid;
  UserProfile(this.studentid);
  @override
  _UserProfileState createState() => _UserProfileState(studentid);
}
class _UserProfileState extends State<UserProfile> {

  String name;
  String uid;
  _UserProfileState(this.uid);
  String lastname;
  var userprofile = null;
  var resumelink=null;



  SharedPreferences prefs;


  void initState() {
    getusername();

    print(uid);
  }


  void _downloadResume()  async
  {
    print(resumelink);
    Dio dio =new Dio();
    final directory = await Directory.systemTemp.createTemp();Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    var response = await dio.download(resumelink,directory);
    print(response.toString());
  }

  Widget_getImage(){
    if (userprofile == null) {
      return Container  (
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
      return Stack(
        children: <Widget>[
          Container(
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

          ),
          GestureDetector(
            onTap: ()=>_showImagePicker(context,ImageSource.gallery),
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(75.0),),
                  border: new Border.all(color: Colors.white)
              ),
              margin: EdgeInsets.only(left: 110.0,top: 120.0),
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Icon(Icons.add,color: Colors.white,size: 20.0,),
              ),

            ),
          ),
        ],

      );
    }
  }

  Future<String> getusername() async {
//    var url = await http.get("https://api.github.com/users/vishweshsoni");
//    var responseJson = json.decode(url.body);
//    var name1 = responseJson['login'];
//    var image = responseJson['avatar_url'];
    Dio dio= new Dio();
    final response = await dio.get("http://onenetwork.ddns.net/api/get_user_details.php?userid=$uid");
    String ans = response.toString();
    print(ans);
    var responseJson = jsonDecode(ans);
    var name1= responseJson['user_details']['firstname'];
    var name2= responseJson['user_details']['lastname'];
    var image = responseJson['user_details']['profile_pic'];
    var id= responseJson['user_details']['id'];
    var resume1= responseJson['user_details']['resume'];
    setState(() {

      name = name1;
      lastname= name2;
      userprofile = image;
      uid= id;
      resumelink = resume1;
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
            top: MediaQuery.of(context).size.height/13,
            left: MediaQuery.of(context).size.width/26,
            child: Column(

              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  alignment: FractionalOffset.topLeft,
                  child: GestureDetector(
                    onTap: (){Navigator.pop(context);},
                    child: Icon(Icons.arrow_back,color: Colors.white,size: 30.0,),
                  ),
                ),
                Widget_getImage(),
                SizedBox(height: 5.0),
                Text(
                  '$name $lastname',
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
                            Text('$uid'),
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
                            Text('$uid@daiict.ac.in'),

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
                                  onTap: () {
                                    showAlertDialog(context);
                                  }
                              ),
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
                            GestureDetector(
                              onTap: (){
                              _downloadResume();
                              },
                              child: Material(
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
                            ),
                            SizedBox(width: 59.0),
                            Container(
                                child:GestureDetector(
                                  child: Icon(Icons.edit),
                                  onTap: ()=>
                                      showAlertDialog1(context),

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




  void _showImagePicker(BuildContext context,ImageSource source){
    ImagePicker.pickImage(source: source).then((_image) async {
      Dio dio = new Dio();
      print(_image);
      FormData formData = new FormData();
      formData.add("file1",
          UploadFileInfo(_image, _image.path));
      final response = await dio.post(
          'http://onenetwork.ddns.net/api/user_profile_update_image.php?userid=201812017',
          data: formData);
      var re = jsonDecode(response.toString());
      var results= re["error"];

//
//      var result;
//      String path= _image.path;
//      var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));
//      var length = await _image.length();
//      var uri = Uri.parse('http://onenetwork.ddns.net/api/user_profile_update_image.php?userid=201812017');
//      var request = new http.MultipartRequest("POST", uri);
//      var multipartFile = new http.MultipartFile('file1',stream, length, filename: path);
//      request.files.add(multipartFile);
//      var response = await request.send();
//
//      print(" ===================response code ${response.statusCode}");
//      await response.stream.transform(utf8.decoder).listen((value) {
//        print(" =====================response value $value");
//        result = value;
//      });

      if (_image != null && results=="false")
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => UserProfile(uid)));
    }).catchError((err) => print(err));

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
      builder: (BuildContext context)=>UpdateResume(uid),
    );
  }


}




//This refers to the Intrest Field Dialog
class MySelection extends StatefulWidget {
  @override
  _MySelectionState createState() => _MySelectionState();
}





class _MySelectionState extends State<MySelection> {


  SharedPreferences prefs;
  var userid;
  int i;
  List<String> interest_arr =  new List();
  bool java = false;
  bool php = false;
  bool mysql = false;
  bool ai = false;
  bool ip = false;

  getuserdata() async {
    prefs = await SharedPreferences.getInstance();
    userid = prefs.getString("userid");
  }

  @override
  void initState() {
    // TODO: implement initState
    getuserdata();
  }
  void _getInterest() async {
    Dio dio = new Dio();
    String url1 = "http://onenetwork.ddns.net/api/update_interests.php?userid=$userid";
    //
    print(interest_arr.length);
    for(int i=0;i<interest_arr.length;i++)
    {
      print("hello");
      //url=url+"&arr[$i]="+interest_arr[i];
      url1=url1+"&arr[$i]="+interest_arr[i];
    }
    print(url1);
    url1= Uri.encodeFull(url1);
    final response = await dio.get(url1);
    String ans = response.toString();
    print(ans);
    var responseJson = jsonDecode(ans);
    var result = responseJson["error"];
    print(result);
    if(result=="false")
    {
      Navigator.pop(context);
    }
  }


  void onChanged(bool value, String title) {
    setState(() {
      switch(title)
      {
        case "Java":
          java = value;
          break;
        case "PHP":
          php = value;
          break;
        case "MySQL":
          mysql = value;
          break;
        case "AI":
          ai = value;
          break;
        case "ImageProcessing":
          ip = value;
          break;
      }
    });
  }
  Widget checkbox(String title, bool boolValue)
  {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Text(title),
                Checkbox(
                  value: boolValue,
                  onChanged: (bool value) {
                    onChanged(value, title);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Update Your choise'),
      children: <Widget>[
        Column(
          children: <Widget>[

            Column(
              children: <Widget>[
                checkbox("Java", java),
                checkbox("PHP", php),
                checkbox("MySQL", mysql),
                checkbox("AI", ai),
                checkbox("ImageProcessing", ip),
              ],
            ),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () {
                if(java==true)
                {
                  print(java);
                  interest_arr.add("6");
                }
                if(php==true)
                {
                  interest_arr.add("7");
                }
                if(mysql==true)
                {
                  interest_arr.add("8");
                }
                if(ai==true)
                {
                  interest_arr.add("9");
                }
                if(ip==true)
                {
                  interest_arr.add("10");
                }
                print(interest_arr);
                _getInterest();
              },
              child: Text('Update',textAlign: TextAlign.center,),


            ),
          ],

        ),
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

