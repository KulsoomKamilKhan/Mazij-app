import 'dart:convert';

import 'package:Mazaj/data/repositories/profile_repo.dart';
import 'package:Mazaj/data/repositories/user_repo.dart';
import 'package:Mazaj/screens/collab/chat/pages/chat_page.dart';
import 'package:Mazaj/screens/collab/chat/pages/userprofilem.dart';
import 'package:Mazaj/screens/collab/chat/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MembersPage extends StatefulWidget {
  String groupId = '';
  String admin = '';

  MembersPage(this.groupId, this.admin, {Key? key}) : super(key: key);
  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<MembersPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _username = '';
  final ProfileRepository _profRepository = ProfileRepository();
  final UserRepository _userRepository = UserRepository();
  List<dynamic> profiles = [];
  List<String> unames = [];
  var storage = const FlutterSecureStorage();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      profiles = await _profRepository.getProfiles();
      unames = await _userRepository.GetUsernames();
      _username = (await storage.read(key: 'username')).toString();
      if (mounted) setState(() {});
    });
    super.initState();
  }

  dynamic _profilepic(String username) {
    int i = 0;
    String dp = '';
    while (i < profiles.length) {
      if (profiles[i].username.compareTo(username) == 0) {
        dp = profiles[i].profile_pic;
      }
      i++;
    }
    var s = const Base64Decoder().convert(dp);
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.purple.shade300,
          title: const Text('Members',
              style: TextStyle(
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(height:5),
              Expanded(
                  child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('groups')
                    .doc(widget.groupId)
                    // .collection('messages')
                    // .orderBy('time')
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  // var data = snapshot.data;

                  //  print(data.documents.length);
                  if (snapshot.hasData) {
                    dynamic data = snapshot.data!;

                    return ListView.builder(
                        itemCount: data.data()!["members"].length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // print(data.data()!["admin"]);
                          // print("in members");
                          // print(widget.admin);
                          // print(_username);
                          if ((_username.compareTo(widget.admin) == 0) && (unames.contains(data.data()!["members"][index]))) {
                            return InkWell(
                              child:ListTile(
                                contentPadding: EdgeInsets.symmetric(vertical: 3),
                              leading: CircleAvatar(
                                backgroundImage: Image.memory(
                                  _profilepic(data.data()!["members"][index]),
                                ).image,
                                radius: 55.0,
                              ),
                              title: Text(data.data()!["members"][index]),
                              trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.black,),
                                  onPressed: () {
                                    DatabaseService(_username).DeleteMember(
                                        widget.groupId,
                                        data.data()!["groupName"],
                                        data.data()!["members"][index]);
                                  }),
                            ),
                            onTap: () {
                                  //print("member tapped admin");
                                  String s = data
                                          .data()!["members"][index]
                                          .toString()
                                          .trim();
                                  if(s.compareTo(_username)!=0){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserProfileM(s),
                                    ),
                                  );
                                  }
                                  else{Navigator.of(context).pushNamed("/home");}
                            });
                          }
                          //print("in mem print");
                          //print(data.data()!["members"][index].runtimeType);
                          else if (unames.contains(data.data()!["members"][index])){
                          return InkWell(
                              child: ListTile(
                                 contentPadding: EdgeInsets.symmetric(vertical: 3),
                            leading: CircleAvatar(
                              backgroundImage: Image.memory(
                                _profilepic(data.data()!["members"][index]),
                              ).image,
                              radius: 55.0,
                            ),
                            title: Text(data.data()!["members"][index]),
                          ),
                          onTap: () {
                            
                            String s = data
                                          .data()!["members"][index]
                                          .toString()
                                          .trim();
                                  //print("member tapped");
                            if(s.compareTo(_username)!=0){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserProfileM(s),
                                    ),
                                  );
                            }  else{Navigator.of(context).pushNamed("/home");}
                          }
                          );}
                          return ListTile();
                        });
                  }
                  // } else {
                  return Container();
                  //}
                },
              ))
            ],
          ),
        ));
  }
}
