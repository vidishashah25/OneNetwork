import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

int _selected = 0;

onChanged(int value){
setState(() {
 _selected = value; 
});

print('value = $value');
}


List<Widget> makeRadio(){
  List<Widget> list = new List<Widget>();

  for(int i=0; i<3; i++){
    list.add(new Row(
    children: <Widget>[
      new Text('radio $i'),
      new Radio(value: i, groupValue: _selected, onChanged: (int value){onChanged(value);},)
    ],
  ));
  
  }
  return list;
}

final _formKey = GlobalKey<FormState>();
final _pd = ProjectData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.done)
          ),
        ],
      ),
      body: SingleChildScrollView(
            child: Container(
            padding: 
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
              builder: (context) => Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
//Project Title
                    TextFormField(
                      decoration: 
                      InputDecoration(labelText: 'Project Title'),
                        autocorrect: true,
                        autofocus: true,
                        validator: (value){
                          if(value.isEmpty){
                            return 'Please enter your Project Title';
                          }
                        },
                        onSaved: (val) => setState(() => _pd.name = val),
                    ),
//Project Description
                    TextFormField(
                      decoration: 
                      InputDecoration(labelText: 'Project Description',),
                        autocorrect: true,
                        autofocus: true,
                        maxLines: 3,
                        validator: (value){
                          if(value.isEmpty){
                            return 'Please enter your Project Description';
                          }
                        },
                        onSaved: (val) => setState(() => _pd.description = val) ,
                    ),
//Project Technology
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                      child: Text('Technology',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman'
                        ),
                      ),
                    ),
                    CheckboxListTile(
                      title: const Text('PHP'),
                      value: _pd.technology[ProjectData.Php],
                      onChanged: (val){
                        setState(() {
                        _pd.technology[ProjectData.Php] = val;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Java'),
                      value: _pd.technology[ProjectData.Java],
                      onChanged: (val){
                        setState(() {
                        _pd.technology[ProjectData.Java] = val;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('AI'),
                      value: _pd.technology[ProjectData.Ai],
                      onChanged: (val){
                        setState(() {
                        _pd.technology[ProjectData.Ai] = val;
                        });
                      },
                    ),
//radio button  
                    Container(
                      padding: new EdgeInsets.fromLTRB(3, 20, 20, 20),
                      child: Text('Project Type',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman',
                        color: Colors.blue,

                      ),
                      ),
                    ),
                    Container(
                      padding: new EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Center(
                        child: Column(
                          children: makeRadio(),
                        ),
                      ),
                  ),
//Submit button                    
                    Container(
                     padding: const EdgeInsets.symmetric(
                       vertical: 16.0, horizontal: 16.0
                     ),
                     child: RaisedButton(
                       onPressed: (){
                         final form = _formKey.currentState;
                         if(form.validate()){
                           form.save();
                           _pd.save();
                           _showDialog(context);
                         } 
                       },
                       padding: const EdgeInsets.all(8.0),
                       child: Text('Add Post',
                       style: TextStyle(
                         color:Colors.white,
                         fontSize: 20,
                       ),
                       ),
                       color:Colors.blue,
                     )
                    ),

                  
                  ],
                ),
              ),
            ),
          ),
        
      ),
    );
  }
  _showDialog(BuildContext context){
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('New Post Added')));
  }
}


class ProjectData {
  static const String Php = 'php';
  static const String Java = 'java';
  static const String Ai = 'ai';

  String name = '';
  String description = '';

  Map<String, bool> technology = {
    Php : false,
    Java : false,
    Ai : false,
  };

  save(){
    print('Project Details Added');
  }

}



// {
//     "error": "false",
//     "message": "success",
//     "interests": [
//         {
//             "category_id": "1",
//             "category_name": "languages",
//             "error": "false",
//             "message": "success",
//             "interests_array": [
//                 {
//                     "id": "6",
//                     "name": "java",
//                     "category": "1"
//                 },
//                 {
//                     "id": "7",
//                     "name": "php",
//                     "category": "1"
//                 },
//                 {
//                     "id": "8",
//                     "name": "mysql",
//                     "category": "1"
//                 }
//             ]
//         },
//         {
//             "category_id": "2",
//             "category_name": "technologies",
//             "error": "false",
//             "message": "success",
//             "interests_array": [
//                 {
//                     "id": "6",
//                     "name": "java",
//                     "category": "1"
//                 },
//                 {
//                     "id": "7",
//                     "name": "php",
//                     "category": "1"
//                 },
//                 {
//                     "id": "8",
//                     "name": "mysql",
//                     "category": "1"
//                 },
//                 {
//                     "id": "9",
//                     "name": "Artificial intelligence",
//                     "category": "2"
//                 },
//                 {
//                     "id": "10",
//                     "name": "Image processing",
//                     "category": "2"
//                 }
//             ]
//         }
//     ]
// }