import 'dart:math';
import 'package:Mazaj/data/models/user_model.dart';
import 'package:Mazaj/data/repositories/user_repo.dart';
import 'package:Mazaj/screens/auth/verify_email2.dart';
import 'package:flutter/material.dart';
import 'package:Mazaj/widgets/app_bar.dart';
import 'package:Mazaj/widgets/app_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Mazaj/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class Update extends StatelessWidget {
  const Update({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CustomForm());
    //)));
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
  // String _firstName = '';
  // String _lastName = '';
  // String _email = '';
  // String _password = '';
  // String _username = '';
  // String _dob= '';
  // String _account_type = '';
  bool _passwordVisible = false;

  final _usertypes = [
    "General",
    "Artist",
    "Student",
    "Content Creator",
    "Business Marketer"
  ];

  String ac(String type) {
    String acc = '';
    switch (type) {
      case "A":
        acc = "Artist";
        break;
      case "G":
        acc = "General";
        break;
      case "S":
        acc = "Student";
        break;
      case "CC":
        acc = "Content Creator";
        break;
      case "BM":
        acc = "Brand Marketer";
        break;
    }
    return acc;
  }

  void mapDropDownCode(value) {
    switch (value) {
      case "General":
        user.account_type = "G";
        break;
      case "Artist":
        user.account_type = "A";
        break;
      case "Student":
        user.account_type = "S";
        break;
      case "Content Creator":
        user.account_type = "CC";
        break;
      case "Business Marketer":
        user.account_type = "BM";
        break;
      default:
        user.account_type = "G";
        break;
    }
    print("after sc");
    print(value);
    print(user.account_type);
  }

  //Future<String> getUsername() async {
  // var storage = const FlutterSecureStorage();
  // var username = (await storage.read(key: 'username')).toString();
  // return username;
  Future<Map<String, String>> getDetails() async {
    // to retrieve details from flutter secure storage
    final Map<String, String> _details = {
      'firstname': '',
      'lastname': '',
      'username': '',
      'email': '',
      'accounttype': '',
      'dob': '',
    };
    var storage = const FlutterSecureStorage();
    _details['username'] = (await storage.read(key: 'username')).toString();
    _details['firstname'] = (await storage.read(key: 'firstname')).toString();
    _details['lastname'] = (await storage.read(key: 'lastname')).toString();
    _details['email'] = (await storage.read(key: 'email')).toString();
    _details['accounttype'] =
        (await storage.read(key: 'accounttype')).toString();
    _details['dob'] = (await storage.read(key: 'dateofbirth')).toString();
    return _details;
  }

  // void getU() async {
  //   _username = await getUsername();
  // }
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      details = await getDetails();
      if (mounted) setState(() {});
    });
    super.initState();
  }

  Map<String, String> details = {
    'firstname': '',
    'lastname': '',
    'username': '',
    'email': '',
    'accounttype': '',
    'dob': ''
  };
  final String _dropdownValue = "General";

  final user = User(
      username: "",
      first_name: "",
      last_name: "",
      email: "",
      account_type: "",
      date_of_birth: "",
      passwords: "");

  @override
  Widget build(BuildContext context) {
    user.first_name = details['firstname']!;
    user.last_name = details['lastname']!;
    user.username = details['username']!;
    user.email = details['email']!;
    user.account_type = details['accounttype']!;
    user.date_of_birth = details['dob']!;

    return SafeArea(
        child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                //  image: DecorationImage(image: Image.asset("assets/logo.png").image, opacity: 0.4, fit: BoxFit.contain),
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF068EE9),
                Colors.purple.shade600,
                Colors.pink.shade200
              ],
            )),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
                //Form widget using the _formKey created above
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
                          iconSize: 40,
                          tooltip: 'Home',
                          onPressed: () {
                            Navigator.of(context).pushNamed('/home');
                          },
                        ),
                      ),
                      Container(
                          width: 550,
                          height: 750,
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
                                  const Text('Update Account Details',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    'Replace existing values with updated values in fields you choose to update',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  Container(
                                    width: 500.0,
                                    child: TextFormField(
                                      controller: TextEditingController(
                                          text: user.first_name),
                                      keyboardType: TextInputType.name,
                                      style: TextStyle(color: Colors.white),
                                      cursorColor: Colors.yellow,
                                      decoration: InputDecoration(
                                        label: const Text('First Name',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white)),
                                        icon: const Icon(
                                          Icons.person_pin_rounded,
                                          color: Colors.white,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(85),
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
                                          return 'Please your First Name';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        user.first_name = val;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 500.0,
                                    child: TextFormField(
                                      keyboardType: TextInputType.name,
                                      controller: TextEditingController(
                                          text: user.last_name),
                                      style: TextStyle(color: Colors.white),
                                      cursorColor: Colors.yellow,
                                      decoration: InputDecoration(
                                        label: const Text('Last Name',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white)),
                                        icon: const Icon(
                                          Icons.person_pin_rounded,
                                          color: Colors.white,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(85),
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
                                          return 'Please enter your Last Name';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        user.last_name = val;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 500.0,
                                    child: TextFormField(
                                      controller: TextEditingController(
                                          text: user.email),
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(color: Colors.white),
                                      cursorColor: Colors.yellow,
                                      decoration: InputDecoration(
                                        label: const Text('Email Address',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white)),
                                        icon: const Icon(Icons.email,
                                            color: Colors.white),
                                        hintText: 'e.g. abc@xyz.com',
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(85),
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
                                          return 'Please enter your email address';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        user.email = val;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 500.0,
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      cursorColor: Colors.yellow,
                                      obscureText: !_passwordVisible,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                        label: const Text('Password',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white)),
                                        icon: const Icon(Icons.password,
                                            color: Colors.white),
                                        hintText:
                                            'Include numbers, uppercase and special characters',
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.amber.shade200,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          },
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(85),
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
                                        if (value.length < 8) {
                                          return 'Please ensure the password has a minimum of 8 characters';
                                        }
                                        if (!value.contains(RegExp(r'[A-Z]'))) {
                                          return 'Please include an uppercase character';
                                        }
                                        if (!value.contains(RegExp(r'[0-9]'))) {
                                          return 'Please include a number';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        //getU();
                                        var saltedPass =
                                            user.username.toString() + val;
                                        var bytes = utf8.encode(saltedPass);
                                        var digest = sha256.convert(bytes);
                                        user.passwords = digest.toString();
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                      width: 500.0,
                                      child: DropdownButtonFormField<String>(
                                        value: _dropdownValue,
                                        decoration: InputDecoration(
                                          counterText: ac(user.account_type),
                                          label: const Text('Account Type',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(85),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(85),
                                          ),
                                        ),
                                        icon: const Icon(Icons.arrow_right,
                                            color: Colors.white),
                                        items: _usertypes
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,
                                                style: TextStyle(
                                                    color: Colors.purple)),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            mapDropDownCode(newValue);
                                          });
                                        },
                                      )),
                                  const SizedBox(height: 30),
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
                                      // Validate returns true if the form is valid, or false otherwise.
                                      if (_formKey.currentState!.validate()) {
                                        int code = 0;
                                        code = 11111111 +
                                            Random().nextInt(99999999);
                                        print(code.toString());
                                        UserRepository _userrepo =
                                            UserRepository();
                                        print("in update");
                                        print(user.account_type);
                                        // User user = User(first_name: _firstName, last_name: _lastName,
                                        //  username: _username, account_type: _account_type, date_of_birth: _dob, email: _email, passwords: _password);

                                        _userrepo.sendEmail(
                                            user, code.toString());

                                        _userrepo.sendEmail(
                                            user, code.toString());

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Verify2(user, code.toString()),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text('Next'),
                                  ),
                                ]),
                          ))
                    ])
                  ]))
                ]))));
  }
}
