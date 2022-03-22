import 'package:Mazaj/screens/collab/chat/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:group_chat_app/pages/chat_page.dart';

class GroupTile extends StatefulWidget {
  String userName;
  String admin;
  final String groupId;
  final String groupName;

  GroupTile(this.userName, this.admin, this.groupId, this.groupName);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('groups')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['groupName'].compareTo(widget.groupName) == 0) {
          // widget.admin = doc["admin"];
          //print("wgr ${widget.groupName}");
          setState(() {
            widget.admin = doc['admin'];
          });
        }
      });
    });

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      widget.groupId,
                      widget.admin,
                      widget.userName,
                      widget.groupName,
                    )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.amber,
            child: Text(widget.groupName.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white)),
          ),
          title: Text(widget.groupName,
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("Join the conversation as ${widget.userName}",
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700)),
        ),
      ),
    );
  }
}
