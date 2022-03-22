import 'package:Mazaj/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:Mazaj/data/models/library_model.dart';
import 'package:Mazaj/data/models/statistics_model.dart';
import 'package:Mazaj/data/models/user_model.dart';
import 'package:Mazaj/data/repositories/statistics_repo.dart';
import 'package:Mazaj/data/repositories/user_repo.dart';
import 'package:Mazaj/data/repositories/post_repo.dart';
import 'package:Mazaj/screens/admin_panel/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'header.dart';
import 'users_table.dart';
import 'posts_table.dart';
import 'responsive.dart';

const defaultPadding = 16.0;
const pageColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final UserRepository _userRepository = UserRepository();
  final PostRepository _postRepository = PostRepository();
  final StatisticsRepository _statisticsRepository = StatisticsRepository();
  List<User> users = [];
  List<Library> posts = [];
  //List<Statistics>? stats;

  var stats = Statistics(users: 0, posts: 0, total_upvotes: 0, max_upvotes: 0);

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      stats = await _statisticsRepository.GetStats();
      users = await _userRepository.GetUsers();
      users.removeWhere((element) =>
          (element.email.compareTo("hwumazij@gmail.com") == 0) &&
          (element.username.compareTo("hwumazijadmin48") == 0));
      posts = await _postRepository.GetPosts();
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
            child: Container(
      color: bgColor,
      height: 500,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Align(
              alignment:
                  Alignment.topRight, // align to the top left of the page
              child: IconButton(
                icon: const Icon(Icons.logout_rounded),
                color: const Color.fromARGB(255, 255, 255, 255),
                iconSize: 30,
                tooltip: 'Logout',
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
              ),
            ),
            const Header(),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  // flex: 5,
                  child: Column(
                    children: [
                      UsersTable(users, posts),
                      SizedBox(
                        height: 50,
                      ),
                      Center(child: Stats(stats)), //or try padding
                      if (Responsive.isMobile(context))
                        const SizedBox(height: defaultPadding),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    )));
  }
}
