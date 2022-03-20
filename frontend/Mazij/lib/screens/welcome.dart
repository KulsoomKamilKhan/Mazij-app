import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              // for gradient in the page
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.blue,
                  Colors.purple,
                ],
              )),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(children: [
                Expanded(
                    // to fill in available space in the screen
                    child: ListView(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 3.5,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/logo.png"))),
                          ),
                          const Text(
                            'Mazij',
                            style: TextStyle(
                              fontSize: 70.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Column(
                        children: <Widget>[
                          // the login button
                          MaterialButton(
                            minWidth: 200,
                            height: 60,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/login');
                            },
                            elevation: 0,
                            color: Colors.transparent,
                            hoverColor: Colors.blue.shade800,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: const BorderSide(color: Colors.white)),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                          //the signup button
                          const SizedBox(height: 20),
                          MaterialButton(
                            minWidth: 200,
                            height: 60,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/register');
                            },
                            elevation: 0,
                            color: Colors.transparent,
                            hoverColor: Colors.indigo.shade600,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: const BorderSide(color: Colors.white)),
                            child: const Text(
                              "Create Account",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ]))
              ]))),
    );
  }
}
