import 'dart:convert';

import 'package:Mazaj/data/models/library_model.dart';
import 'package:Mazaj/data/repositories/post_repo.dart';
import 'package:flutter/material.dart';

class SearchT extends StatefulWidget {
  const SearchT({Key? key}) : super(key: key);

  @override
  State<SearchT> createState() => _SearchTState();
}

class _SearchTState extends State<SearchT> {

  List<Library> posts = [];
  List<Library> _foundPosts = []; 
  final PostRepository _postRepository = PostRepository();
 

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      posts = await _postRepository.GetPosts();
      _foundPosts = posts;
      print("search t");
      if (mounted) setState(() {});
    });

    super.initState();
    
  }

  void _runFilter2(String enteredKeyword) {
    List<Library> results = [];
    if (enteredKeyword.isEmpty) {
      results = posts;
      print("if filter length");
      print(results.length);
    } else {
      print("if filter not 0");
      results = posts
          .where((post) => ((post.caption
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase())) ||
              (enteredKeyword
                  .toLowerCase()
                  .startsWith(post.account_type.toLowerCase()))))
          .toList();
    }

    // Refresh the UI
    setState(() {
      _foundPosts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.cancel_outlined),
          onPressed: () {
            Navigator.of(context).pushNamed('/lib');
          },
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Search Tags',
            style: TextStyle(
                color: Colors.purple,
                fontSize: 27,
                fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) => _runFilter2(value),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  suffixIcon: const Icon(Icons.search)),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
                child:
                    //_foundUsers.isNotEmpty?
                    _foundPosts.isEmpty
                        ? displayposts(context, posts)
                        : displayposts(context, _foundPosts)),
          ],
        ),
      ),
    );
    
  }

  Widget displayposts(BuildContext context, List<Library> post) {
    return SafeArea(
        child: Material(
            child: Column(children: [
      Expanded(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [],
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
                  mainAxisSpacing: 15,
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  Library postobj = post[index];
                  var _bytesImage = const Base64Decoder().convert(postobj.post);
                  return Container(
                      padding:
                          (index % 2 == 0 // gap from left or right to screen
                              ? const EdgeInsets.only(left: 20.0)
                              : const EdgeInsets.only(right: 20.0)),
                      child: Tooltip(
                        message: postobj.user,
                          child: Container(
                            child: Text(postobj.user, style: TextStyle(fontWeight: FontWeight.bold),),
                            height: MediaQuery.of(context).size.height / 4.7,
                            width: MediaQuery.of(context).size.width / 3.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.memory(
                                    _bytesImage,
                                  ).image,
                                )),
                          )));
                }, childCount: post.length),
              ),
            ),
          ],
        ),
      ),
    ])));
  }
}