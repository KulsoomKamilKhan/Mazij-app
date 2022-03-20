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
          child: AppBar(
            backgroundColor: Colors.white,
            title: const Text("Collaborate and Mashup", style: TextStyle(
              color: Color(0xB6326EF1),
              fontSize: 32,
              fontWeight: FontWeight.w700)),
                        
            automaticallyImplyLeading: false,
            actions: [
              IconButton(onPressed: (){Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );}, icon: const Icon(Icons.chat_bubble_rounded, color: Colors.purpleAccent))
            ],
        )),
        drawer: const SettingsDrawer(),
        // row for displaying side-by-side,
        body: //Row(children: const [
          const Expanded(
            child: FlutterPainterExample(),
            flex: 2,
          ),
          // Expanded(
          //   child: HomePage(),
          //   flex: 1,
          // ),
        //])
        );
  }
}
