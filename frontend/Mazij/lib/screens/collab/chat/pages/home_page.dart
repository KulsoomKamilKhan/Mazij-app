import 'package:Mazaj/screens/collab/chat/pages/search_page.dart';
import 'package:Mazaj/screens/collab/chat/services/database_service.dart';
import 'package:Mazaj/screens/collab/chat/widgets/group_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // data
  String _groupName = '';
  //String _userName = '';
  String _email = '';
  dynamic _groups; // Stream _groups
  String _username = '';
  // initState
  @override
  void initState() {
    super.initState();
    _getUserAuthAndJoinedGroups();
  }

  // widgets
  Widget noGroupWidget() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  _popupDialog(context);
                },
                child: Icon(Icons.add_circle,
                    color: Colors.grey[700], size: 75.0)),
            SizedBox(height: 20.0),
            Text(
                "You've not joined any group, tap on the 'add' icon to create a group or search for groups by tapping on the search button below."),
          ],
        ));
  }

  Widget groupsList() {
    return StreamBuilder(
      stream: _groups,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          dynamic data = snapshot.data!;
          print(data['groups'].length);
          if (data['groups'] != null) {
            print(data['groups'].length);
            if (data['groups'].length != 0) {
              return ListView.builder(
                  itemCount: data['groups'].length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    int reqIndex = data['groups'].length - index - 1;
                    print('groupList');
                    return GroupTile(
                        data['fullName'],
                        _destructureId(data['groups'][reqIndex]),
                        _destructureName(data['groups'][reqIndex]));
                  });
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  var storage = const FlutterSecureStorage();
  // functions

  _getUserAuthAndJoinedGroups() async {
    //Future.delayed(Duration.zero, () async {
    _username = (await storage.read(key: 'username')).toString();
    print('we are in home page');
    print(_username);
    // if (mounted) setState(() {});
    // });
    //super.initState();
    setState(() {});
    DatabaseService(_username).getUserGroups().then((snapshots) {
      print(_username);

      setState(() {
        _groups = snapshots;
      });
    });
    //super.initState();
  }

  String _destructureId(String res) {
    // print(res.substring(0, res.indexOf('_')));
    return res.substring(0, res.indexOf('_'));
  }

  String _destructureName(String res) {
    // print(res.substring(res.indexOf('_') + 1));
    return res.substring(res.indexOf('_') + 1);
  }

  void _popupDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget createButton = FlatButton(
      child: Text("Create"),
      onPressed: () async {
        if (_groupName != null) {
          //await HelperFunctions.getUserNameSharedPreference().then((val) {
          DatabaseService(_username).createGroup(_username, _groupName);
          //});
          Navigator.of(context).pop();
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Create a group"),
      content: TextField(
          onChanged: (val) {
            _groupName = val;
          },
          style: TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black)),
      actions: [
        cancelButton,
        createButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // Building the HomePage widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Groups',
            style: TextStyle(
                color: Colors.white,
                fontSize: 27.0,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black87,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              icon: Icon(Icons.search, color: Colors.white, size: 25.0),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchPage()));
              })
        ],
      ),
      body: groupsList(),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn2",
        onPressed: () {
          _popupDialog(context);
        },
        child: Icon(Icons.add, color: Colors.white, size: 30.0),
        backgroundColor: Colors.grey[700],
        elevation: 0.0,
      ),
    );
  }
}
