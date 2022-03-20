import 'package:flutter/material.dart';
import 'responsive.dart';

//const defaultPadding = 16.0;

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        //color: Colors.blue,
        //Color(0xFF212332)
        //child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(children: const [
          // Row(children: const [
          // if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            //style: Theme.of(context).textTheme.headline6,
            style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 50,
              color: Colors.white,
              decoration: TextDecoration.none
            ),
            textAlign: TextAlign.center,
          ),
          // if (!Responsive.isMobile(context))
          //   Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          // Expanded(child: Image.asset('assets/logo.png')),
          // ])
        ]),
      ),
      // )
    );
  }
}
