import 'package:Mazaj/screens/search/search_bar.dart';
import 'package:flutter/material.dart';

// to display the bar on the top of the screen
class myAppBar extends StatefulWidget {
  String title;
  myAppBar(this.title, {Key? key}) : super(key: key);

  @override
  State<myAppBar> createState() => _AppBarState();
}

class _AppBarState extends State<myAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
          color: Colors.black), // for all icons in the appbar
      title: Text(widget.title,
          style: const TextStyle(
              color: Color(0xB6326EF1),
              fontSize: 32,
              fontWeight: FontWeight.w700)),
      actions: <Widget>[
        // to dsiplay to the right
        IconButton(
          icon: const Icon(Icons.search),
          highlightColor: Colors.purple,
          tooltip: "Search",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Search(),
              ),
            );
          },
        ),
      ],
    );
  }
}
