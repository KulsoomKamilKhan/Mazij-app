import 'dart:convert'; // for base46 encoding
import 'dart:html';
import 'dart:typed_data'; // for unsigned 8 byte integers' list
import 'package:Mazaj/bloc/post_bloc/post_bloc.dart';
import 'package:Mazaj/data/models/post_model.dart';
import 'package:Mazaj/screens/posts/create_posts.dart';
import 'package:Mazaj/screens/profiles/search_profile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:Mazaj/screens/posts/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:Mazaj/widgets/app_bar.dart';
import 'package:Mazaj/widgets/app_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String image = '';
  int id = -1;
  int upvotes = 0;
  List<Post>? posts;

  Map<String, String> details = {
    'firstname': '',
    'lastname': '',
    'username': '',
    'bio': '',
    'accounttype': '',
  };

  @override
  void initState() {
    loadPosts();
    super.initState();
  }

  loadPosts() async {
    BlocProvider.of<PostBloc>(context).add(const GetPostsByUsername());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text("Mazij",
                  style: TextStyle(
                      color: Color(0xB6326EF1),
                      fontSize: 32,
                      fontWeight: FontWeight.w700)),
              actions: <Widget>[
                // to dsiplay to the right
                IconButton(
                  icon: const Icon(Icons.search),
                  highlightColor: Colors.purple,
                  tooltip: "Search Users",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchProfile(),
                      ),
                    );
                  },
                ),
              ],
            )),
        drawer: const SettingsDrawer(),
        body: BlocListener<PostBloc, PostState>(
            listener: (context, state) {},
            child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
              if (state is PostLoading) {
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
              } else if (state is PostLoaded) {
                posts = state.posts;
                return profilepage(posts!);
              } else if (state is PostError) {}
              return ProfileInfo(0); // 0 posts
            })));
  }
}

Widget profilepage(List<Post> posts) {
  // for posts
  return SafeArea(
      child: Column(children: [
    Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ProfileInfo(posts.length),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
            sliver: SliverGrid(
              // Creates a sliver that places multiple box children in a grid acc to delegate
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing:
                    15, // pixels between each child along the main axis
              ),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                // delegate for child for slivers
                Post postobj = posts[index];
                // print("prof screen");
                // print(postobj.upvotes);
                return Container(
                  padding: ( // gap from left or right to screen
                      const EdgeInsets.only(left: 20.0)),
                  // : const EdgeInsets.only(right: 20.0)),
                  child: PostScreen(postobj),
                );
              }, childCount: posts.length),
            ),
          ),
        ],
      ),
    ),
  ]));
}

Future<Map<String, String>> getDetails() async {
  // to retrieve details from flutter secure storage
  final Map<String, String> _details = {
    'firstname': '',
    'lastname': '',
    'username': '',
    'profile_pic': '',
    'bio': '',
    'accounttype': '',
  };
  var storage = const FlutterSecureStorage();
  _details['username'] = (await storage.read(key: 'username')).toString();
  _details['firstname'] = (await storage.read(key: 'firstname')).toString();
  _details['lastname'] = (await storage.read(key: 'lastname')).toString();
  _details['profile_pic'] = (await storage.read(key: 'profile_pic')).toString();
  _details['bio'] = (await storage.read(key: 'bio')).toString();
  _details['accounttype'] = (await storage.read(key: 'accounttype')).toString();
  return _details;
}

class ProfileInfo extends StatefulWidget {
  // for profile banner
  int length; // number of posts
  ProfileInfo(this.length, {Key? key}) : super(key: key);
  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  static String url = 'assets/general.png'; // default profile picture
  String post = '';
  String user = '';
  String caption = 'Uploaded to Mazij!';
  String collaborators = '';
  int upvotes = 0;

  Map<String, String> details = {
    'firstname': '',
    'lastname': '',
    'username': '',
    'profile_pic': '',
    'bio': '',
    'accounttype': '',
  };

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      details = await getDetails();
      if (mounted) setState(() {});
    });
    super.initState();
  }

  dynamic galleryFile;

  Future imageSelectorGallery() async {
    FilePickerResult? image = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    );
    if (image != null) {
      Uint8List? imageBytes = image.files.first.bytes;
      String baseimage = base64Encode(imageBytes!);
      if (mounted) setState(() {});
      post = baseimage;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CreatePosts(post, user, caption, upvotes, collaborators)));
    } else {
      //"File Picker Error, image is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    user = details['username']!;
    var _bytesImage = const Base64Decoder().convert(details['profile_pic']!);

    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 270,
          padding: const EdgeInsets.all(10),
          child: Center(
              // center all widgets
              child: Column(children: <Widget>[
            Container(
                // for profile pic
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: CircleAvatar(
                  backgroundImage: Image.memory(
                    _bytesImage,
                  ).image,
                  radius: 35.0,
                )),
            Text(details['firstname']! + ' ' + details['lastname']!,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                )),
            Text(details['username']!,
                style: const TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w100,
                )),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              IconButton(
                onPressed: () => imageSelectorGallery(), // upload image
                icon: const Icon(
                  Icons.arrow_circle_up_rounded,
                  size: 35,
                  color: Colors.white70,
                ),
                tooltip: 'Upload Image',
              ),
              Column(children: [
                // number of posts
                const Text('Posts',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600)),
                Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(widget.length.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black45,
                        ))),
              ]),
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/bio'); // build profile page to update bio
                },
                icon: const Icon(
                  Icons.edit,
                  size: 30,
                  color: Colors.white70,
                ),
                tooltip: 'Edit Bio',
              )
            ]),
            const SizedBox(
              height: 15,
            ),
            Container(
                alignment: Alignment.center,
                width: 500,
                child: Text("\"${details['bio']!}\"",
                    style: const TextStyle(
                        //fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500))),
          ])),
          decoration: BoxDecoration(
            // gradient for entire container
            gradient: LinearGradient(colors: [
              Colors.pink.shade300,
              Colors.deepPurple.shade300,
              Color.fromARGB(255, 98, 147, 255),
            ]),
          ),
        )
      ],
    );
  }
}
