import 'package:Mazaj/bloc/post_bloc/post_bloc.dart';
import 'package:Mazaj/data/models/user_model.dart';
import 'package:Mazaj/screens/admin_panel/admin_dash.dart';
import 'package:Mazaj/screens/auth/verify_email.dart';
import 'package:Mazaj/screens/collab/collab_mashup.dart';
import 'package:Mazaj/screens/posts/create_posts.dart';
import 'package:Mazaj/screens/profiles/search_profile.dart';
import 'package:Mazaj/screens/search/search_bar.dart';
import 'package:Mazaj/widgets/collab_home.dart';
import 'package:Mazaj/widgets/feed_home.dart';
import 'package:Mazaj/widgets/lib_home.dart';
import 'package:Mazaj/widgets/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:Mazaj/screens/profiles/create_profile.dart';
import 'package:Mazaj/screens/auth/forgot_password.dart';
import 'package:Mazaj/screens/auth/login_page.dart';
import 'package:Mazaj/screens/auth/registration.dart';
import 'package:Mazaj/screens/auth/delete_acount.dart';
import 'package:Mazaj/screens/more_info/terms_and_cond.dart';
import 'package:Mazaj/screens/auth/update_account.dart';
import 'package:Mazaj/screens/welcome.dart';
import 'package:Mazaj/screens/more_info/faq.dart';
import 'package:Mazaj/widgets/home.dart';
import 'package:Mazaj/screens/more_info/privacypage.dart';
import 'package:Mazaj/screens/profiles/profile_screen.dart';
// import 'package:Mazaj/screens/libraries.dart';
// import 'package:Mazaj/screens/feed.dart';
// import 'package:Mazaj/screens/collab_mashup.dart';

// commented routes added for easy testing and debugging
class RouterClass {
  static const String welcomeRoute = '/';
  static const String profhomeRoute = '/home';
  static const String libHomeRoute = '/lib';
  static const String bioRoute = '/bio';
  static const String searchRoute = '/search';
  static const String searchPRoute = '/searchp';
  //static const String captionRoute = '/caption';
  static const String faqRoute = '/faq';
  static const String privacyRoute = '/privacy';
  static const String termsAndCondRoute = '/termsandcond';
  static const String registerRoute = '/register';
  static const String forgotPassRoute = '/forgot';
  static const String loginRoute = '/login';
  static const String deleteRoute = '/delete';
  static const String updateRoute = '/update';
  static const String createProfileRoute = '/createprofile';
  static const String adminRoute = '/admin';
  static const String feedHomeRoute = '/feed';
  static const String collabRoute = '/collabandmashup';
  // static const String libRoute = '/libraries';
  static const String profileRoute = '/profile';
  static const String verifyRoute = '/verify';
  static const String introRoute = '/intro';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final user = User(
        username: "",
        first_name: "",
        last_name: "",
        email: "",
        account_type: "G",
        date_of_birth: "",
        passwords: "");

    switch (settings.name) {
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case profhomeRoute:
        return MaterialPageRoute(builder: (_) => const Home());
      case libHomeRoute:
        return MaterialPageRoute(builder: (_) => const LibHome());
      case bioRoute:
        return MaterialPageRoute(builder: (_) => const CreateProfile());
      case searchRoute:
        return MaterialPageRoute(builder: (_) => const Search());
      case searchPRoute:
        return MaterialPageRoute(builder: (_) => const SearchProfile());
      case faqRoute:
        return MaterialPageRoute(builder: (_) => const Faq());
      case privacyRoute:
        return MaterialPageRoute(builder: (_) => const Privacy());
      case termsAndCondRoute:
        return MaterialPageRoute(builder: (_) => const TermsAndCond());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => const Registration());
      case forgotPassRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case deleteRoute:
        return MaterialPageRoute(builder: (_) => const Delete());
      case updateRoute:
        return MaterialPageRoute(builder: (_) => const Update());
      case feedHomeRoute:
        return MaterialPageRoute(builder: (_) => const FeedHome());
      case collabRoute:
        return MaterialPageRoute(builder: (_) => const CollabMashupHome());
      // case libRoute:
      //   return MaterialPageRoute(builder: (_) => const Libraries());
      case profileRoute:
        return MaterialPageRoute(builder: (_) => const Profile());
      case createProfileRoute:
        return MaterialPageRoute(builder: (_) => const CreateProfile());
      case verifyRoute:
        return MaterialPageRoute(builder: (_) => Verify(user, "1234567"));
      case adminRoute:
        return MaterialPageRoute(builder: (_) => const DashBoard());
      case introRoute:
        return MaterialPageRoute(builder: (_) => const IntroPages());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
