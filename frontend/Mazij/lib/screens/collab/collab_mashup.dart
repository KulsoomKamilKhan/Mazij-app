import 'package:Mazaj/screens/collab/chat/pages/home_page.dart';
import 'package:Mazaj/screens/collab/painter.dart';
import 'package:Mazaj/widgets/app_bar.dart';
import 'package:Mazaj/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:Mazaj/widgets/home.dart';

class CollabMashup extends StatefulWidget {
  const CollabMashup({Key? key}) : super(key: key);

  @override
  _CollabMashupState createState() => _CollabMashupState();
}

class _CollabMashupState extends State<CollabMashup> {
  @override
  Widget build(BuildContext context) {
    // if ((MediaQuery.of(context).size.width >= 1000) &&
    //     (MediaQuery.of(context).size.height >= 500)) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: myAppBar("Collaborate and Mashup"),
        ),
        drawer: const SettingsDrawer(),
        // row for displaying side-by-side,
        body: Row(children: const [
          Expanded(
            child: FlutterPainterExample(),
            flex: 2,
          ),
          Expanded(
            child: HomePage(),
            flex: 1,
          ),
        ]));
    // }
    // return Scaffold(
    //   appBar: PreferredSize(
    //     preferredSize: const Size.fromHeight(50),
    //     child: myAppBar("Collaborate and Mashup"),
    //   ),
    //   drawer: const SettingsDrawer(),
    //   // row for displaying side-by-side,
    //   // endDrawer: Drawer(
    //   //   child: SingleChildScrollView(child: Expanded(child: HomePage())),
    //   // ),
    //   body: const Expanded(
    //     child: FlutterPainterExample(),
    //     flex: 2,
    //   ),
    // );
  }
}