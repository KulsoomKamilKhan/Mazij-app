import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:Mazaj/bloc/post_bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Mazaj/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class CreatePosts extends StatelessWidget {
  String post = '';
  String user = '';
  String caption = 'Uploaded to Mazaj!';
  int upvotes = 0;
  String collaborators = '';

  CreatePosts(
      this.post, this.user, this.caption, this.upvotes, this.collaborators,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<PostBloc, PostState>(listener: (context, state) {
      if (state is PostCreated) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      }
    }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is PostLoading) {
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
        } else if (state is PostError) {}
        return CustomForm(post, user, caption, upvotes, collaborators);
      },
    )));
  }
}

class CustomForm extends StatefulWidget {
  String post = '';
  String user = '';
  String caption = 'Uploaded to Mazaj!';
  int upvotes = 0;
  String collaborators = '';
  CustomForm(
      this.post, this.user, this.caption, this.upvotes, this.collaborators,
      {Key? key})
      : super(key: key);
  //const CustomForm({Key? key}) : super(key: key);

  @override
  CustomFormState createState() {
    return CustomFormState();
  }
}

class CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var _bytesImage = Base64Decoder().convert(widget.post);
    return Form(
        //Form widget using the _formKey created above.
        key: _formKey,
        child: SafeArea(
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.pink.shade200,
                    Colors.purple.shade600,
                    const Color(0xFF068EE9),
                  ],
                )),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(children: [
                  const Text('Create Post',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                      child: Container(
                          width: 500,
                          height: 400,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.2),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: ListView(children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4.3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.4,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.memory(
                                                    _bytesImage,
                                                  ).image,
                                                ))),
                                      ),
                                      const SizedBox(
                                        height: 35,
                                      ),
                                      Container(
                                        width: 500.0,
                                        child: TextField(
                                          maxLength: 100,
                                          keyboardType: TextInputType.name,
                                          //controller: TextEditingController(text: _caption),
                                          decoration: InputDecoration(
                                            fillColor: Colors.grey,
                                            hintText:
                                                "Max 100 characters, separate by commas",
                                            label: const Text('Content Tag',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            icon: const Icon(
                                              Icons.note,
                                              color: Colors.amber,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.amber.shade600),
                                              borderRadius:
                                                  BorderRadius.circular(85),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.amber.shade600),
                                              borderRadius:
                                                  BorderRadius.circular(85),
                                            ),
                                          ),
                                          onChanged: (val) {
                                            widget.caption = val;
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.amber,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          shadowColor: Colors.grey,
                                        ),
                                        onPressed: () {
                                          //Navigator.of(context).pushNamed('/home');
                                          //widget.user);
                                          //widget.collaborators);

                                          context
                                              .read<PostBloc>()
                                              .add(CreatePost(
                                                post: widget.post,
                                                user: widget.user,
                                                caption: widget.caption,
                                                upvotes: widget.upvotes,
                                                collaborators: widget.user,
                                              ));
                                        },
                                        child: const Text('Upload',
                                            style: const TextStyle(
                                                color: Colors.black)),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ]),
                              ]))))
                ]))));
  }
}
