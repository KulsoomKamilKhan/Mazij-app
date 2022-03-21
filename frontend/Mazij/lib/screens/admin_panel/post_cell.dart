import 'dart:convert';
import 'package:Mazaj/bloc/post_bloc/post_bloc.dart';
import 'package:Mazaj/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCell extends StatelessWidget {
  int id;
  String created_on;
  String post;
  int upvotes;
  String caption;
  PostCell(this.id, this.post, this.upvotes, this.caption, this.created_on);

  @override
  Widget build(BuildContext context) {
    var _bytesImage = Base64Decoder().convert(post);
    Column buildPostSection(String img, int upv) {
      return Column(
        children: [
          InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Post Information',
                              textAlign: TextAlign.center),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Post ID: $id\n'),
                              Text('Created On: $created_on\n'),
                              Text('Caption: $caption\n'),
                              Text('Upvotes: $upvotes')
                            ],
                          ),
                          actions: <Widget>[
                            IconButton(
                              icon: Icon(Icons.cancel_rounded),
                              tooltip: 'Close',
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              //child: const Text('Cancel'),
                            ),
                          ],
                        ));
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //     height: MediaQuery.of(context).size.height / 4.3,
                      //     width: MediaQuery.of(context).size.width / 3.4,
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(30),
                      //         image: DecorationImage(
                      //           fit: BoxFit.cover,
                      //           image: Image.memory(_bytesImage).image,
                      //         )),
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
                        ),Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      PopupMenuButton(
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem<int>(
                                              value: 0,
                                              child: const Text("Delete Post"),
                                              onTap: () =>
                                                  BlocProvider.of<PostBloc>(
                                                          context)
                                                      .add(DeletePost(id: id)),
                                            ),
                                          ];
                                        },
                                      ),
                                    ]),
                              ]),
                      const SizedBox(height: 2),
                      Text(
                        'Post ID: $id\n',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ],
              )),
          // Row(children: [
          //   Text(
          //     "$upv upvotes",
          //     style: const TextStyle(
          //         fontSize: 8,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white),
          //   ),
          // ])
          )],
      );
    }

    return Scaffold(
        body: BlocListener<PostBloc, PostState>(listener: (context, state) {
      if (state is PostDeleted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/admin', (route) => false);
      }
    }, child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is PostError) {}
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              // color: const Color(0xFF212332),
              padding: const EdgeInsets.only(top: 60),
              child: buildPostSection(post, upvotes),
            ),
          )
        ],
      );
    })));
  }
}
