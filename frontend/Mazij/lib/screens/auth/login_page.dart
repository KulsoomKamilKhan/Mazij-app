import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Mazaj/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
      if (state is LoginSuccessful) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } else if (state is AdminLogin) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/admin', (route) => false);
      }
    }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationWait) {
          Path _buildSpeechBubblePath() {
            return Path()
              ..moveTo(50, 0)
              ..quadraticBezierTo(0, 0, 0, 37.5)
              ..quadraticBezierTo(0, 75, 25, 75)
              ..quadraticBezierTo(25, 95, 5, 95)
              ..quadraticBezierTo(35, 95, 40, 75)
              ..quadraticBezierTo(100, 75, 100, 37.5)
              ..quadraticBezierTo(100, 0, 50, 0)
              ..close();
          }

          return Center(
            child: //CircularProgressIndicator(),
                LiquidCustomProgressIndicator(
              direction: Axis.horizontal,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
              shapePath: _buildSpeechBubblePath(),
            ),
          );
          // return const Center(
          //   child: CircularProgressIndicator(),
          // );
        } else if (state is LoginUnsuccessful || state is AuthenicationError) {}
        return const CustomForm();
      },
    )));
  }
}

class CustomForm extends StatefulWidget {
  const CustomForm({Key? key}) : super(key: key);

  @override
  CustomFormState createState() {
    return CustomFormState();
  }
}

class CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    if ((MediaQuery.of(context).size.width >= 1000) &&
        (MediaQuery.of(context).size.height >= 500)) {
      return Form(
          //Form widget using the _formKey created above.
          key: _formKey,
          child: SafeArea(
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.purpleAccent,
                      Color(0xFF068EE9),
                      //Colors.white,
                    ],
                  )),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset("assets/brand-marketer.png"),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                        flex: 2,
                        child: ListView(children: [
                          const Align(
                              alignment: Alignment.topCenter,
                              child: Text('Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                      fontWeight: FontWeight.w700))),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                              width: 150,
                              height: 450,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.amber.shade200,
                                      blurRadius: 8.0,
                                      spreadRadius: 6.0,
                                    ),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 500.0,
                                        child: TextFormField(
                                          cursorColor: Colors.yellow,
                                          decoration: InputDecoration(
                                            label: const Text('Username',
                                                style: const TextStyle(
                                                    fontSize: 16)),
                                            icon: Icon(
                                              Icons.person,
                                              color: Colors.pink.shade200,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.pink.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(85),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter a username';
                                            }
                                            return null;
                                          },
                                          onChanged: (val) {
                                            _username = val;
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 500.0,
                                        child: TextFormField(
                                          cursorColor: Colors.yellow,
                                          obscureText: !_passwordVisible,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          decoration: InputDecoration(
                                            label: const Text('Password',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                )),
                                            icon: Icon(Icons.password,
                                                color: Colors.pink.shade200),
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.amber,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.pink.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(85),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter a password';
                                            }
                                            return null;
                                          },
                                          onChanged: (val) {
                                            var saltedPass = _username + val;
                                            var bytes = utf8.encode(saltedPass);
                                            var digest = sha256.convert(bytes);
                                            _password = digest.toString();
                                          },
                                          onFieldSubmitted: (value) {
                                            setState(() {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                BlocProvider.of<
                                                            AuthenticationBloc>(
                                                        context)
                                                    .add(Login(
                                                        username: _username,
                                                        password: _password));
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        child: Text(
                                          "Forgot Password?",
                                          style: TextStyle(
                                            color: Colors.purple.shade200,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed('/forgot');
                                        },
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.purple,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          shadowColor: Colors.grey,
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<AuthenticationBloc>(
                                                    context)
                                                .add(Login(
                                                    username: _username,
                                                    password: _password));
                                          }
                                        },
                                        child: const Text('Submit'),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      GestureDetector(
                                        child: Text(
                                          "Need to create an account first? Register Here!",
                                          style: TextStyle(
                                            color: Colors.purple.shade200,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                        onTap: () {
                                          //returns the Navigator relative to the closest widget in the tree that can provide you that Navigator
                                          Navigator.of(context)
                                              .pushNamed('/register');
                                        },
                                      ),
                                    ]),
                              )),
                          const SizedBox(height: 30),
                          const Align(
                              alignment: Alignment.topCenter,
                              child: Text('\u00a9 Mazij',
                                  style: TextStyle(color: Colors.white))),
                        ])),
                  ]))));
    }
    return Form(
        //Form widget using the _formKey created above.
        key: _formKey,
        child: SafeArea(
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.purpleAccent,
                    Color(0xFF068EE9),
                    //Colors.white,
                  ],
                )),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(children: [
                  const SizedBox(width: 50),
                  Expanded(
                      flex: 1,
                      child: ListView(children: [
                        const Align(
                            alignment: Alignment.topCenter,
                            child: Text('Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.w700))),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                            width: 150,
                            height: 450,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber.shade200,
                                    blurRadius: 8.0,
                                    spreadRadius: 6.0,
                                  ),
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 500.0,
                                      child: TextFormField(
                                        cursorColor: Colors.yellow,
                                        decoration: InputDecoration(
                                          label: const Text('Username',
                                              style: TextStyle(fontSize: 16)),
                                          icon: Icon(
                                            Icons.person,
                                            color: Colors.pink.shade200,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.pink.shade400),
                                            borderRadius:
                                                BorderRadius.circular(85),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a username';
                                          }
                                          return null;
                                        },
                                        onChanged: (val) {
                                          _username = val;
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 500.0,
                                      child: TextFormField(
                                        cursorColor: Colors.yellow,
                                        obscureText: !_passwordVisible,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          label: const Text('Password',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              )),
                                          icon: Icon(Icons.password,
                                              color: Colors.pink.shade200),
                                          suffixIcon: IconButton(
                                            icon: const Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.amber,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.pink.shade400),
                                            borderRadius:
                                                BorderRadius.circular(85),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a password';
                                          }
                                          return null;
                                        },
                                        onChanged: (val) {
                                          var saltedPass = _username + val;
                                          var bytes = utf8.encode(saltedPass);
                                          var digest = sha256.convert(bytes);
                                          _password = digest.toString();
                                        },
                                        onFieldSubmitted: (value) {
                                          setState(() {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              BlocProvider.of<
                                                          AuthenticationBloc>(
                                                      context)
                                                  .add(Login(
                                                      username: _username,
                                                      password: _password));
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                            color: Colors.purple.shade200,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/forgot');
                                      },
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.purple,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        shadowColor: Colors.grey,
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          BlocProvider.of<AuthenticationBloc>(
                                                  context)
                                              .add(Login(
                                                  username: _username,
                                                  password: _password));
                                        }
                                      },
                                      child: const Text('Submit'),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        "Need to create an account first? Register Here!",
                                        style: TextStyle(
                                          color: Colors.purple.shade200,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      onTap: () {
                                        //returns the Navigator relative to the closest widget in the tree that can provide you that Navigator
                                        Navigator.of(context)
                                            .pushNamed('/register');
                                      },
                                    ),
                                  ]),
                            )),
                        const SizedBox(height: 30),
                        Image.asset("assets/brand-marketer.png"),
                        const SizedBox(height: 20),
                        const Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              '\u00a9 Mazij',
                              style: TextStyle(color: Colors.white),
                            )),
                      ])),
                ]))));
  }
}
