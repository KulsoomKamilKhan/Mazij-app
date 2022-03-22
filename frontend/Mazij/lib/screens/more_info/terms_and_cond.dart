import 'package:flutter/material.dart';
import 'package:Mazaj/widgets/home.dart';
import 'package:Mazaj/widgets/app_drawer.dart';
import 'package:Mazaj/widgets/app_bar.dart';
import 'package:flutter/services.dart'
    show rootBundle; // for displaying the file

class TermsAndCond extends StatefulWidget {
  const TermsAndCond({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TermsAndCondState();
}

class _TermsAndCondState extends State<TermsAndCond> {
  String data = '';

  // _loadAsset() async {
  //   String text = await rootBundle.loadString('termsandcond.txt');

  //   setState(() {
  //     data = text;
  //   });
  // }

  // @override
  // void initState() {
  //   _loadAsset();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: myAppBar("Terms and Conditions"),
        ),
        drawer: const SettingsDrawer(),
        body: SafeArea(
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset("assets/logo.png").image,
                        opacity: 0.3),
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
                    child: Column(children: <Widget>[
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
                    margin: const EdgeInsets.only(
                        top: 25, left: 55, right: 55, bottom: 50),
                    padding: const EdgeInsets.all(40),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Text(
                      '''
Last updated: January 22, 2022

Welcome to Mazij!

These terms and conditions outline the rules and regulations for the use of Mazij.

By accessing this website we assume you accept these terms and conditions. Do not continue to use Mazij if you do not agree to take all of the terms and conditions stated on this page.

The following terminology applies to these Terms and Conditions: "Client", "You" and "Your" refers to you, the person log on this website and compliant to the Company’s terms and conditions. "The Company", "Ourselves", "We", "Our" and "Us", refers to our Company. "Party", "Parties", or "Us", refers to both the Client and ourselves.

License
Unless otherwise stated, Mazij and/or its licensors own the intellectual property rights for all material on Mazij. All intellectual property rights are reserved. You may access this for your own personal use subjected to restrictions set in these terms and conditions.

You must not:

Republish material from Mazij
Sell, rent or sub-license material from Mazij
Redistribute content from Mazij
Systematically retrieve data or other content from the Application to create or compile, directly or indirectly, a collection, compilation, database, or directory without written permission from us.
Make any unauthorized use of the Application, including collecting usernames and/or email addresses of users by electronic or other means for the purpose of sending unsolicited email, or creating user accounts by automated means or under false pretenses.
Engage in unauthorized framing of or linking to the Application.
Trick, defraud, or mislead us and other users, especially in any attempt to learn sensitive account information such as user passwords;

Make improper use of our support services or submit false reports of abuse or misconduct.
Engage in any automated use of the system, such as using scripts to send comments or messages, or using any data mining, robots, or similar data gathering and extraction tools.
Interfere with, disrupt, or create an undue burden on the Application or the networks or services connected to the Application.
Attempt to impersonate another user or person or use the username of another user.
Sell or otherwise transfer your profile.
Use any information obtained from the Application in order to harass, abuse, or harm another person.

Use the Application as part of any effort to compete with us or otherwise use the Application and/or the Content for any revenue-generating endeavor or commercial enterprise.
Decipher, decompile, disassemble, or reverse engineer any of the software comprising or in any way making up a part of the Application.
Attempt to bypass any measures of the Application designed to prevent or restrict access to the Application, or any portion of the Application.
Harass, annoy, intimidate, or threaten any of our employees or agents engaged in providing any portion of the Application to you.
Delete the copyright or other proprietary rights notice from any Content.
Copy or adapt the Application’s software, including but not limited to Flash, PHP, HTML, JavaScript, or other code.

Upload or transmit (or attempt to upload or to transmit) viruses, Trojan horses, or other material, including excessive use of capital letters and spamming (continuous posting of repetitive text), that interferes with any party’s uninterrupted use and enjoyment of the Application or modifies, impairs, disrupts, alters, or interferes with the use, features, functions, operation, or maintenance of the Application.
Upload or transmit (or attempt to upload or to transmit) any material that acts as a passive or active information collection or transmission mechanism, including without limitation, clear graphics interchange formats (“gifs”), 1×1 pixels, web bugs, cookies, or other similar devices (sometimes referred to as “spyware” or “passive collection mechanisms” or “pcms”).
Except as may be the result of standard search engine or Internet browser usage, use, launch, develop, or distribute any automated system, including without limitation, any spider, robot, cheat utility, scraper, or offline reader that accesses the Application, or using or launching any unauthorized script or other software.
Disparage, tarnish, or otherwise harm, in our opinion, us and/or the Application.
Use the Application in a manner inconsistent with any applicable laws or regulations.
Parts of this website offer an opportunity for users to post and exchange opinions and information in certain areas of the website. Provided that you are eligible to use the Application, you are granted a limited license to access and use the Application and to download or post a copy of the mashup created using posts on Mazij or any portion of the Content to which you have properly gained access solely for your personal, non-commercial use. We reserve all rights not expressly granted to you in and to the Application, Content, and the Marks.
You may be required to register with the Application. You agree to keep your password confidential and will be responsible for all use of your account and password. We reserve the right to remove, reclaim, or change a username you select if we determine, in our sole discretion, that such username is inappropriate, obscene, or otherwise objectionable. 


You are the creator and owner of or have the necessary licenses, rights, consents, releases, and permissions to use and to authorize us, the Application, and other users of the Application to use your Contributions in any manner contemplated by the Application and these Terms of Use.
You have the written consent, release, and/or permission of each and every identifiable individual person in your Contributions to use the name or likeness of each and every such identifiable individual person to enable inclusion and use of your Contributions in any manner contemplated by the Application and these Terms of Use.
Your Contributions are not false, inaccurate, or misleading.
Your Contributions are not unsolicited or unauthorized advertising, promotional materials, pyramid schemes, chain letters, spam, mass mailings, or other forms of solicitation.
Your Contributions are not obscene, lewd, lascivious, filthy, violent, harassing, libelous, slanderous, or otherwise objectionable (as determined by us).
Your Contributions do not ridicule, mock, disparage, intimidate, or abuse anyone.
Your Contributions do not advocate the violent overthrow of any government or incite, encourage, or threaten physical harm against another.
Your Contributions do not violate any applicable law, regulation, or rule.
Your Contributions do not violate the privacy or publicity rights of any third party.
Your Contributions do not contain any material that solicits personal information from anyone under the age of 18 or exploits people under the age of 18 in a sexual or violent manner.
Your Contributions do not violate any federal or state law concerning child pornography, or otherwise intended to protect the health or well-being of minors;
Your Contributions do not include any offensive comments that are connected to race, national origin, gender, sexual preference, or physical handicap.
Your Contributions do not otherwise violate, or link to material that violates, any provision of these Terms of Use, or any applicable law or regulation.
Any use of the Application in violation of the foregoing violates these Terms of Use and may result in, among other things, termination or suspension of your rights to use the Application or if required stricter action would be taken.

Your Privacy
Please read Privacy Policy

Disclaimer
To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our website and the use of this website. Nothing in this disclaimer will:

limit or exclude our or your liability for death or personal injury;
limit or exclude our or your liability for fraud or fraudulent misrepresentation;
limit any of our or your liabilities in any way that is not permitted under applicable law; or
exclude any of our or your liabilities that may not be excluded under applicable law.
The limitations and prohibitions of liability set in this Section and elsewhere in this disclaimer: (a) are subject to the preceding paragraph; and (b) govern all liabilities arising under the disclaimer, including liabilities arising in contract, in tort and for breach of statutory duty.
''',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ])))));
  }
}
