import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/income_friend_provider.dart';
import 'package:tic/presentation_layer/screens/profile_link_screen/profile_link_screen.dart';
import 'package:tic/presentation_layer/screens/splash_screen/splash_screen.dart';
import 'package:tic/presentation_layer/widgets/popup/popup.dart';

import 'package:uni_links/uni_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tic/flurorouter.dart';
import 'package:url_strategy/url_strategy.dart';
import 'business_logic_layer/authentication/data/providers/user_provider.dart';

bool _initialUriHandled = false;
String userName = "";


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setPathUrlStrategy();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(),
          ),
          ChangeNotifierProvider<IncomeFriend>(
            create: (_) =>IncomeFriend(),
          ),
        ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Flurorouter.router.generator,
        home: TickApp()
   ),
      )
  );
}

class TickApp extends StatefulWidget {
  const TickApp({Key? key}) : super(key: key);
  @override
  _TickAppState createState() => _TickAppState();
}



class _TickAppState extends State<TickApp> with SingleTickerProviderStateMixin {

  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;
  String finalDocId="";
  StreamSubscription? _sub;

  final _cmds = getCmds();
  final _cmdStyle = const TextStyle(
      fontFamily: 'Courier', fontSize: 12.0, fontWeight: FontWeight.w700);

  @override
  void initState() {
    super.initState();
    getExistData();
    _handleIncomingLinks(context);
    _handleInitialUri(context);
    Flurorouter.setupRouter();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
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


  /// Handle incoming links - the ones that the app will recieve from the OS
  /// while already started.
  void _handleIncomingLinks(newContext) async{

    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      print("open in link");
      await getExistData();
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        setState(() {
          _latestUri = uri;
          userName=uri!.path.toString();
          _err = null;
        });
        if(finalDocId.isEmpty){
           if(FirebaseAuth.instance.currentUser==null){
             showDialog(
                 context: context,
                 builder: (BuildContext context) {
                   return const PopUp(errorText: "Log in and try again",type: "error",anotherArguments: "",);
                 });
           }else{
             Navigator.push(newContext,MaterialPageRoute(builder: (context)=>ProfileLinkScreen(name: userName)));
           }
        }else{
          Navigator.push(newContext,MaterialPageRoute(builder: (context)=>ProfileLinkScreen(name: userName)));
        }
        print(userName+" open");
      }, onError: (Object err) {
        if (!mounted) return;
        print('got err: $err');
        setState(() {
          _latestUri = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }

  /// Handle the initial Uri - the one the app was started with
  ///
  /// **ATTENTION**: `getInitialLink`/`getInitialUri` should be handled
  /// ONLY ONCE in your app's lifetime, since it is not meant to change
  /// throughout your app's life.
  ///
  /// We handle all exceptions, since it is called from initState.
  Future<void> _handleInitialUri(newContext) async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    if (!_initialUriHandled) {
      _initialUriHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          await getExistData();
          print(finalDocId);
          if(finalDocId.isEmpty){
            if(FirebaseAuth.instance.currentUser==null){
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const PopUp(errorText: "Log in and try again",type: "error",anotherArguments: "",);
                  });
            }else{
              Navigator.push(newContext,MaterialPageRoute(builder: (context)=>ProfileLinkScreen(name: userName)));
            }
          }else{
            setState(() {
              Provider.of<IncomeFriend>(context,listen: false).friendUserName=uri.path.toString();
              userName=uri.path.toString();
            });
          }
          print(userName);
          print('got closed initial uri: $uri');
        }
        if (!mounted) return;
        setState(() => _initialUri = uri);
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        print('falied to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        print('malformed initial uri');
        setState(() => _err = err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final queryParams = _latestUri?.queryParametersAll.entries.toList();
    return Scaffold(
            body: SplashScreen(outUri: userName),
          );
  }

  Widget _cmdsCard(List<String>? commands) {
    Widget platformCmds;

    if (commands == null) {
      platformCmds = const Center(child: Text('Unsupported platform'));
    } else {
      platformCmds = Column(
        children: [
          const [
            if (kIsWeb)
              Text('Append this path to the Web app\'s URL, replacing `#/`:\n')
            else
              Text('To populate above fields open a terminal shell and run:\n'),
          ],
          intersperse(
              commands.map<Widget>((cmd) => InkWell(
                onTap: () => _printAndCopy(cmd),
                child: Text('\n$cmd\n', style: _cmdStyle),
              )),
              const Text('or')),
          [
            Text(
              '(tap on any of the above commands to print it to'
                  ' the console/logger and copy to the device clipboard.)',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
          ]
        ].expand((el) => el).toList(),
      );
    }

    return Card(
      margin: const EdgeInsets.only(top: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: platformCmds,
      ),
    );
  }

  Future<void> _printAndCopy(String cmd) async {
    print(cmd);


  }


}

List<String>? getCmds() {
  late final String cmd;
  var cmdSuffix = '';

  const plainPath = 'path/subpath';
  const args = 'path/portion/?uid=123&token=abc';
  const emojiArgs =
      '?arr%5b%5d=123&arr%5b%5d=abc&addr=1%20Nowhere%20Rd&addr=Rand%20City%F0%9F%98%82';

  if (kIsWeb) {
    return [
      plainPath,
      args,
      emojiArgs,
      // Cannot create malformed url, since the browser will ensure it is valid
    ];
  }

  if (Platform.isIOS) {
    cmd = '/usr/bin/xcrun simctl openurl booted';
  } else if (Platform.isAndroid) {
    cmd = '\$ANDROID_HOME/platform-tools/adb shell \'am start'
        ' -a android.intent.action.VIEW'
        ' -c android.intent.category.BROWSABLE -d';
    cmdSuffix = "'";
  } else {
    return null;
  }

  // https://orchid-forgery.glitch.me/mobile/redirect/
  return [
    '$cmd "unilinks://host/$plainPath"$cmdSuffix',
    '$cmd "unilinks://example.com/$args"$cmdSuffix',
    '$cmd "unilinks://example.com/$emojiArgs"$cmdSuffix',
    '$cmd "unilinks://@@malformed.invalid.url/path?"$cmdSuffix',
  ];
}

List<Widget> intersperse(Iterable<Widget> list, Widget item) {
  final initialValue = <Widget>[];
  return list.fold(initialValue, (all, el) {
    if (all.isNotEmpty) all.add(item);
    all.add(el);
    return all;
  });
}


// class _TickAppState extends State<TickApp> {
//
//   String userName = "";
//   String finalDocId = "";
//
//   @override
//   void initState() {
//     super.initState();
//     getInitUniLinks();
//     Flurorouter.setupRouter();
//     getExistData();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//         providers: [
//           ChangeNotifierProvider<UserProvider>(
//             create: (_) => UserProvider(),
//           ),
//           ChangeNotifierProvider<IncomeFriend>(
//             create: (_) =>IncomeFriend(),
//           ),
//         ],
//         child:MaterialApp(
//               debugShowCheckedModeBanner: false,
//               onGenerateRoute: Flurorouter.router.generator,
//               home:SplashScreen(outUri: userName)
//           )
//     );
//   }
//
//   Future<void> getInitUniLinks() async {
//     StreamSubscription _sub;
//     try {
//       await getInitialLink();
//       _sub = uriLinkStream.listen((Uri? uri) {
//         setState(() {
//           userName = uri.toString();
//           print(userName);
//           DeepLinkName.deepLinkName=userName;
//         });
//         // print(userName);
//         SplashScreen(
//           outUri: userName,
//         );
//       }, onError: (err) {
//         print("onError");
//       });
//     } on PlatformException {
//       print("PlatformException");
//     } on Exception {
//       print('Exception thrown');
//     }
//   }
//   Future getExistData() async {
//     final SharedPreferences sharedPreferences =
//     await SharedPreferences.getInstance();
//     String? docId = sharedPreferences.getString("docId");
//     setState(() {
//       if (docId == null) {
//         finalDocId = "";
//       } else {
//         finalDocId = docId;
//       }
//     });
//   }
// }
