// import 'dart:ui';
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:tic/presentation_layer/screens/profile_link_screen/profile_link_screen.dart';
// import 'package:tic/presentation_layer/screens/splash_screen/splash_screen.dart';
// import 'package:uni_links/uni_links.dart';
//
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late StreamSubscription _linkSubscription;
//   String urlLink="";
//   String finalLink="";
//   @override
//   void initState() {
//     initDeepLink();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     if (_linkSubscription != null) _linkSubscription.cancel();
//     super.dispose();
//   }
//
//   Future<void> initDeepLink() async {
//     _linkSubscription = linkStream.listen((url) {
//       if (!mounted) return;
//       setState(() {
//         Uri uri = Uri.parse(url as String);
//         List<MapEntry<String, List<String>>> list =
//         uri.queryParametersAll.entries.toList();
//           urlLink=uri.toString();
//
//         if(urlLink.isNotEmpty){
//             finalLink=uri.toString().substring(32, uri.toString().length);
//         }else{
//             finalLink="";
//         }
//       });
//       print(finalLink);
//     }, onError: (Object err) {
//       print("$err");
//     });
//   }
//
//
//
//   String userName="";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:SplashScreen()
//     );
//   }
// }






