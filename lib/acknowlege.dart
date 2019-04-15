import 'package:flutter/material.dart';

class Acknowledge extends StatefulWidget {
  String project_id;
  Acknowledge(project_id);
  @override
  _AcknowledgeState createState() => _AcknowledgeState();
}

class _AcknowledgeState extends State<Acknowledge> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

class ProjectDetails {
  final String id;
  final String title;
  final String description;
  final String creator_id;
  final String mentor;
  final String interest_str;
  final String creator_name;
  final String applied_username;
  final String applied_userid;

  // final Address address;

  ProjectDetails(this.id, this.title, this.description, this.creator_id, this.mentor, this.interest_str, this.creator_name,this.applied_userid, this.applied_username);
}