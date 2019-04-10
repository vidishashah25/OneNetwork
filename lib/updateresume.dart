import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
class UpdateResume extends StatefulWidget {
  @override
  _UpdateResumeState createState() => _UpdateResumeState();
}

class _UpdateResumeState extends State<UpdateResume> {


  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Text('Update Ressume',textAlign: TextAlign.center,),
        children: <Widget>[
          Container(
            height: 35.0,
            width: 35.0,
            margin: EdgeInsets.only(left: 65.0,right: 65.0),
            color: Colors.blue,
            child: FlatButton(
                onPressed: ()=>_getFile(),
                child: Text('Upload',style: TextStyle(color: Colors.white),),
            ),
          ),
          FlatButton(
          onPressed: ()=>
          Navigator.of(context).pop(),

          child: Text('Ok'),
          ),
        ],
    );
  }
}

_getFile() async {

  File file = await FilePicker.getFile(type: FileType.CUSTOM,fileExtension:'pdf'); // will return a File object directly from the selected file

}
