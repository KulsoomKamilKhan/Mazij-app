import 'package:Mazaj/data/models/follow_model.dart';
import 'package:Mazaj/data/models/post_model.dart';
import 'package:Mazaj/data/repositories/follow_repo.dart';
import 'package:Mazaj/data/repositories/post_repo.dart';
import 'package:Mazaj/screens/feed/caption_posts.dart';
import 'package:Mazaj/screens/library/userprofile.dart';
import 'package:Mazaj/screens/search/searcht.dart';
import 'package:flutter/material.dart';
import 'package:Mazaj/widgets/app_bar.dart';
import 'package:Mazaj/widgets/app_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Mazaj/bloc/post_bloc/post_bloc.dart';
import 'package:Mazaj/data/models/library_model.dart';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class Libraries extends StatefulWidget {
  const Libraries({Key? key}) : super(key: key);

  @override
  _LibrariesState createState() => _LibrariesState();
}

class _LibrariesState extends State<Libraries> {
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
          child: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
                color: Colors.black), // for all icons in the appbar
            title: const Text("Libraries",
                style: TextStyle(
                    color: Color(0xB6326EF1),
                    fontSize: 32,
                    fontWeight: FontWeight.w700)),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                highlightColor: Colors.purple,
                tooltip: "Search",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchT(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        drawer: const SettingsDrawer(),
        body: BlocListener<PostBloc, PostState>(listener: (context, state) {
          if (state is PostUpvoted) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/lib', (route) => false);
          }
        }, child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
          if (state is PostLoading) {
            // return const Center(
            //   child: CircularProgressIndicator(),
            //);
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
            ));
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

class _TopTabBarState extends State<TopTabBar> with TickerProviderStateMixin {
  late TabController _categoryController;
  late TabController _subCategoryController0;
  late TabController _subCategoryController1;
  late TabController _subCategoryController2;
  late TabController _subCategoryController3;
  final FollowRepository _followRepository = FollowRepository();
  int _activeIndex = 0;
  String username = '';
  //Follow u = Follow(user: "", followers: "['[]']", follows: "['[]']");

  List<Library> aposts = [];
  List<Library> sposts = [];
  List<Library> gposts = [];
  List<Library> ccposts = [];

  void switchLib() {
    int i = 0;
    while (i < widget.posts!.length) {
      Library post = widget.posts![i];
      switch (post.account_type) {
        case "A":
          aposts.insert(0, post);
          gposts.insert(0, post);
          break;
        case "S":
          sposts.insert(0, post);
          gposts.insert(0, post);
          break;
        case "G":
          gposts.insert(0, post);
          break;
        case "CC":
          ccposts.insert(0, post);
          gposts.insert(0, post);
          break;
        case "BM":
          aposts.insert(0, post);
          sposts.insert(0, post);
          gposts.insert(0, post);
          ccposts.insert(0, post);
          break;
      }
      i++;
    }
  }

  bool pressed1 = false;
  bool pressed2 = false;
  bool pressed3 = false;
  bool pressed4 = false;
  Color w1 = Colors.white;
  Color w2 = Colors.white;
  Color w3 = Colors.white;
  Color w4 = Colors.white;
  var storage = const FlutterSecureStorage();
  List<String> response = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      username = (await storage.read(key: 'username')).toString();
      response = await _followRepository.getFollowsByUser(username);
      int i = 0;
      while (i < response.length) {
        if (response[i].compareTo("G") == 0) {
          w1 = Colors.red;
          pressed1 = true;
        } else if (response[i].compareTo("A") == 0) {
          w2 = Colors.red;
          pressed2 = true;
        } else if (response[i].compareTo("S") == 0) {
          w3 = Colors.red;
          pressed3 = true;
        } else if (response[i].compareTo("CC") == 0) {
          w4 = Colors.red;
          pressed4 = true;
        }
        i++;
      }
      if (mounted) setState(() {});
    });
    super.initState();
    _categoryController = TabController(length: 4, vsync: this);
    _subCategoryController1 = TabController(length: 1, vsync: this);
    _subCategoryController2 = TabController(length: 1, vsync: this);
    _subCategoryController0 = TabController(length: 1, vsync: this);
    _subCategoryController3 = TabController(length: 1, vsync: this);
    switchLib();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _categoryController.dispose(); // Discards any resources used by the object
  }

  @override
  Widget build(BuildContext context) {
    _categoryController.addListener(() {
      // to keep track of the changing of tabs
      if (_categoryController.indexIsChanging) {
        setState(() {
          _activeIndex = _categoryController.index;
        });
      }
    });
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 72,
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
            child: TabBar(
              controller: _categoryController,
              tabs: [
                const Tab(
                  height: 72,
                  icon: Icon(Icons.grid_view_outlined),
                  child: Text("General", style: TextStyle(color: Colors.white)),
                ),
                Tab(
                  height: 72,
                  icon: const Icon(Icons.brush),
                  child: Tooltip(
                      message: "Follow Artist library",
                      child: MaterialButton(
                        //style: ElevatedButton.styleFrom(
                        // primary: w2,
                        // shadowColor: Colors.grey,
                        color: Colors.transparent,
                        //hoverColor: Colors.blue.shade800,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: w2)),
                        //),
                        onPressed: () async {
                          print("follow in lib 2");
                          if (!pressed2) {
                            print(pressed2);
                            var bool =
                                await _followRepository.Create(username, "A");
                            if (bool) {
                              setState(() {
                                w2 = Colors.red;
                                pressed2 = true;
                              });
                              print(pressed2);
                            }
                          } else {
                            print(pressed2);
                            var bool =
                                await _followRepository.Delete(username, "A");
                            if (bool) {
                              setState(() {
                                w2 = Colors.white;
                                pressed2 = false;
                              });
                              print(pressed2);
                            }
                          }
                        },
                        child: const Text(
                          "Artist",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
                Tab(
                  height: 72,
                  icon: const Icon(Icons.book),
                  child: Tooltip(
                      message: "Follow Student library",
                      child: MaterialButton(
                        // style: ElevatedButton.styleFrom(
                        //   primary: w3,
                        //   shadowColor: Colors.grey,
                        // ),
                        color: Colors.transparent,
                        // hoverColor: Colors.blue.shade800,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: w3)),
                        onPressed: () async {
                          print("follow in lib 2");
                          if (!pressed3) {
                            print(pressed3);
                            var bool =
                                await _followRepository.Create(username, "S");
                            if (bool) {
                              setState(() {
                                w3 = Colors.red;
                                pressed3 = true;
                              });
                              print(pressed1);
                            }
                          } else {
                            print(pressed3);
                            var bool =
                                await _followRepository.Delete(username, "S");
                            if (bool) {
                              setState(() {
                                w3 = Colors.white;
                                pressed3 = false;
                              });
                              print(pressed3);
                            }
                          }
                        },
                        child: const Text("Student",
                            style: TextStyle(color: Colors.white)),
                      )),
                ),
                Tab(
                    height: 72,
                    icon: const Icon(Icons.camera_alt_outlined),
                    child: Tooltip(
                      message: "Follow Content Creator library",
                      child: MaterialButton(
                        // style: ElevatedButton.styleFrom(
                        //   primary: w4,
                        //   shadowColor: Colors.grey,
                        // ),
                        color: Colors.transparent,
                        //hoverColor: Colors.blue.shade800,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: w4)),
                        onPressed: () async {
                          print("follow in lib 2");
                          if (!pressed4) {
                            print(pressed4);
                            var bool =
                                await _followRepository.Create(username, "CC");
                            if (bool) {
                              setState(() {
                                w4 = Colors.red;
                                pressed4 = true;
                              });
                              print(pressed4);
                            }
                          } else {
                            print(pressed4);
                            var bool =
                                await _followRepository.Delete(username, "CC");
                            if (bool) {
                              setState(() {
                                w4 = Colors.white;
                                pressed4 = false;
                              });
                              print(pressed4);
                            }
                          }
                        },
                        child: const Text("Content Creator",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white)),
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: _activeIndex == 0
                ? TabBarView(
                    controller: _subCategoryController0,
                    children: <Widget>[
                      grid(gposts, username),
                    ],
                  )
                : _activeIndex == 1
                    ? TabBarView(
                        controller: _subCategoryController1,
                        children: <Widget>[
                          grid(aposts, username),
                        ],
                      )
                    : _activeIndex == 2
                        ? TabBarView(
                            controller: _subCategoryController2,
                            children: <Widget>[
                              grid(sposts, username),
                            ],
                          )
                        : TabBarView(
                            controller: _subCategoryController3,
                            children: <Widget>[
                              grid(ccposts, username),
                            ],
                          ),
          ),
        ],
      ),
    );
  }

  List<Widget> getc(String caption) {
    List<Widget> list = [];
    final split = caption.split(',');
    int i = 0;
    Map<int, String> values = {};
    while (i < split.length) {
      values[i] = split[i];
      i++;
    }
    int j = 0;
    while (j < values.length) {
      String s = values[j].toString();
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CaptionPosts(username, s, widget.posts!),
                    ));
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
      String s = values[j].toString();

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
                      builder: (context) => UserProfile(s),
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

  Padding grid(List<Library> posts, String username) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: posts.length,
        itemBuilder: (BuildContext ctx, index) {
          Library post = posts[index];
          var _bytesImage = const Base64Decoder().convert(post.post);
          // return Column(children: [
          return InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        //title: Row(children: getc(post.caption)),
                        title: Column(children: [
                          Row(children: getc(post.caption)),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: getu(post.collaborators),
                          )
                        ]),
                        content: Stack(
                          //alignment: Alignment.center,
                          children: <Widget>[
                            Image.memory(
                              _bytesImage,
                              //gaplessPlayback: true,
                            ),
                          ],
                        ),
                        actions: <Widget>[
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
                              _postrepo.sendEmail(username, post.user, post.id);
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
                                            color: Colors.white, fontSize: 15),
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
                                        UserProfile(post.user),
                                  ),
                                );
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel_rounded),
                            tooltip: 'Close',
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                          ),
                        ],
                      ));
            },
            //child: GestureDetector(
            child: Tooltip(
                textStyle: const TextStyle(color: Colors.white, fontSize: 15),
                message: post.user,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.black.withOpacity(0.2)),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.memory(_bytesImage).image,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                )),
          );
        },
      ),
    );
  }
}
