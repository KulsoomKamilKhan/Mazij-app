import 'package:Mazaj/data/models/follow_model.dart';
import 'package:Mazaj/data/models/post_model.dart';
import 'package:Mazaj/data/repositories/follow_repo.dart';
import 'package:Mazaj/data/repositories/post_repo.dart';
import 'package:Mazaj/data/repositories/profile_repo.dart';
import 'package:Mazaj/screens/feed/caption_posts.dart';
import 'package:Mazaj/screens/feed/userprofilef.dart';
import 'package:flutter/material.dart';
import 'package:Mazaj/widgets/app_bar.dart';
import 'package:Mazaj/widgets/app_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Mazaj/bloc/post_bloc/post_bloc.dart';
import 'package:Mazaj/data/models/library_model.dart';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Library>? posts;
  @override
  void initState() {
    loadPosts();
    super.initState();
  }

  loadPosts() async {
    BlocProvider.of<PostBloc>(context).add(const GetPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: myAppBar("Feed"),
        ),
        drawer: const SettingsDrawer(),
        body: BlocListener<PostBloc, PostState>(listener: (context, state) {
          if (state is PostUpvoted) {
            // print("here upv");
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/feed', (route) => false);
          }
        }, child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
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
          } else if (state is LibrariesLoaded) {
            posts = state.posts;
            return TopTabBar(posts);
          } else if (state is PostError) {}
          return const Text("No images to Display");
        })));
  }
}

class TopTabBar extends StatefulWidget {
  List<Library>? posts;
  TopTabBar(this.posts, {Key? key}) : super(key: key);

  @override
  _TopTabBarState createState() => _TopTabBarState();
}

class _TopTabBarState extends State<TopTabBar> {
  String username = '';
  String acc = '';
  List<Library> posts2 = [];
  List<String> list = [];
  //List<String> titles = [];

  void getPosts() {
    int i = 0;
    while (i < list.length) {
      String u = list[i];
      int j = 0;
      while (j < widget.posts!.length) {
        Library post = widget.posts![j];
        if ((post.user.compareTo(u) == 0) ||
            (post.account_type.compareTo(u) == 0)) {
          var _bytesImage = const Base64Decoder().convert(post.post);
          posts2.add(post);
        }
        j++;
      }
      i++;
    }
  }

  var storage = const FlutterSecureStorage();
  FollowRepository followRepo = FollowRepository();
  final ProfileRepository _profRepository = ProfileRepository();
  List<dynamic> profiles = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      profiles = await _profRepository.getProfiles();
      username = (await storage.read(key: 'username')).toString();
      acc = (await storage.read(key: 'accounttype')).toString();
      list = await followRepo.getFollowsByUser(username);
      getPosts();
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

  String ac(String type) {
    String acc = '';
    switch (type) {
      case "A":
        acc = "Artist";
        break;
      case "G":
        acc = "General";
        break;
      case "S":
        acc = "Student";
        break;
      case "CC":
        acc = "Content Creator";
        break;
      case "BM":
        acc = "Brand Marketer";
        break;
    }
    return acc;
  }

  List<Widget> getc(String caption) {
    List<Widget> list = [];
    final split = caption.split(',');
    int i = 0;
    Map<int, String> values = {};
    while (i < split.length) {
      values[i] = split[i];
      // print(values[i]);
      // print(split[i].length);
      i++;
    }
    int j = 0;
    while (j < values.length) {
      String s = values[j].toString().trim();
      // print('in feed');
      // print(s);
      list.add(Row(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurpleAccent.shade400,
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                textStyle: const TextStyle(fontSize: 10),
                shadowColor: Colors.grey,
              ),
              onPressed: () {
                //print(s);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CaptionPosts(username, s, widget.posts!),
                  ),
                );
              },
              child: Text(s)),
          SizedBox(
            width: 5,
          ),
        ],
      ));
      j++;
    }
    return list;
  }

  List<Widget> getu(String collaborators) {
    List<Widget> list = [];
    final split = collaborators.split(',');
    int i = 0;
    Map<int, String> values = {};
    while (i < split.length) {
      values[i] = split[i];
      i++;
    }

    int j = 0;
    while (j < values.length) {
      String s = values[j].toString().trim();

      list.add(Row(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple.shade400,
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                textStyle:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                shadowColor: Colors.grey,
              ),
              onPressed: () {
                if (s.compareTo(username) == 0) {
                  Navigator.of(context).pushNamed('/home');
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfileF(s),
                    ),
                  );
                }
              },
              child: Text(s)),
          SizedBox(
            width: 5,
          ),
        ],
      ));
      j++;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    if ((MediaQuery.of(context).size.width >= 1000) &&
        (MediaQuery.of(context).size.height >= 500)) {
      return Scaffold(
          body: SafeArea(
              child: Column(children: <Widget>[
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.purple.shade300,
              const Color(0xFF326EF1),
              Colors.purple,
            ],
          )),
          child: ListView.builder(
              itemCount: posts2.length,
              itemBuilder: (context, index) {
                Library post = posts2[index];
                var _bytesImage = const Base64Decoder().convert(post.post);
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 250, vertical: 50),
                    child: Card(
                      color: Colors.white,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                              leading: CircleAvatar(
                                backgroundImage: Image.memory(
                                  _profilepic(posts2[index].user),
                                ).image,
                                radius: 55.0,
                              ),
                              title: Text(
                                posts2[index].user,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Row(children: [
                                Divider(),                                
                                ElevatedButton(
                                  
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(width: 3.0, color: Colors.grey.shade300,),
                                    primary: Colors.amber.shade300,
                                    onSurface: Colors.grey,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 2),
                                    textStyle: const TextStyle(
                                        fontSize: 10, color: Colors.white),
                                    shadowColor: Colors.grey,
                                    
                                  ),
                                  child: Text(ac(posts2[index].account_type),
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  onPressed: () {},
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(children: [
                                  Row(children: getc(post.caption)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: getu(post.collaborators),
                                  )
                                ]),
                              ])),
                          SizedBox(
                            height: 500,
                            width: 500,
                            child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.memory(_bytesImage).image,
                                ))),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(Icons.favorite,
                                    color: Colors.red.withOpacity(0.7)),
                                tooltip: 'Upvote Post',
                                onPressed: () {
                                  post.upvotes++;
                                  Post uppost = Post(
                                      id: post.id,
                                      post: post.post,
                                      user: post.user,
                                      caption: post.caption,
                                      upvotes: post.upvotes,
                                      created_on: post.created_on,
                                      collaborators: post.collaborators);
                                  BlocProvider.of<PostBloc>(context)
                                      .add(UpvotePost(post: uppost));
                                },
                              ),
                              Text(
                                post.upvotes.toString(),
                                style: const TextStyle(fontSize: 11),
                              ),
                              const Text(
                                'upvotes',
                                style: TextStyle(fontSize: 11),
                              ),
                              IconButton(
                                icon: const Icon(Icons.report),
                                tooltip: 'Report Post',
                                onPressed: () {
                                  PostRepository _postrepo = PostRepository();
                                  _postrepo.sendEmail(
                                      username, post.user, post.id);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        Future.delayed(
                                            const Duration(seconds: 2), () {
                                          Navigator.of(context).pop(true);
                                        });
                                        return const AlertDialog(
                                          backgroundColor: Colors.black87,
                                          title: Text(
                                            'This content has been reported',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        );
                                      });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.person),
                                tooltip: 'Go To Profile',
                                onPressed: () {
                                  if (post.user.compareTo(username) == 0) {
                                    Navigator.of(context).pushNamed('/home');
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserProfileF(post.user),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ));
              }),
        ))
      ])));
    }

    return Scaffold(
        body: SafeArea(
            child: Column(children: <Widget>[
      Expanded(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.purple.shade300,
            const Color(0xFF326EF1),
            Colors.purple,
          ],
        )),
        child: ListView.builder(
            itemCount: posts2.length,
            itemBuilder: (context, index) {
              Library post = posts2[index];
              var _bytesImage = const Base64Decoder().convert(post.post);
              return Padding(
                  // height: 800,
                  //  width: 800,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                            leading: CircleAvatar(
                              backgroundImage: Image.memory(
                                _profilepic(posts2[index].user),
                              ).image,
                              radius: 55.0,
                            ),
                            title: Text(posts2[index].user,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                            subtitle: Row(children: [
                              Divider(),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(width: 3.0, color: Colors.grey.shade300,),
                                  primary: Colors.amber.shade400,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 2),
                                  textStyle: const TextStyle(
                                      fontSize: 10, color: Colors.white),
                                  shadowColor: Colors.grey,
                                ),
                                child: Text(ac(posts2[index].account_type),
                                    style:
                                        const TextStyle(color: Colors.white)),
                                onPressed: () {},
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(children: [
                                Row(children: getc(post.caption)),
                                SizedBox(height: 10),
                                Row(
                                  children: getu(post.collaborators),
                                )
                              ]),
                            ])),
                        SizedBox(
                          height: 300,
                          width: 500,
                          child: Image.memory(
                            (_bytesImage),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(Icons.favorite,
                                  color: Colors.red.withOpacity(0.7)),
                              tooltip: 'Upvote Post',
                              onPressed: () {
                                post.upvotes++;
                                Post uppost = Post(
                                    id: post.id,
                                    post: post.post,
                                    user: post.user,
                                    caption: post.caption,
                                    upvotes: post.upvotes,
                                    created_on: post.created_on,
                                    collaborators: post.collaborators);
                                BlocProvider.of<PostBloc>(context)
                                    .add(UpvotePost(post: uppost));
                              },
                            ),
                            Text(
                              post.upvotes.toString(),
                              style: const TextStyle(fontSize: 11),
                            ),
                            const Text(
                              'upvotes',
                              style: TextStyle(fontSize: 11),
                            ),
                            IconButton(
                              icon: const Icon(Icons.report),
                              tooltip: 'Report Post',
                              onPressed: () {
                                PostRepository _postrepo = PostRepository();
                                _postrepo.sendEmail(
                                    username, post.user, post.id);
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        Navigator.of(context).pop(true);
                                      });
                                      return const AlertDialog(
                                        backgroundColor: Colors.black87,
                                        title: Text(
                                          'This content has been reported',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      );
                                    });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.person),
                              tooltip: 'Go To Profile',
                              onPressed: () {
                                if (post.user.compareTo(username) == 0) {
                                  Navigator.of(context).pushNamed('/home');
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UserProfileF(post.user),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ));
            }),
      ))
    ])));
  }
}
