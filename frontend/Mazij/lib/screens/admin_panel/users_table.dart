import 'package:Mazaj/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:Mazaj/data/models/library_model.dart';
import 'package:Mazaj/data/models/post_model.dart';
import 'package:Mazaj/data/models/user_model.dart';
import 'package:Mazaj/data/repositories/post_repo.dart';
import 'package:Mazaj/screens/admin_panel/posts_table.dart';
import 'package:Mazaj/screens/admin_panel/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const defaultPadding = 16.0;
const boxColor = Color(0xFF2A2D3E);

class UsersTable extends StatefulWidget {
  List<User> users;
  List<Library> posts;
  UsersTable(
    this.users,
    this.posts, {
    Key? key,
  }) : super(key: key);

  @override
  State<UsersTable> createState() => _UsersTableState();
}

class _UsersTableState extends State<UsersTable> {
  List<User> _foundUsers = [];

  @override
  initState() {
    // at the beginning, all users are shown
    Future.delayed(Duration.zero, () async {
      _foundUsers = widget.users;
      print(_foundUsers.length);
      if (mounted) setState(() {});
    });
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<User> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = widget.users;
      print("if filter length");
      print(results.length);
    } else {
      results = widget.users
          .where((user) => user.username
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  Widget body(BuildContext context, List<User> users, List<Library> posts) {
    return SafeArea(
        child: Material(
            child: Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
              alignment: Alignment.center,
              child: Text(
                "Active Users",
                //style: Theme.of(context).textTheme.subtitle1,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    decoration: TextDecoration.none),
              )),
          const SizedBox(
            height: 30,
          ),
          TextField(
            style: const TextStyle(color: Colors.white),
            onChanged: (value) => _runFilter(value),
            decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.white38),
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
                suffixIconColor: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          // SizedBox(
          //width: double.infinity,
          // child: SingleChildScrollView(
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 750,
              child: DataTable(
                  border: TableBorder(
                      left: BorderSide(color: Colors.white, width: 1),
                      right: BorderSide(color: Colors.white, width: 1)),
                  columnSpacing: 7,
                  columns: const [
                    DataColumn(
                      label: Text(
                        "Username",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Email ID",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Account\nType",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Delete\nUser",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "View\nPosts",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  rows: _foundUsers.isEmpty
                      ? users
                          .map(
                            (user) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(user.username,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: Colors.white))),
                                DataCell(Text(user.email,
                                    style:
                                        const TextStyle(color: Colors.white))),
                                DataCell(Text(user.account_type,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: Colors.white))),
                                DataCell(
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.purple,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      shadowColor: Colors.grey,
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<AuthenticationBloc>(
                                              context)
                                          .add(DeleteUser(
                                              username: user.username));
                                    },
                                    child: const Text('X'),
                                  ),
                                ),
                                DataCell(
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.purple,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      shadowColor: Colors.grey,
                                    ),
                                    onPressed: () {
                                      List<Library> po = [];
                                      int i = 0;
                                      while (i < posts.length) {
                                        if (posts[i]
                                                .user
                                                .compareTo(user.username) ==
                                            0) {
                                          po.add(posts[i]);
                                        }
                                        i++;
                                      }
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PostsTable(po),
                                        ),
                                      );
                                    },
                                    child: const Text('\u{1F441}'),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList()
                      : _foundUsers
                          .map(
                            (user) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(user.username,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: Colors.white))),
                                DataCell(Text(user.email,
                                    style:
                                        const TextStyle(color: Colors.white))),
                                DataCell(Text(user.account_type,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: Colors.white))),
                                DataCell(
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.purple,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      shadowColor: Colors.grey,
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<AuthenticationBloc>(
                                              context)
                                          .add(DeleteUser(
                                              username: user.username));
                                    },
                                    child: const Text('X'),
                                  ),
                                ),
                                DataCell(
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.purple,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      shadowColor: Colors.grey,
                                    ),
                                    onPressed: () {
                                      List<Library> po = [];
                                      int i = 0;
                                      while (i < posts.length) {
                                        if (posts[i]
                                                .user
                                                .compareTo(user.username) ==
                                            0) {
                                          po.add(posts[i]);
                                        }
                                        i++;
                                      }
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PostsTable(po),
                                        ),
                                      );
                                    },
                                    child: const Text('\u{1F441}'),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList()),
            ),
          ),
          // ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    )
            //)
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
      if (state is AccountDeleted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/admin', (route) => false);
      }
    }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationWait) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AuthenicationError) {}
        return body(context, widget.users, widget.posts);
      },
    )));
  }
}
