import 'package:Mazaj/data/models/user_model.dart';
import 'package:Mazaj/screens/auth/delete_acount.dart';
import 'package:Mazaj/screens/auth/forgot_password.dart';
import 'package:Mazaj/screens/auth/login_page.dart';
import 'package:Mazaj/screens/auth/update_account.dart';
import 'package:Mazaj/screens/auth/verify_email.dart';
import 'package:Mazaj/screens/auth/verify_email2.dart';
import 'package:Mazaj/screens/profiles/profile_screen.dart';
import 'package:Mazaj/screens/welcome.dart';
import 'package:Mazaj/widgets/home.dart';
import 'package:Mazaj/widgets/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'router.dart';
import 'package:Mazaj/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:Mazaj/bloc/post_bloc/post_bloc.dart';
import 'package:Mazaj/bloc/profile_bloc/profile_bloc.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
// Import the generated file
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]); // to display the app in potrait mode only

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp()); // to run the widget on screen
}

// root widget
class MyApp extends StatefulWidget {
  // stateless widget because we do not need to change the state of this widget
  const MyApp({Key? key})
      : super(key: key); 
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 // key is an identifier for the widgets
 var storage = const FlutterSecureStorage();
 String login = "false";
 @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      login = (await storage.read(key: 'login')).toString();
      print(login);
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override // This annotation is recognized by the Dart analyzer, and it allows the analyzer to provide hints or warnings for some potential problems
  Widget build(BuildContext context) {
    // final user = User(
    //     username: "",
    //     first_name: "",
    //     last_name: "",
    //     email: "",
    //     account_type: "G",
    //     date_of_birth: "",
    //     passwords: "");

    // build to build/return the UI of the widget,
    // run everytime any widgets inside build are updated too
    // context is a BuildContext instance which gets passed to the builder of a widget in order to let it know where it is inside the Widget Tree of the app
    return MultiBlocProvider(
        // for all the BLOC providers used in the app
        providers: [
          BlocProvider<AuthenticationBloc>(
            // to create authentication BLOC instance for the child to use in the screen
            create: (context) => AuthenticationBloc(),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(),
          ),
          BlocProvider<PostBloc>(
            create: (context) => PostBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner:
              false, // to avoid showing the debug banner on the top-left
          title: 'Mazij',
          theme: ThemeData(
            textTheme:
                GoogleFonts.robotoSlabTextTheme(Theme.of(context).textTheme),
            visualDensity: VisualDensity
                .adaptivePlatformDensity, // to define compactness of widgets according to the platform
          ),
          home: AnimatedSplashScreen(
              duration: 2000,
              splash: "assets/logo.png",
              nextScreen: (login.compareTo("false")==0)? OnBoardingPage() : const Home(),
              splashTransition: SplashTransition.rotationTransition,
              pageTransitionType: PageTransitionType.topToBottom,
              backgroundColor: Colors.lightBlue),
          onGenerateRoute:
              RouterClass.generateRoute, // for all named routes in the app
          //initialRoute: '/',
        ));
  }
}

// import 'package:Mazaj/const.dart';
// import 'package:Mazaj/screens/chat/home.dart';
// import 'package:flutter/material.dart';


// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: appTitle,
//       home: const Home(),
//     );
//   }
// }

