import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:tic/presentation_layer/screens/about_us_screen/about_us_screen.dart';
import 'package:tic/presentation_layer/screens/help_screen/help_screen.dart';
import 'package:tic/presentation_layer/screens/home_screen/home_screen.dart';
import 'package:tic/presentation_layer/screens/login_creat_screens/create_account_side/create_account_screen.dart';
import 'package:tic/presentation_layer/screens/login_creat_screens/create_account_side/create_account_screen2.dart';
import 'package:tic/presentation_layer/screens/login_creat_screens/log_in_side/forget_pass_screen.dart';
import 'package:tic/presentation_layer/screens/login_creat_screens/log_in_side/log_in_screen.dart';
import 'package:tic/presentation_layer/screens/login_creat_screens/log_in_side/login_screen2.dart';
import 'package:tic/presentation_layer/screens/login_creat_screens/log_option_screen.dart';
import 'package:tic/presentation_layer/screens/profile_link_screen/profile_link_screen.dart';
import 'package:tic/presentation_layer/screens/profile_screen/editing_profile_side_screens/all_contact_options/all_contact_option_screen.dart';
import 'package:tic/presentation_layer/screens/profile_screen/editing_profile_side_screens/edit_profile_screen/edit_profile_screen.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static final Handler _logOptionHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
          const LogOptionScreen());

  static final Handler _homeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
          const HomeScreen(whichScreen: 0,)); // this one is for one paramter passing...

  static final Handler _loginHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const LogInScreen()); // this one is for one paramter passing...

  static final Handler _login2Handler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const LoginScreen2()); // this one is for one paramter passing...

  static final Handler _createHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const CreateAccount()); // this one is for one paramter passing...

  static final Handler _create2Handler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const CreateAccountScreen(),
  ); // this one is for one paramter passing...

  static final Handler _allContactHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const AllContactOptionScreen()); // this one is for one paramter passing...

  static final Handler _editHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const EditProfileScreen()); // this one is for one paramter passing...

  static final Handler _pageHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        return ProfileLinkScreen(name: params['name'][0],);
      }
  );
  static final Handler _forgetHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        return const ForgetPassScreen();
      }
  );
  static final Handler _helpHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        return const HelpScreen();
      }
  );
  static final Handler _aboutHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        return const AboutUsScreen();
      }
  );
  static final Handler _profileLinkHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        return ProfileLinkScreen(name: params['username'][0]);
      }
  );
  // this one is for one paramter passing...

  // var usersHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  //   return HomeScreen();
  // });

  // lets create for two parameters tooo...
  // static Handler _mainHandler2 = Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
  //         LandingPage(page: params['name'][0],extra: params['extra'][0],));

  // ok its all set now .....
  // now lets have a handler for passing parameter tooo....
  static void setupRouter(){
    router.define(
      '/',
      handler: _logOptionHandler,
    );
    router.define(
      '/logOption',
      handler: _logOptionHandler,
    );
    router.define(
      '/home',
      handler: _homeHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/login',
      handler: _loginHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/login2',
      handler: _login2Handler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/createAccount',
      handler: _createHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/createAccount2',
      handler: _create2Handler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/allContact',
      handler: _allContactHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/page/:name',
      handler: _pageHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/edit',
      handler: _editHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/forget',
      handler: _forgetHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/help',
      handler: _helpHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/aboutUs',
      handler: _aboutHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/profileLink/:username',
      handler: _profileLinkHandler,
      transitionType: TransitionType.fadeIn,
    );
  }
  // '/profileLink/:username'
  // ForgetPassScreen()
}