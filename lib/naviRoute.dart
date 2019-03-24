import 'package:flutter/material.dart';

class op extends StatelessWidget {

  final String mtxt;

  op(this.mtxt);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(mtxt)),
      body: new Center(
        child: new Text(mtxt),
      ),
    );
  }
}
