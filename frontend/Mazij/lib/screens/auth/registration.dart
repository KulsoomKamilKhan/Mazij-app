import 'dart:convert';
import 'dart:math';
import 'package:Mazaj/data/models/user_model.dart';
import 'package:Mazaj/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:Mazaj/data/repositories/user_repo.dart';
import 'package:Mazaj/screens/auth/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CustomForm());
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
  //Global key uniquely identifies the Form widget and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  final _usertypes = [
    "General",
    "Artist",
    "Student",
    "Content Creator",
    "Brand Marketer"
  ];

  final String _dropdownValue = "General";
  final user = User(
      username: "",
      first_name: "",
      last_name: "",
      email: "",
      account_type: "G",
      date_of_birth: "",
      passwords: "");

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
      case "Brand Marketer":
        user.account_type = "BM";
        break;
      default:
        user.account_type = "G";
        break;
    }
  }

  bool _passwordVisible = false;
  UserRepository _userrepo = UserRepository();
  List<User> users = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      users = await _userrepo.GetUsers();
      if (mounted) setState(() {});
    });
    super.initState();
  }

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
                  decoration: BoxDecoration(
                      //image: DecorationImage (image: Image.asset("assets/logo.png").image, opacity: 0.3),
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF068EE9),
                      Colors.purple.shade600,
                      Colors.pink.shade200
                    ],
                  )),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          height: 500,
                          width: 500,
                          child: Image.asset("assets/logo.png")),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      flex: 2,
                      child: ListView(children: [
                        Container(
                            width: 150,
                            height: 900,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Sign Up',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 50,
                                          fontWeight: FontWeight.w700)),
                                  const SizedBox(
                                    height: 60,
                                  ),
                                  Container(
                                    width: 500.0,
                                    child: TextFormField(
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
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your first name';
                                        }
                                        return null;
                                      },

                                      onChanged: (val) {
                                        user.first_name = val;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 500.0,
                                    child: TextFormField(
                                      keyboardType: TextInputType.name,
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
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your last name';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        user.last_name = val;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 500.0,
                                    child: TextFormField(
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
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email address';
                                        }
                                        int i = 0;
                                        while (i < users.length) {
                                          if (value.compareTo(users[i].email) ==
                                              0) {
                                            return 'There is an account associated with this email address already';
                                          }
                                          i++;
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        user.email = val;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 500.0,
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      cursorColor: Colors.yellow,
                                      decoration: InputDecoration(
                                        label: const Text('Username',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white)),
                                        icon: const Icon(Icons.person,
                                            color: Colors.white),
                                        hintText: 'e.g. firstname_lastname',
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
                                          return 'Please enter a username';
                                        }
                                        if (value.length < 3) {
                                          return 'Please enter a longer username';
                                        }
                                        int i = 0;
                                        while (i < users.length) {
                                          if (value.compareTo(
                                                  users[i].username) ==
                                              0) {
                                            return 'There is an account associated with this username already';
                                          }
                                          i++;
                                        }
                                        return null;
                                        //return null;
                                      },
                                      onChanged: (val) {
                                        user.username = val;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
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
                                            'Include numbers and uppercase and special characters!',
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
                                        var saltedPass = user.username + val;
                                        var bytes = utf8.encode(saltedPass);
                                        var digest = sha256.convert(bytes);
                                        user.passwords = digest.toString();
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Container(
                                    width: 500.0,
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      cursorColor: Colors.yellow,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        label: const Text('Date Of Birth',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white)),
                                        icon: const Icon(Icons.calendar_today,
                                            color: Colors.white),
                                        hintText: 'YYYY-MM-DD',
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
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your date of birth';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        user.date_of_birth = val;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Container(
                                    width: 500.0,
                                    child: DropdownButtonFormField<String>(
                                      value: _dropdownValue,
                                      decoration: InputDecoration(
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
                                    ),
                                  ),
                                  const SizedBox(height: 30),
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
                                      if (_formKey.currentState!.validate()) {
                                        int code = 0;
                                        code = 11111111 +
                                            Random().nextInt(99999999);
                                        print(code.toString());
                                        _userrepo.sendEmail(
                                            user, code.toString());

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Verify(user, code.toString()),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text('Next'),
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    child: const Text(
                                      "Do you have an account already? Click here to login!",
                                      style: TextStyle(
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pushNamed('/login');
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            )),
                        const SizedBox(height: 20),
                        const Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              '\u00a9 Mazij',
                              style: TextStyle(color: Colors.white),
                            )),
                      ]),
                    )
                  ]))));
    }
    return Form(
        //Form widget using the _formKey created above.
        key: _formKey,
        child: SafeArea(
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    // image: DecorationImage(
                    //     image: Image.asset("assets/logo.png").image,
                    //     opacity: 0.4,
                    //     fit: BoxFit.contain),
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF068EE9),
                    Colors.purple.shade600,
                    Colors.pink.shade200
                  ],
                )),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(children: [
                  // Expanded(
                  //   flex: 1,
                  //   child: Image.asset("assets/logo.png"),
                  // ),
                  // const SizedBox(width: 50),
                  Expanded(
                    flex: 2,
                    child: ListView(children: [
                      Container(
                          width: 150,
                          height: 960,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.3),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Sign Up',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w700)),
                                const SizedBox(
                                  height: 60,
                                ),
                                Container(
                                  width: 500.0,
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    cursorColor: Colors.yellow,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      label: const Text('First Name',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                      icon: const Icon(Icons.person_pin_rounded,
                                          color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(85),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(85),
                                      ),
                                    ),
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your first name';
                                      }
                                      return null;
                                    },

                                    onChanged: (val) {
                                      user.first_name = val;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 500.0,
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    cursorColor: Colors.yellow,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      label: const Text('Last Name',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                      icon: const Icon(Icons.person_pin_rounded,
                                          color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(85),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(85),
                                      ),
                                    ),
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your last name';
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      user.last_name = val;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 500.0,
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    cursorColor: Colors.yellow,
                                    keyboardType: TextInputType.emailAddress,
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
                                        borderRadius: BorderRadius.circular(85),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(85),
                                      ),
                                    ),
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email address';
                                      }
                                      int i = 0;
                                      while (i < users.length) {
                                        if (value.compareTo(users[i].email) ==
                                            0) {
                                          return 'There is an account associated with this email address already';
                                        }
                                        i++;
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      user.email = val;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 500.0,
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    cursorColor: Colors.yellow,
                                    decoration: InputDecoration(
                                      label: const Text('Username',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                      icon: const Icon(Icons.person,
                                          color: Colors.white),
                                      hintText: 'e.g. firstname_lastname',
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(85),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(85),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a username';
                                      }
                                      if (value.length < 3) {
                                        return 'Please enter a longer username';
                                      }
                                      int i = 0;
                                      while (i < users.length) {
                                        if (value
                                                .compareTo(users[i].username) ==
                                            0) {
                                          return 'There is an account associated with this username already';
                                        }
                                        i++;
                                      }
                                      return null;
                                      //return null;
                                    },
                                    onChanged: (val) {
                                      user.username = val;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 500.0,
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    cursorColor: Colors.yellow,
                                    obscureText: !_passwordVisible,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      label: const Text('Password',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                      icon: const Icon(Icons.password,
                                          color: Colors.white),
                                      hintText:
                                          'Include numbers and uppercase and special characters!',
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
                                        borderRadius: BorderRadius.circular(85),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(85),
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
                                      var saltedPass = user.username + val;
                                      var bytes = utf8.encode(saltedPass);
                                      var digest = sha256.convert(bytes);
                                      user.passwords = digest.toString();
                                    },
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Container(
                                  width: 500.0,
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    cursorColor: Colors.yellow,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      label: const Text('Date Of Birth',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                      icon: const Icon(Icons.calendar_today,
                                          color: Colors.white),
                                      hintText: 'YYYY-MM-DD',
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(85),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(85),
                                      ),
                                    ),
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter your date of birth';
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      user.date_of_birth = val;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Container(
                                  width: 500.0,
                                  child: DropdownButtonFormField<String>(
                                    value: _dropdownValue,
                                    decoration: InputDecoration(
                                      label: const Text('Account Type',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(85),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(85),
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
                                  ),
                                ),
                                const SizedBox(height: 30),
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
                                    if (_formKey.currentState!.validate()) {
                                      int code = 0;
                                      code =
                                          11111111 + Random().nextInt(99999999);
                                      print(code.toString());
                                      _userrepo.sendEmail(
                                          user, code.toString());

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Verify(user, code.toString()),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text('Next'),
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  child: const Text(
                                    "Do you have an account already? Click here to login!",
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed('/login');
                                  },
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          )),
                      const SizedBox(height: 20),
                      const Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            '\u00a9 Mazij',
                            style: TextStyle(color: Colors.white),
                          )),
                    ]),
                  )
                ]))));
  }
}
