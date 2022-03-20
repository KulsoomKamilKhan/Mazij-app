import 'package:flutter/material.dart';
import 'package:Mazaj/widgets/app_drawer.dart';
import 'package:Mazaj/widgets/app_bar.dart';

class Faq extends StatelessWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: myAppBar("FAQs"),
        ),
        drawer: const SettingsDrawer(),
        body: SafeArea(
            child: Container(
                width: double.infinity, // spread gradient over entire width
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.purpleAccent,
                    Color(0xFF9CB5EB),
                    Colors.white,
                  ],
                )),
                child: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: <
                        Widget>[
                  Align(
                    alignment:
                        Alignment.topLeft, // align to the top left of the page
                    child: IconButton(
                      icon: const Icon(Icons.home_outlined),
                      color: const Color.fromRGBO(255,255,255,1),
                      iconSize: 45,
                      tooltip: 'Home',
                      onPressed: () {
                        Navigator.of(context).pushNamed('/home');
                      },
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                          top: 30, left: 50, right: 50, bottom: 30),
                    padding: const EdgeInsets.all(40),
                    decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              
                            ),
                      child: RichText(
                        // for a paragaraph
                        text: const TextSpan(
                          style: TextStyle(fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    '\n\nWhere can I find more about Mazij?\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'To access our company\'s website, check out aboutmazij.weebly.com or navigate to the settings drawer on the left of the pages and select the arrow beside \'About\' option to be redirected there.'),
                            TextSpan(
                                text: '\n\nHow do I contact Mazij?\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'You can email us at hwumazij@gmail.com or visit the \'Contact Us\' page at aboutmazij.weebly.com. '),
                            TextSpan(
                                text:
                                    '\n\nHow is my data is being used?\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'To know more about the usage of your data, check out out Privacy Policy which could be accessed from the settings drawer on the left of the pages. In case of any more doubts, email us at hwumazij@gmail.com'),
                            TextSpan(
                                text:
                                    '\n\nHow to logout from the application?\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'To logout, navigate to the settings drawer on the left of the pages and select the \'Logout\' option. You will de redirected to the welcome page and would have been logged out successfully.'),
                            TextSpan(
                                text: '\n\nHow to update account details?\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'Click on the \'Update Account\' option in the settings drawer on the left. Fill in the form with your updated details. If you do not want to update any of the fields mentioned there, fill in with the existing information.'),
                            
                            TextSpan(
                                text:
                                    '\n\nHow to upload images?\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'Images can be uploaded from the button on the profile banner on the profile page and images uploaded will be displayed in your profile and they can be clicked-on to view more information regarding each.'),
                            TextSpan(
                                text:
                                    '\n\nHow can I follow other users?\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'Users\' profiles have a follow button which can be pressed on to follow that user. You can then view their posts in your Feed.'),
                            TextSpan(
                                text:
                                    '\n\nHow can I follow libraries?\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'Artist, Student and Content Creator libraries each have a follow button on the tab which can be pressed on to follow that library. You can then view those posts in your Feed.'),
                            TextSpan(
                                text:
                                    '\n\nHow can I search for users?\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'The Feed, Profile and Collaborate and Mashup pages have a search button which can be pressed on to search for users.'),
                            TextSpan(
                                text:
                                    '\n\nHow can I find posts by tags?\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'The Library page has a search button which can be pressed on to search by tags.'),
                            TextSpan(
                                text:
                                    '\n\nHow to use this application to mashup?\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'Posts could be edited to mashup when clicked on the Collaborate and Mashup icon. Draw on the images, insert text or stickers or draw shapes. You will be directed to the mashup and collaborate page where you could start with the mashup process. Click on the image icon on the bottom-right to download your edited pictures or share on Mazij! Drafts can be saved too to be worked on later.'),
                            TextSpan(
                                text:
                                    '\n\nHow can I get images for mashup?\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'The top bar on the Collaborate and Mashup page has an option to upload images for mashup. The picture could be from your device, any user profile which can be searched by users or tags or, your drafts could be reused. '),
                            
                            TextSpan(
                                text:
                                    '\n\nHow to collaborate with other users on the platform?\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'Click on the Collaborate and Mashup icon to accesss that page, click on the chat icon to start collaborating. Add users to the chat while you edit posts'),
                            TextSpan(
                                text: '\n\nHow do I delete my Mazij account?\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'We are sorry to let you down... if you wish to delete your account on Mazij, navigate to the settings drawer on the left of the pages and select the \'Delete Account\' option. You will then be redirected to the welcome page and your account would have been deleted. '),
                          ],
                        ),
                      )),
                ])))));
  }
}
