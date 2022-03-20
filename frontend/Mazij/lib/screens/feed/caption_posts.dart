import 'dart:convert';

import 'package:Mazaj/bloc/post_bloc/post_bloc.dart';
import 'package:Mazaj/data/models/library_model.dart';
import 'package:Mazaj/data/models/post_model.dart';
import 'package:Mazaj/data/repositories/post_repo.dart';
import 'package:Mazaj/screens/feed/userprofilec.dart';
import 'package:Mazaj/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class CaptionPosts extends StatefulWidget {
  String u;
  String caption;
  List<Library> posts;
  CaptionPosts(this.u, this.caption, this.posts, {Key? key}) : super(key: key);

  @override
  State<CaptionPosts> createState() => _CaptionPostsState();
}

class _CaptionPostsState extends State<CaptionPosts> {
  @override
  Widget build(BuildContext context) {
    print('in caption.dart');
    print(widget.caption);
    print(widget.caption.length);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: myAppBar("Tagged Posts"),
        ),
        //drawer: const SettingsDrawer(),
        body: BlocListener<PostBloc, PostState>(listener: (context, state) {
          if (state is PostUpvoted) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CaptionPosts(widget.u, widget.caption, widget.posts),
                ));
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
          }
          // } else if (state is LibrariesLoaded) {
          //   posts = state.posts;
          //   return TopTabBar(posts);
          // } else
          else if (state is PostError) {}
          //return const Text("No images to Display");
          return Padding(
              padding: EdgeInsets.all(10),
              child: display(widget.posts, widget.u, widget.caption));
        })));
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

      list.add(ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.amber,
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            textStyle:
                const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            shadowColor: Colors.grey,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfileC(s),
              ),
            );
          },
          child: Text(s)));
      j++;
    }
    return list;
  }

  Padding display(List<Library> posts1, String u, String caption) {
    List<Library> posts = [];
    //  posts1.where((post) => (post.caption.compareTo(caption) == 0)).toList();

    int k = 0;
    // List<Widget> getc(String caption) {
    // List<Widget> list = [];
    while (k < posts1.length) {
      Library post = posts1[k];
      final split = post.caption.split(',');
      int i = 0;
      Map<int, String> values = {};
      while (i < split.length) {
        values[i] = split[i].trim();
        if (values[i]!.compareTo(caption) == 0) {
          posts.add(post);
        }
        print(values[i]);
        print(split[i].length);
        i++;
      }
      // int j = 0;
      // while (j < values.length) {
      //   String s = values[j].toString().trim();

      //   j++;
      // }
      k++;
      // return list;
    }

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
                        title: Row(children: getu(post.collaborators)),
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
                              _postrepo.sendEmail(u, post.user, post.id);
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
                              if (post.user.compareTo(u) == 0) {
                                Navigator.of(context).pushNamed('/home');
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserProfileC(post.user),
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
