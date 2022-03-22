import 'package:Mazaj/screens/collab/chat/pages/members.dart';
import 'package:Mazaj/screens/collab/chat/services/database_service.dart';
import 'package:Mazaj/screens/collab/chat/widgets/message_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatPage extends StatefulWidget {
  String groupId = '';
  String admin = '';
  String _username = '';
  String groupName = '';

  ChatPage(this.groupId,this.admin, this._username, this.groupName);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //Stream<QuerySnapshot>? _chats;
  TextEditingController messageEditingController = new TextEditingController();

  Widget _chatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('groups')
          .doc(widget.groupId)
          .collection('messages')
          .orderBy('time')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // var data = snapshot.data;

        //  print(data.documents.length);
        if (snapshot.hasData) {
          dynamic data = snapshot.data!.docs;

          return ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return MessageTile(
                  // data.documents[index].data["message"],
                  data[index].data()!["message"],
                  //data.documents[index].data["sender"],
                  data[index].data()!["sender"],
                  widget._username == data[index].data()!["sender"],
                  //data.documents[index].data["sender"],
                );
              });
        }
        // } else {
        return Container();
        //}
      },
    );
  }

  _sendMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageEditingController.text,
        "sender": widget._username,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService(widget._username)
          .sendMessage(widget.groupId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  var storage = const FlutterSecureStorage();
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      widget._username = (await storage.read(key: 'username')).toString();
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.purple.shade300,
        elevation: 0.0,
        actions: [
          IconButton(onPressed: (){
            print("in chat");
            print(widget.admin);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MembersPage(widget.groupId, widget.admin)));
          } , 
          icon: Icon(Icons.people))

        ],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            _chatMessages(),
            // Container(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                //color: Colors.grey[700],
                child: Row(
                  children: <Widget>[
                    SizedBox(height: 20,),
                    Expanded(
                      child: TextField(
                        
                          controller: messageEditingController,
                          style: TextStyle(color: Colors.black),
                          // decoration: InputDecoration(
                          //     hintText: "Send a message ...",
                          //     hintStyle: TextStyle(
                          //       color: Colors.white38,
                          //       fontSize: 16,
                          //     ),
                          //   border: InputBorder.none),
                          decoration: InputDecoration(
                            hintText: "Send a message ...",
                            hintStyle: TextStyle(
                              color: Colors.black54,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.purple),
                              borderRadius: BorderRadius.circular(85),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(85),
                            ),
                          )),
                    ),
                    SizedBox(width: 12.0),
                    GestureDetector(
                      onTap: () {
                        _sendMessage();
                      },
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                            child: Icon(Icons.send, color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
