import 'dart:convert';
import 'package:Mazaj/bloc/post_bloc/post_bloc.dart';
import 'package:Mazaj/data/models/post_model.dart';
import 'package:Mazaj/data/repositories/post_repo.dart';
import 'package:Mazaj/screens/library/userprofile.dart';
import 'package:Mazaj/screens/profiles/user_profile_search.dart';
import 'package:Mazaj/screens/search/userprofilesearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:intl/intl.dart';

class UserPostSP extends StatelessWidget {
  Post post;
  String _loggeduser;
  //String pg;
  UserPostSP(this.post, this._loggeduser);

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
      String s = values[j].toString().trim();
      list.add(ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            textStyle: const TextStyle(fontSize: 10),
            shadowColor: Colors.grey,
          ),
          onPressed: () {},
          child: Text(s)));
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

      list.add(ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.amber,
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            textStyle:
                const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            shadowColor: Colors.grey,
          ),
          onPressed: () {},
          child: Text(s)));
      j++;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var date = post.created_on.substring(0, 10);

    PostRepository _postrepo = PostRepository();
    var _bytesImage = Base64Decoder().convert(post.post);

    Column buildPostSection(Post post) {
      return Column(
        children: [
          InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          // title:
                          //     Row(children: getc(post.caption)),
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
                              Image.memory(_bytesImage),
                            ],
                          ),
                          actions: <Widget>[
                            Text(date,
                                style: const TextStyle(
                                    color: Colors.black87, fontSize: 13)),
                            IconButton(
                              icon: Icon(Icons.cancel_rounded),
                              tooltip: 'Close',
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              //child: const Text('Cancel'),
                            ),
                          ],
                        ));
              },
              // child: Card(
              //     clipBehavior: Clip.antiAlias,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem<int>(
                                value: 0,
                                child: const Text("Report Post"),
                                onTap: () {
                                  _postrepo.sendEmail(
                                      _loggeduser, post.user, post.id);
                                  const snackBar = SnackBar(
                                    content:
                                        Text('This content has been reported'),
                                    duration: Duration(seconds: 3),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                }),
                          ];
                        },
                      ),
                    ]),
                    SizedBox(
                      height: 160,
                      width: 300,
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.memory(_bytesImage).image,
                          ))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ])),
          Row(children: [
            IconButton(
              onPressed: () {
                post.upvotes++;
                //post.upvotes);
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
      if (state is PostUpvoted) {
        // Navigator.of(context).pushNamedAndRemoveUntil('/lib', (route) => false);
        //"upvotes");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfileSP(
              post.user,
            ),
          ),
        );
      }
    }, child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is PostError) {}
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 4),
              child: buildPostSection(post),
            ),
          )
        ],
      );
    })));
  }
}
