import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/income_friend_provider.dart';
import 'package:tic/data_layer/models/deep_link_name.dart';
import 'package:tic/presentation_layer/screens/splash_screen/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tic/flurorouter.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_strategy/url_strategy.dart';
import 'business_logic_layer/authentication/data/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setPathUrlStrategy();
  runApp(const TickApp());
}

class TickApp extends StatefulWidget {
  const TickApp({Key? key}) : super(key: key);
  @override
  _TickAppState createState() => _TickAppState();
}

class _TickAppState extends State<TickApp> {

  // static PlatformRouteInformationProvider routeInformationProvider=PlatformRouteInformationProvider(
  //     initialRouteInformation: RouteInformation(
  //         location: PlatformDispatcher.instance.defaultRouteName
  //     )
  // );

  String userName = "";
  String finalDocId = "";

  @override
  void initState() {
    super.initState();
    getInitUniLinks();
    Flurorouter.setupRouter();
    getExistData();
  }

  Future getExistData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? docId = sharedPreferences.getString("docId");
    setState(() {
      if (docId == null) {
        finalDocId = "";
      } else {
        finalDocId = docId;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(),
          ),
          ChangeNotifierProvider<IncomeFriend>(
            create: (_) =>IncomeFriend(),
          ),
        ],
        child:MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateRoute: Flurorouter.router.generator,
              home:SplashScreen(outUri: userName)
          )

    );
  }

  Future<void> getInitUniLinks() async {
    StreamSubscription _sub;
    try {
      await getInitialLink();
      _sub = uriLinkStream.listen((Uri? uri) {
        setState(() {
          userName = uri.toString();
          DeepLinkName.deepLinkName=userName;
        });
        // print(userName);
        SplashScreen(
          outUri: userName,
        );
      }, onError: (err) {
        print("onError");
      });
    } on PlatformException {
      print("PlatformException");
    } on Exception {
      print('Exception thrown');
    }
  }
}
