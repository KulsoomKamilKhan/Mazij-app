import 'package:flutter/material.dart';
import 'package:Mazaj/widgets/home.dart';
import 'package:Mazaj/widgets/app_drawer.dart';
import 'package:Mazaj/widgets/app_bar.dart';
import 'package:flutter/services.dart' show rootBundle;  // for displaying the file

class TermsAndCond extends StatefulWidget {
  const TermsAndCond({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TermsAndCondState();
}

class _TermsAndCondState extends State<TermsAndCond> {
  String data = '';

  _loadAsset() async {
    String text = await rootBundle.loadString('termsandcond.txt');

    setState(() {
      data = text;
    });
  }

  @override
  void initState() {
    _loadAsset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: myAppBar("Terms and Conditions"),
        ),
        drawer: const SettingsDrawer(),
        body: SafeArea(
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage (image: Image.asset("assets/logo.png").image, opacity: 0.3),
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                     Colors.purpleAccent,
                    Color(0xFF9CB5EB),
                    Colors.white,
                  ],
                )),
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.home_outlined),
                      color: const Color.fromRGBO(255,255,255,1),
                      iconSize: 45,
                      tooltip: 'Home',
                      onPressed: () {
                         Navigator.of(context).pushNamed('/home');
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 25, left: 55, right: 55, bottom: 50),
                    padding: const EdgeInsets.all(40),
                    decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              
                            ),
                    child: Text(
                      data,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ])))));
  }
}
