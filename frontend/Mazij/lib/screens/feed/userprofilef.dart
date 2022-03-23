import 'dart:convert'; // for base46 encoding
import 'dart:typed_data'; // for unsigned 8 byte integers' list
import 'package:Mazaj/bloc/post_bloc/post_bloc.dart';
import 'package:Mazaj/data/models/follow_model.dart';
import 'package:Mazaj/data/models/post_model.dart';
import 'package:Mazaj/data/models/user_model.dart';
import 'package:Mazaj/data/models/profile_model.dart';
import 'package:Mazaj/data/repositories/follow_repo.dart';
import 'package:Mazaj/data/repositories/profile_repo.dart';
import 'package:Mazaj/data/repositories/user_repo.dart';
import 'package:Mazaj/screens/feed/userpostf.dart';
import 'package:Mazaj/screens/library/userpost.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:Mazaj/screens/posts/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:Mazaj/widgets/app_bar.dart';
import 'package:Mazaj/widgets/app_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class UserProfileF extends StatefulWidget {
  final String username;
  const UserProfileF(this.username, {Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfileF> {
  List<Post>? posts;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String _loggeduser = '';

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      _loggeduser = (await storage.read(key: 'username')).toString();
      //"in init delayed");
      loadPosts();
      if (mounted) setState(() {});
    });
    //loadPosts();
    //"init");
    super.initState();
  }

  loadPosts() async {
    //"load posts");
    //widget.username);
    BlocProvider.of<PostBloc>(context)
        .add(GetProfilePosts(user: widget.username));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: myAppBar(widget.username),
        ),
        drawer: const SettingsDrawer(),
        body: BlocListener<PostBloc, PostState>(
            listener: (context, state) {},
            child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
              if (state is PostLoading) {
                Path _buildSpeechBubblePath() {
                  return Path()
                    ..moveTo(50, 0)
                    ..quadraticBezierTo(0, 0, 0, 37.5)
                    ..quadraticBezierTo(0, 75, 25, 75)
                    ..quadraticBezierTo(25, 95, 5, 95)
                    ..quadraticBezierTo(35, 95, 40, 75)
                    ..quadraticBezierTo(100, 75, 100, 37.5)
                    ..quadraticBezierTo(100, 0, 50, 0)
                    ..close();
                }

                return Center(
                  child: //CircularProgressIndicator(),
                      LiquidCustomProgressIndicator(
                    direction: Axis.horizontal,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation(Colors.blue),
                    shapePath: _buildSpeechBubblePath(),
                  ),
                );
              } else if (state is PostLoaded) {
                //"post loaded");
                posts = state.posts;
                //"post len ${posts!.length}");
                return profilepage(posts!, widget.username, _loggeduser);
              } else if (state is PostError) {}
              return ProfileInfo(0, widget.username); // 0 posts
            })));
  }
}

Widget profilepage(List<Post> posts, String u, String _loggeduser) {
  // for posts
  return SafeArea(
      child: Column(children: [
    Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ProfileInfo(posts.length, u),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
            sliver: SliverGrid(
              // Creates a sliver that places multiple box children in a grid acc to delegate
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing:
                    15, // pixels between each child along the main axis
              ),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                // delegate for child for slivers
                Post postobj = posts[index];
                return Container(
                  padding: (index % 2 == 0 // gap from left or right to screen
                      ? const EdgeInsets.only(left: 20.0)
                      : const EdgeInsets.only(right: 20.0)),
                  child: UserPostF(postobj, _loggeduser),
                );
              }, childCount: posts.length),
            ),
          ),
        ],
      ),
    ),
  ]));
}

class ProfileInfo extends StatefulWidget {
  // for profile banner
  int length; // number of posts
  //String pg;
  String username;

  ProfileInfo(this.length, this.username, {Key? key}) : super(key: key);
  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final UserRepository _userRepository = UserRepository();
  final ProfileRepository _profileRepository = ProfileRepository();
  final FollowRepository _followRepository = FollowRepository();
  String _loggeduser = '';
  FlutterSecureStorage storage = const FlutterSecureStorage();

  var user = User(
      username: "",
      first_name: "",
      last_name: "",
      email: "",
      account_type: "",
      date_of_birth: "",
      passwords: "");

  var prof = Profile(username: "", bio: "", account_type: "", profile_pic: "");
  //Follow u = Follow(id: 0, followers: "", follows: "");
  bool pressed = false;
  Widget w = const Text("Follow");

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      _loggeduser = (await storage.read(key: 'username')).toString();
      var response = await _followRepository.getFollowsByUser(_loggeduser);
      user = await _userRepository.getUserByusername(widget.username);
      prof = await _profileRepository.getProfileByUsername(widget.username);
      int i = 0;
      while (i < response.length) {
        if (response[i].compareTo(user.username) == 0) {
          w = const Text("Following");
          pressed = true;
        }
        i++;
      }

      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _bytesImage = const Base64Decoder().convert(prof.profile_pic);
    ////u.toString());
    return Column(
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Align(
            alignment: Alignment.topLeft, // align to the top left of the page
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: const Color.fromRGBO(1, 1, 1, 1),
              iconSize: 25,
              tooltip: 'Back',
              onPressed: () {
                Navigator.of(context).pushNamed('/feed');
                //Navigator.of(context).pop();
              },
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.report_problem),
              color: const Color.fromRGBO(1, 1, 1, 1),
              iconSize: 25,
              tooltip: 'Report User',
              onPressed: () {
                //"user report");
                _userRepository.report(user.username, _loggeduser);
                //Navigator.of(context).pushNamed('/feed');
                //Navigator.of(context).pop();
                showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.of(context).pop(true);
                      });
                      return const AlertDialog(
                        backgroundColor: Colors.black87,
                        title: Text(
                          'This profile has been reported',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      );
                    });
              },
            ),
          ),
        ]),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 285,
          padding: const EdgeInsets.all(10),
          child: Center(
              // center all widgets
              child: Column(children: <Widget>[
            Container(
                // for profile pic
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: CircleAvatar(
                  backgroundImage: Image.memory(_bytesImage).image,
                  radius: 35.0,
                )),
            Text(user.first_name + ' ' + user.last_name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                )),
            Text(user.username,
                style: const TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w100,
                )),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Column(children: [
                // number of posts
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    shadowColor: Colors.grey,
                  ),
                  onPressed: () async {
                    //"button");
                    if (!pressed) {
                      //pressed);
                      var bool = await _followRepository.Create(
                          _loggeduser, user.username);
                      if (bool) {
                        setState(() {
                          w = const Text("Following");
                          pressed = true;
                        });
                        //pressed);
                      }
                    } else {
                      //pressed);
                      var bool = await _followRepository.Delete(
                          _loggeduser, user.username);
                      if (bool) {
                        //pressed = false;
                        setState(() {
                          w = const Text("Follow");
                          pressed = false;
                        });
                        //pressed);
                      }
                    }
                  },
                  child: w,
                  //!pressed ? const Text('Follow') : const Text("Following"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Posts',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600)),
                Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(widget.length.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black45,
                        ))),
              ]),
            ]),
            const SizedBox(
              height: 15,
            ),
            Container(
                alignment: Alignment.center,
                width: 500,
                child: Text("\"${prof.bio}\"",
                    style: const TextStyle(
                        //fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500))),
          ])),
          decoration: BoxDecoration(
            // gradient for entire container
            gradient: LinearGradient(colors: [
              Colors.pink.shade300,
              Colors.deepPurple.shade300,
              Color.fromARGB(255, 98, 147, 255),
            ]),
          ),
        )
      ],
    );
  }
}
