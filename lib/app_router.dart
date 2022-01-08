
import 'package:flutter/material.dart';
import 'package:tic/constant/strings.dart';
import 'package:tic/presentation_layer/screens/friend_screen/friends_screen.dart';
import 'package:tic/presentation_layer/screens/home_screen/home_screen.dart';
import 'package:tic/presentation_layer/screens/login_creat_screens/create_account_side/add_info_screen.dart';
import 'package:tic/presentation_layer/screens/login_creat_screens/create_account_side/create_account_screen.dart';
import 'package:tic/presentation_layer/screens/login_creat_screens/create_account_side/user_name_screen.dart';
import 'package:tic/presentation_layer/screens/login_creat_screens/log_in_side/log_in_screen.dart';
import 'package:tic/presentation_layer/screens/login_creat_screens/log_option_screen.dart';
import 'package:tic/presentation_layer/screens/profile_screen/editing_profile_side_screens/all_contact_options/all_contact_option_screen.dart';
import 'package:tic/presentation_layer/screens/profile_screen/profile_screen.dart';
import 'package:tic/presentation_layer/screens/profile_screen/profile_test.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case homeScreen:
        return MaterialPageRoute(builder: (_) =>const HomeScreen(whichScreen: 0,));
      case logInScreen:
        return MaterialPageRoute(builder: (_) =>const LogInScreen());
      case createAccountScreen:
        return MaterialPageRoute(builder: (_) =>const CreateAccount());
      case userNameScreen:
        return MaterialPageRoute(builder: (_) =>const UserNameScreen());
      case addInfoScreen:
        return MaterialPageRoute(builder: (_) =>const AddInfoScreen());
      case allContactOption:
        return MaterialPageRoute(builder: (_) =>const AllContactOptionScreen());
      case profile:
        return MaterialPageRoute(builder: (_) =>const ProfileTestScreen());
      case friendsScreen:
        return MaterialPageRoute(builder: (_) =>const FriendsScreen());
      default:
        return MaterialPageRoute(builder: (_) =>const LogOptionScreen());
    }
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeScreen:
      return _getPageRoute(const HomeScreen(whichScreen: 0,), settings);
    case logInScreen:
      return _getPageRoute(const LogInScreen(), settings);
    case createAccountScreen:
      return _getPageRoute(const CreateAccount(), settings);
    case userNameScreen:
      return _getPageRoute(const UserNameScreen(), settings);
    case addInfoScreen:
      return _getPageRoute(const AddInfoScreen(), settings);
    case allContactOption:
      return _getPageRoute(const AllContactOptionScreen(), settings);
    case profile:
      return _getPageRoute(const ProfileScreen(), settings);
    case friendsScreen:
      return _getPageRoute(const FriendsScreen(), settings);
    default:
      return _getPageRoute(const LogOptionScreen(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name as String);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({required this.child, required this.routeName})
      : super(
    settings: RouteSettings(name: routeName),
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    child,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}