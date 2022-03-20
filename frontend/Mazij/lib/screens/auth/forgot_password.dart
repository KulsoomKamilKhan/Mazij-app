import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Mazaj/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
      if (state is PasswordUpdated) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false);
      }
    }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationWait) {
          // return const Center(
          //   child: CircularProgressIndicator(),
          // );
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
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              shapePath: _buildSpeechBubblePath(),
            ),
          );
        } else if (state is AuthenicationError) {}
        return const CustomForm();
      },
    )));
  }
}

//storage.read(key: 'username').toString(
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
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
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
                  Expanded(
                      child: ListView(children: [
                    Container(
                        width: 500,
                        height: 500,
                        child: Align(
                            alignment: Alignment.center,
                            child: Container(
                                width: 550,
                                height: 500,
                                decoration: BoxDecoration(
                                  // image: DecorationImage(image: Image.asset("assets/logo.png").image, opacity: 0.4, fit: BoxFit.fill),
                                  color: Color.fromRGBO(255, 255, 255, 0.3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('Forgot Password',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 40,
                                                fontWeight: FontWeight.w700)),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        const Text(
                                          'Please enter your new password',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Container(
                                          width: 500.0,
                                          child: TextFormField(
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                              label: const Text('Username',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  )),
                                              icon: const Icon(
                                                Icons.person,
                                                color: Colors.white,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.purple),
                                                borderRadius:
                                                    BorderRadius.circular(85),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your registered username';
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
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              label: const Text('Email Address',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  )),
                                              icon: const Icon(
                                                Icons.email,
                                                color: Colors.white,
                                              ),
                                              hintText:
                                                  'registered email address',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.purple),
                                                borderRadius:
                                                    BorderRadius.circular(85),
                                              ),
                                            ),
                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your email address';
                                              }
                                              return null;
                                            },
                                            onChanged: (val) {
                                              _email = val;
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
                                                    color: Colors.white,
                                                  )),
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
                                                    color: Colors.purple),
                                                borderRadius:
                                                    BorderRadius.circular(85),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter the password';
                                              }
                                              if (value.length < 8) {
                                                return 'Please ensure the password has a minimum of 8 characters';
                                              }
                                              if (!value
                                                  .contains(RegExp(r'[A-Z]'))) {
                                                return 'Please include an uppercase character';
                                              }
                                              if (!value
                                                  .contains(RegExp(r'[0-9]'))) {
                                                return 'Please include a number';
                                              }
                                              return null;
                                            },
                                            onChanged: (val) {
                                              var saltedPass = _username + val;
                                              var bytes =
                                                  utf8.encode(saltedPass);
                                              var digest =
                                                  sha256.convert(bytes);
                                              _password = digest.toString();
                                            },
                                            onFieldSubmitted: (value) {
                                              setState(() {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  BlocProvider.of<
                                                              AuthenticationBloc>(
                                                          context)
                                                      .add(UpdatePass(
                                                          username: _username,
                                                          email: _email,
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
                                                horizontal: 20, vertical: 20),
                                            textStyle: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            shadowColor: Colors.grey,
                                          ),
                                          onPressed: () {
                                            // Validate returns true if the form is valid, or false otherwise.
                                            if (_formKey.currentState!
                                                .validate()) {
                                              BlocProvider.of<
                                                          AuthenticationBloc>(
                                                      context)
                                                  .add(UpdatePass(
                                                      username: _username,
                                                      email: _email,
                                                      password: _password));
                                            }
                                          },
                                          child: const Text('Submit'),
                                        )
                                      ]),
                                ))))
                  ]))
                ]))));
  }
}
