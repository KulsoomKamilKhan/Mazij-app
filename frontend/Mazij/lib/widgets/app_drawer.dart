import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({Key? key}) : super(key: key);

  _launchURL() async {
    // redirect user to the company website for the 'About' option
    const url = 'https://aboutmazij.weebly.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future removeUserData() async {
    // to store that user is not logged in, may be useful for future
    const storage = FlutterSecureStorage();
    await storage.write(key: 'login', value: 'false');
    print('logged out');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // side menu
      child: SingleChildScrollView(
          // to scroll down a single widget
          child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                // to display one below the other
                children: <Widget>[
                  const SizedBox(
                    height: 55,
                    child: DrawerHeader(
                      child: Text(
                        "More",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  ListTile(
                      leading: const Icon(Icons.update),
                      title: const Text("Update Account"),
                      onTap: () {
                        Navigator.of(context).pushNamed('/update');
                      }),
                  ListTile(
                      leading: const Icon(Icons.question_answer),
                      title: const Text("FAQ"),
                      onTap: () {
                        Navigator.of(context).pushNamed('/faq');
                      }),
                  ListTile(
                      leading: const Icon(Icons.admin_panel_settings),
                      title: const Text("Privacy Policy"),
                      onTap: () {
                        Navigator.of(context).pushNamed('/privacy');
                      }),
                  ListTile(
                      leading: const Icon(Icons.auto_stories),
                      title: const Text("Terms and Conditions"),
                      onTap: () {
                        Navigator.of(context).pushNamed('/termsandcond');
                      }),
                  ListTile(
                      leading: const Icon(Icons.delete_forever),
                      title: const Text("Delete Account",
                          style: TextStyle(color: Colors.red)),
                      onTap: () {
                        Navigator.of(context).pushNamed('/delete');
                      }),
                  const SizedBox(height: 90),
                  ListTile(
                      leading: const Icon(Icons.logout_rounded),
                      title: const Text("Logout",
                          style: TextStyle(color: Colors.red)),
                      onTap: () {
                        removeUserData();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/welcome',
                            (route) =>
                                false); // user can not press the back button after logging out to come back to the home screens
                      }),
                  ListTile(
                    leading: Image.asset(
                      'assets/logo.png',
                      width: 30,
                    ),
                    title: const Text("About"),
                    trailing: IconButton(
                      icon: const Icon(
                          Icons.keyboard_arrow_right), // or leading only
                      onPressed: _launchURL,
                    ),
                  ),
                ],
              ))),
    );
  }
}
