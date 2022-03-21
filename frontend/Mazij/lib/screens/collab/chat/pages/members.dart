import 'package:Mazaj/screens/collab/chat/pages/chat_page.dart';
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

  @override
  void initState() {
    _getCurrentUserNameAndUid();
    super.initState();
  }

  var storage = const FlutterSecureStorage();
  // functions
  _getCurrentUserNameAndUid() async {
    _username = (await storage.read(key: 'username')).toString();
    if (mounted) setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
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
                          if(data.data()!["admin"].compareTo(widget.admin)==0){
                            return ListTile(
                            title: Text(data.data()!["members"][index]),
                            trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){
                              DatabaseService(_username).DeleteMember(widget.groupId, data.data()!["groupName"], data.data()!["members"][index]);
                            }),
                          );
                          }
                          return ListTile(
                            title: Text(data.data()!["members"][index]),
                          );
                          
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
