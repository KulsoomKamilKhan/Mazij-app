import 'package:Mazaj/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Mashup",
              body: "Unleash your creativity!",
              image: Image.asset("assets/o1.png"),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "Collaborate",
              body: "...because we are better together!",
              image: Image.asset('o2.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "Share",
              body: "​Experience the joy in sharing!",
              image: buildImage('o3.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Join a Global Platform',
              body: 'Start your journey with Mazij',
              image: buildImage('o4.png'),
              // footer: ButtonWidget(
              //   text: 'Start Reading',
              //   onClicked: () => goToHome(context),
              // ),

              decoration: getPageDecoration(),
            ),
          ],
          done: Text("Let's get Started!",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: Text('Skip',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
          onSkip: () => goToHome(context),
          next: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Theme.of(context).primaryColor,
          skipOrBackFlex: 0,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => WelcomePage()),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Colors.white,
        activeColor: Colors.purpleAccent,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        // descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
