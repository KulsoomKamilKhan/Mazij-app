import 'package:Mazaj/screens/collab/chat/pages/chat_page.dart';
import 'package:flutter/material.dart';
//import 'package:group_chat_app/pages/chat_page.dart';

class GroupTile extends StatelessWidget {
  String userName;
  final String admin;
  final String groupId;
  final String groupName;

  GroupTile(this.userName, this.admin, this.groupId, this.groupName);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      groupId,
                      admin,
                      userName,
                      groupName,
                    )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.amber,
            child: Text(groupName.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white)),
          ),
          title: Text(groupName, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("Join the conversation as $userName",
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700)),
        ),
      ),
    );
  }
}
