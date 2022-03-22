import 'package:Mazaj/data/models/library_model.dart';
import 'package:Mazaj/data/models/post_model.dart';
import 'package:Mazaj/screens/admin_panel/post_cell.dart';
import 'package:flutter/material.dart';

class PostsTable extends StatefulWidget {
  List<Library> posts;
  PostsTable(this.posts, {Key? key}) : super(key: key);

  @override
  State<PostsTable> createState() => _PostsTableState();
}

class _PostsTableState extends State<PostsTable> {
  Widget profilepage(BuildContext context, List<Library> posts) {
    // for posts
    return Scaffold(
        body: Column(children: <Widget>[
      Align(
        alignment: Alignment.topLeft, // align to the top left of the page
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color.fromRGBO(1, 1, 1, 1),
          iconSize: 25,
          tooltip: 'Back to Dashboard',
          onPressed: () {
            Navigator.of(context).pushNamed('/admin');
          },
        ),
      ),
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
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 15,
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  Library postobj = posts[index];
                  return Container(
                    padding: (index % 2 == 0
                        ? const EdgeInsets.only(left: 20.0)
                        : const EdgeInsets.only(right: 20.0)),
                    child: PostCell(postobj.id, postobj.post, postobj.upvotes,
                        postobj.caption, postobj.created_on, postobj.collaborators),
                  );
                }, childCount: posts.length),
              ),
            ),
          ],
        ),
      ),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFF212332),
        child: profilepage(context, widget.posts));
  }
}
