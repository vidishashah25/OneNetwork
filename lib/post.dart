import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  String _text='';
  
  void onPressed(){
    print(_controller.text);
  }

  void onChanged(String value){
    setState(() {
     _text = value; 
    });
  }

  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
      ),
      body: SingleChildScrollView(
          child: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Center(
              child: new Column(
                children: <Widget>[
                  new TextField(
                    onChanged: (String value){
                      onChanged(value);
                    },
                    controller: _controller,
                    maxLines: 1,
                    autocorrect: true,
                    autofocus: true,
                    decoration: new InputDecoration(
                      icon: Icon(Icons.edit),
                      hintText: 'Start Typing here....',
                      labelText: 'Project Name:' 
                    ),
                  ),
                  new TextField(
                    onChanged: (String value){
                      onChanged(value);
                      },
                      controller: _controller,
                      maxLines: 3,
                      autocorrect: true,
                      decoration: new InputDecoration(
                        icon: Icon(Icons.edit),
                        hintText: 'Start Typing here....',
                        labelText: 'Project Description:'
                      ),
                  ),
                  new RaisedButton(
                    child: new Text("Post"),
                    onPressed: (){
                      onPressed();
                    },
                  )
                ],
              ),
            ),
          ),
      ),
    );
  }
}