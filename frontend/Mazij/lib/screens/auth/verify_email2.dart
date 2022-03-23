import 'package:Mazaj/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:Mazaj/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class Verify2 extends StatefulWidget {
  User user;
  String code;
  Verify2(this.user, this.code, {Key? key}) : super(key: key);

  @override
  State<Verify2> createState() => _Verify2State();
}

class _Verify2State extends State<Verify2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
      if (state is AccountUpdated) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false);
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
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              shapePath: _buildSpeechBubblePath(),
            ),
          );
        } else if (state is AuthenicationError) {}
        return CustomForm(widget.user, widget.code);
      },
    )));
  }
}

class CustomForm extends StatefulWidget {
  User user;
  String code;
  CustomForm(this.user, this.code, {Key? key}) : super(key: key);

  @override
  CustomFormState createState() {
    return CustomFormState();
  }
}

class CustomFormState extends State<CustomForm> {
  //Global key uniquely identifies the Form widget and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  String givencode = '';

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
                    Color(0xFF326EF1),
                    Colors.purple,
                  ],
                )),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(children: [
                  Expanded(
                    child: ListView(children: [
                      const Text('Verify Email Address',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                          width: 500,
                          height: 300,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 550,
                              height: 500,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Please enter the verification code sent to your registered email address.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 30),
                                    Container(
                                      width: 500.0,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          label: const Text('Verification Code',
                                              style: TextStyle(fontSize: 18)),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(85),
                                          ),
                                        ),
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter the verification code';
                                          }
                                          return null;
                                        },

                                        onChanged: (val) {
                                          givencode = val;
                                        },
                                        onFieldSubmitted: (value) {
                                          setState(() {
                                            if (_formKey.currentState!
                                                    .validate() &&
                                                givencode.compareTo(
                                                        widget.code) ==
                                                    0) {
                                              
                                              BlocProvider.of<
                                                          AuthenticationBloc>(
                                                      context)
                                                  .add(UpdateAccount(
                                                      firstname: widget
                                                          .user.first_name,
                                                      lastname:
                                                          widget.user.last_name,
                                                      email: widget.user.email,
                                                      password:
                                                          widget.user.passwords,
                                                      account_type: widget
                                                          .user.account_type));
                                              //}
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.purple,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 30),
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        shadowColor: Colors.grey,
                                      ),
                                      onPressed: () {
                                        // Validate returns true if the form is valid, or false otherwise.
                                        if (_formKey.currentState!.validate() &&
                                            givencode.compareTo(widget.code) ==
                                                0) {
                                        
                                          BlocProvider.of<AuthenticationBloc>(
                                                  context)
                                              .add(UpdateAccount(
                                                  firstname:
                                                      widget.user.first_name,
                                                  lastname:
                                                      widget.user.last_name,
                                                  email: widget.user.email,
                                                  password:
                                                      widget.user.passwords,
                                                  account_type: widget
                                                      .user.account_type));
                                          //}
                                        }
                                      },
                                      child: const Text('Submit'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                    ]),
                  )
                ]))));
  }
}
