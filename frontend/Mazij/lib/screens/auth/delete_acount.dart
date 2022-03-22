import 'package:Mazaj/widgets/app_bar.dart';
import 'package:Mazaj/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Mazaj/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Delete extends StatelessWidget {
  const Delete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: myAppBar("Account Settings"),
        ),
        drawer: const SettingsDrawer(),
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
          if (state is AccountDeleted) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/welcome', (route) => false);
          }
        }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationWait) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AuthenicationError) {}
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
    return SafeArea(
        child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF068EE9),
                Color(0xFF8E24AA),
                Color(0xFFF48FB1),
              ],
            )),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Form(
                //Form widget using the _formKey created above.
                key: _formKey,
                child: Column(children: [
                  Expanded(
                      child: ListView(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.home_outlined),
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          iconSize: 45,
                          tooltip: 'Home',
                          onPressed: () {
                            Navigator.of(context).pushNamed('/home');
                          },
                        ),
                      ),
                      Container(
                          width: 500,
                          height: 350,
                          decoration: BoxDecoration(
                            // image: DecorationImage(image: Image.asset("assets/logo.png").image, opacity: 0.4, fit: BoxFit.fill),
                            color: Color.fromRGBO(255, 255, 255, 0.3),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Delete Account',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'Please enter your registered username and password',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: 500.0,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        label: const Text('Username',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white)),
                                        icon: const Icon(Icons.person,
                                            color: Colors.white),
                                        hintText: 'e.g. firstname_lastname',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
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
                                      obscureText: !_passwordVisible,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                        label: const Text('Password',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white)),
                                        icon: const Icon(
                                          Icons.password,
                                          color: Colors.white,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: const Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          },
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(85),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter the password';
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
                                            BlocProvider.of<AuthenticationBloc>(
                                                    context)
                                                .add(DeleteAcc(
                                                    username: _username,
                                                    password: _password));
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.purple,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      shadowColor: Colors.grey,
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        BlocProvider.of<AuthenticationBloc>(
                                                context)
                                            .add(DeleteAcc(
                                                username: _username,
                                                password: _password));
                                      }
                                    },
                                    child: const Text('Delete Account'),
                                  ),
                                ]),
                          ))
                    ])
                  ]))
                ]))));
  }
}
