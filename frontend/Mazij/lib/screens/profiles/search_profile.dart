import 'dart:convert';

import 'package:Mazaj/data/models/profile_model.dart';
import 'package:Mazaj/data/models/user_model.dart';
import 'package:Mazaj/data/repositories/profile_repo.dart';
import 'package:Mazaj/data/repositories/user_repo.dart';
import 'package:Mazaj/screens/library/userprofile.dart';
import 'package:Mazaj/screens/profiles/user_profile_search.dart';
import 'package:Mazaj/screens/search/userprofilesearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SearchProfile extends StatefulWidget {
  const SearchProfile({Key? key}) : super(key: key);

  @override
  State<SearchProfile> createState() => _SearchProfileState();
}

class _SearchProfileState extends State<SearchProfile> {
  final UserRepository _userRepository = UserRepository();
  final ProfileRepository _profRepository = ProfileRepository();

  var storage = const FlutterSecureStorage();
  List<User> users = [];
  List<User> _foundUsers = [];
  List<dynamic> profiles = [];
  String username = '';

  @override
  initState() {
    // at the beginning, all users are shown
    Future.delayed(Duration.zero, () async {
      users = await _userRepository.GetUsers();
      users.removeWhere((element) =>
          (element.email.compareTo("hwumazij@gmail.com") == 0) &&
          (element.username.compareTo("hwumazijadmin48") == 0));
      profiles = await _profRepository.getProfiles();
      username = (await storage.read(key: 'username')).toString();
      users.removeWhere((element) => element.username.compareTo(username) == 0);
      _foundUsers = users;
      print(users.length);
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
    var s = Base64Decoder().convert(dp);
    return s;
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<User> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = users;
      print("if filter length");
      print(results.length);
    } else {
      results = users
          .where((user) => (user.username
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user.first_name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user.last_name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase())))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.cancel_outlined),
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          },
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Search Users',
            style: TextStyle(
                color: Colors.purple,
                fontSize: 32,
                fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(85),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(85),
                  ),
                  suffixIcon: const Icon(Icons.search)),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
                child:
                    //_foundUsers.isNotEmpty?
                    _foundUsers.isEmpty
                        ? ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) => Card(
                                  key: ValueKey(users[index].username),
                                  //color: Colors.amberAccent,
                                  elevation: 4,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    width: 100,
                                    child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: Image.memory(
                                            _profilepic(users[index].username),
                                          ).image,
                                          radius: 35.0,
                                        ),
                                        title: Text(
                                            users[index].username.toString()),
                                        subtitle: Text(
                                          "${users[index].first_name} ${users[index].last_name}",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        onTap: () {
                                          if (users[index]
                                                  .username
                                                  .compareTo(username) ==
                                              0) {
                                            Navigator.of(context)
                                                .pushNamed('/home');
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UserProfileSP(
                                                        users[index]
                                                            .username),
                                              ),
                                            );
                                          }
                                        }),
                                  ),
                                ))
                        : ListView.builder(
                            itemCount: _foundUsers.length,
                            itemBuilder: (context, index) => Card(
                                  key: ValueKey(_foundUsers[index].username),
                                  //color: Colors.amberAccent,
                                  elevation: 4,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    width: 100,
                                    child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: Image.memory(
                                            _profilepic(
                                                _foundUsers[index].username),
                                          ).image,
                                          radius: 35.0,
                                        ),
                                        title: Text(_foundUsers[index]
                                            .username
                                            .toString()),
                                        subtitle: Text(
                                          "${_foundUsers[index].first_name} ${_foundUsers[index].last_name}",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        onTap: () {
                                          if (_foundUsers[index]
                                                  .username
                                                  .compareTo(username) ==
                                              0) {
                                            Navigator.of(context)
                                                .pushNamed('/home');
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UserProfileSP(
                                                            _foundUsers[index]
                                                                .username),
                                              ),
                                            );
                                          }
                                        }),
                                  ),
                                ))),
          ],
        ),
      ),
    );
  }
}
