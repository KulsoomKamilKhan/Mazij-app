import 'dart:convert';
import 'package:Mazaj/bloc/post_bloc/post_bloc.dart';
import 'package:Mazaj/data/models/library_model.dart';
import 'package:Mazaj/data/models/post_model.dart';
import 'package:Mazaj/data/repositories/post_repo.dart';
import 'package:Mazaj/screens/feed/caption_posts.dart';
import 'package:Mazaj/screens/feed/userprofilec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  // int id;
  // String post;
  // int upvotes;
  Post post;
  PostScreen(this.post);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Library> posts = [];

  List<Widget> getc(String caption, List<Library> posts) {
    List<Widget> list = [];
    final split = caption.split(',');
    int i = 0;
    Map<int, String> values = {};
    while (i < split.length) {
      values[i] = split[i];
      print(values[i]);
      i++;
    }

    int j = 0;
    while (j < values.length) {
      String s = values[j].toString().trim();
      print(s);
      list.add(Row(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                textStyle: const TextStyle(fontSize: 10),
                shadowColor: Colors.grey,
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CaptionPosts(widget.post.user, s, posts),
                //   ),
                //   //(route) => false,
                // );
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

  List<Widget> getu(BuildContext context, String collaborators) {
    List<Widget> list = [];
    final split = collaborators.split(',');
    int i = 0;
    print("collaborators");
    print(collaborators);
    Map<int, String> values = {};
    while (i < split.length) {
      values[i] = split[i];
      print(split[i]);
      print(values[i]);
      i++;
    }

    int j = 0;
    while (j < values.length) {
      String s = values[j].toString().trim();
      print(s);
      list.add(Row(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                textStyle:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                shadowColor: Colors.grey,
              ),
              onPressed: () {
                // if (s.compareTo(widget.post.user) != 0) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => UserProfileC(s),
                //     ),
                //   );
                // }
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

  final PostRepository _postRepository = PostRepository();
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      posts = await _postRepository.GetPosts();
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _bytesImage = Base64Decoder().convert(widget.post.post);
    var date = widget.post.created_on.substring(0, 10);
    Column buildPostSection(Post post) {
      return Column(
        children: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        // title: Row(children: getc(post.caption)),
                        title: Column(children: [
                          Row(children: getc(post.caption, posts)),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: getu(context, post.collaborators),
                          )
                        ]),
                        //Text(post.caption, textAlign: TextAlign.center),
                        content: Stack(
                          //alignment: Alignment.center,
                          children: <Widget>[
                            Image.memory(
                              _bytesImage,
                              //gaplessPlayback: true,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          Text(date,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 13)),
                          IconButton(
                            icon: Icon(Icons.cancel_rounded),
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            //child: const Text('Cancel'),
                          ),
                        ],
                      ));
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 4.3,
              width: MediaQuery.of(context).size.width / 3.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.memory(
                      _bytesImage,
                      //gaplessPlayback: true,
                    ).image,
                  )),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem<int>(
                              value: 0,
                              child: const Text("Delete Post"),
                              onTap: () => BlocProvider.of<PostBloc>(context)
                                  .add(DeletePost(id: post.id)),
                            ),
                          ];
                        },
                      ),
                    ]),
                  ]),
            ),
          ),
          Row(children: [
            IconButton(
              onPressed: () {
                post.upvotes++;
                BlocProvider.of<PostBloc>(context).add(UpvotePost(post: post));
              },
              icon: Icon(Icons.favorite,
                  size: 25, color: Colors.red.withOpacity(0.7)),
            ),
            Text(
              "${post.upvotes} upvotes",
              style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]),
            ),
          ])
        ],
      );
    }

    return Scaffold(
        body: BlocListener<PostBloc, PostState>(listener: (context, state) {
      if (state is PostDeleted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      }
      if (state is PostUpvoted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      }
    }, child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is PostError) {}
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 4),
              child: buildPostSection(widget.post),
            ),
          )
        ],
      );
    })));
  }
}
