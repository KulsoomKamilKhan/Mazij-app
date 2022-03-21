import 'package:Mazaj/screens/collab/chat/pages/chat_page.dart';
import 'package:Mazaj/screens/collab/chat/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // data
  TextEditingController searchEditingController = new TextEditingController();
  //QuerySnapshot searchResultSnapshot = DatabaseService("").searchByName("");
  //dynamic searchResultSnapshot;
  bool isLoading = false;
  bool hasUserSearched = false;
  bool _isJoined = false;
  //String _userName = '';
  // FirebaseFirestore _user;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username = '';
  // initState()
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

  _initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      // await DatabaseService(_username)
      //     .searchByName(searchEditingController.text)
      //     .then((snapshot) {
      // searchResultSnapshot = snapshot;
     // print("here");
      //print("$searchResultSnapshot");
      setState(() {
        isLoading = false;
        hasUserSearched = true;
      });
      // });
    }
  }

  void _showScaffold(String message) {
    _scaffoldKey.currentState?.showSnackBar(SnackBar(
      backgroundColor: Colors.blueAccent,
      duration: const Duration(milliseconds: 1500),
      content: Text(message,
          textAlign: TextAlign.center, style: const TextStyle(fontSize: 17.0)),
    ));
  }

  _joinValueInGroup(
      String userName, String groupId, String groupName, String admin) async {
    bool value = await DatabaseService(_username)
        .isUserJoined(groupId, groupName, userName);
    setState(() {
      _isJoined = value;
    });
  }

  // widgets
  Widget groupList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("groups")
          .where('groupName', isEqualTo: searchEditingController.text)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // var data = snapshot.data;
       // print('search');
        //  print(data.documents.length);
        if (snapshot.hasData) {
          dynamic data = snapshot.data!.docs;

          return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return groupTile(
                  _username,
                  data[index].data()!["groupId"],
                  data[index].data()!["groupName"],
                  data[index].data()!["admin"],
                );
              });
        }
        // } else {
        return Container(child: const Center(child: CircularProgressIndicator()));
        //}
      },
    );
  }

  Widget groupTile(
      String userName, String groupId, String groupName, String admin) {
    _joinValueInGroup(userName, groupId, groupName, admin);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      leading: CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.amber,
          child: Text(groupName.substring(0, 1).toUpperCase(),
              style: const TextStyle(color: Colors.white))),
      title: InkWell(
        onTap: (){
          if (_isJoined) { //check this
           // Future.delayed(const Duration(milliseconds: 2000), () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ChatPage(groupId,admin, userName, groupName)));
            //}
            //);
          }
        },
      child: Text(groupName, style: const TextStyle(fontWeight: FontWeight.bold))),
      subtitle: Text("Admin: $admin"),
      trailing: InkWell(
        onTap: () async {
          await DatabaseService(_username)
              .togglingGroupJoin(groupId, groupName, userName);
          if (_isJoined) { 
            setState(() {
              _isJoined = !_isJoined;
            });
            // await DatabaseService(uid: _user.uid).userJoinGroup(groupId, groupName, userName);
            _showScaffold('Successfully joined the group "$groupName"');
            Future.delayed(const Duration(milliseconds: 1000), () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ChatPage(groupId, admin, userName, groupName)));
            });
          } else {
            setState(() {
              _isJoined = !_isJoined;
            });
            _showScaffold('Left the group "$groupName"');
          }
        },
        child: _isJoined
            ? Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color.fromARGB(95, 56, 52, 52),
                    border: Border.all(color: Colors.white, width: 1.0)),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: const Text('Joined', style: const TextStyle(color: Colors.white)),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueAccent,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: const Text('Join', style: const TextStyle(color: Colors.white)),
              ),
      ),
    );
  }

  // building the search page widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.purple.shade300,
        title: const Text('Search Rooms',
            style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      body: // isLoading ? Container(
          //   child: Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // )
          // :
          Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              // color: Colors.amber.shade100,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: searchEditingController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        // decoration: InputDecoration(
                        //     hintText: "Search Rooms",
                        //     hintStyle: TextStyle(
                        //       color: Colors.white38,
                        //       fontSize: 16,
                        //     ),
                        //     border: InputBorder.none),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.purple),
                            borderRadius: BorderRadius.circular(85),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(85),
                          ),
                        )),
                  ),
                  GestureDetector(
                      onTap: () {
                        searchEditingController.clear;
                        _initiateSearch();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                          child: const Icon(Icons.search, color: Colors.blueAccent)))
                ],
              ),
            ),
            isLoading
                ? Container(child: const Center(child: CircularProgressIndicator()))
                : groupList()
          ],
        ),
      ),
    );
  }
}
