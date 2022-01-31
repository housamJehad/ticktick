import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/data_layer/models/deep_link_name.dart';
import 'package:tic/data_layer/web_services/email_sign_services.dart';
import 'package:tic/data_layer/web_services/facebook_sign_services.dart';
import 'package:tic/data_layer/web_services/google_services.dart';
import 'package:tic/presentation_layer/screens/about_us_screen/about_us_screen.dart';
import 'package:tic/presentation_layer/screens/friend_screen/friends_screen.dart';
import 'package:tic/presentation_layer/screens/help_screen/help_screen.dart';
import 'package:tic/presentation_layer/screens/login_creat_screens/log_option_screen.dart';
import 'package:tic/presentation_layer/screens/nfc_screen/nfc_screen.dart';
import 'package:tic/presentation_layer/screens/out_link_screen/out_link_screen.dart';
import 'package:tic/presentation_layer/screens/profile_link_screen/profile_link_screen.dart';
import 'package:tic/presentation_layer/screens/profile_screen/profile_screen3.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  final int whichScreen;
  const HomeScreen({Key? key, required this.whichScreen}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int whichScreen = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int currentScreen = 0;
  bool isPrivate = false;
  final Color selectedScreenColor = MyColors.myOrange;
  String nfcAnimation = 'assets/animation/lf30_editor_p6r6h0tl.json';
  ValueNotifier<dynamic> nfcReadResult = ValueNotifier(null);
  late Uri url;

  final List<Widget> _children = [
    const ProfileTestScreen2(),
    const NfcScreen(),
    const OutLinkScreen(),
    const FriendsScreen(),
  ];



  @override
  void initState() {
    nfcReadResult.value = "";
    setState(() {
      isPrivate = Provider.of<UserProvider>(context, listen: false).status!;
    });
    whichScreen = widget.whichScreen;
    super.initState();
  }
  void onItemTapped(int index) {
    if (index == 1) {
      _onPressScan();
    } else if (index == 2) {
      if (DeepLinkName.deepLinkName.isEmpty) {
        setState(() {
          whichScreen = index;
        });
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProfileLinkScreen(name: DeepLinkName.deepLinkName)));
      }
    } else {
      setState(() {
        whichScreen = index;
      });
    }
  }

  void _ndefWrite() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        nfcReadResult.value = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: nfcReadResult.value);
        return;
      }
      NdefMessage message = NdefMessage([
        NdefRecord.createUri(Uri.parse(
            "https://tick-1c025.web.app/page/${Provider.of<UserProvider>(context, listen: false).email}"))
      ]);

      try {
        await ndef.write(message);
        setState(() {
          nfcReadResult.value = 'Success to "Ndef Write"';
        });
        NfcManager.instance.stopSession();
      } catch (e) {
        nfcReadResult.value = e;
        NfcManager.instance.stopSession(errorMessage: nfcReadResult.value.toString());
        return;
      }
    });
  }

  _onPressScan() async {
    setState(() {
      nfcAnimation = 'assets/animation/lf30_editor_p6r6h0tl.json';
      nfcReadResult.value = "";
    });
    _ndefWrite();
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (context) {
          double height = MediaQuery.of(context).size.height;
          return FutureBuilder<bool>(
              future: NfcManager.instance.isAvailable(),
              builder: (context, ss) => ss.data != true
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Please turn on NFC features on your device and hold the nfc device nar your phone',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: height * 0.025),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: height * 0.3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.3,
                              child: Center(
                                child: Lottie.asset(
                                  nfcAnimation,
                                  repeat: true,
                                  reverse: true,
                                  animate: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: MyColors.myWhite,
        appBar: AppBar(
          backgroundColor: MyColors.myBlack,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              splashColor: const Color(0xFFff0000),
              splashRadius: height * 0.03,
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                FontAwesomeIcons.bars,
                color: MyColors.myWhite,
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  await Share.share(
                      "https://tick-1c025.web.app/page/${Provider.of<UserProvider>(context, listen: false).email?.trim()}",
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                },
                icon: const Icon(
                  Icons.send,
                )),
          ],
          title: Text(Provider.of<UserProvider>(context, listen: false).userName
              as String),
        ),
        drawer: Drawer(
          child: ListView(children: <Widget>[
            SizedBox(
              height: height * 0.1,
              child: Center(
                child: Container(
                  width: width,
                  height: height * 0.09,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/tickLogo1.png"),
                  )),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Private off",
                  style: TextStyle(
                      fontSize: height * 0.025,
                      overflow: TextOverflow.ellipsis,
                      color: MyColors.myBlack),
                ),
                Switch(
                    activeColor: MyColors.myBlack,
                    value: isPrivate,
                    onChanged: (value) async {
                      setState(() {
                        isPrivate = value;
                        Provider.of<UserProvider>(context, listen: false)
                            .status = isPrivate;
                      });
                      await FirebaseFirestore.instance
                          .collection("User")
                          .doc(Provider.of<UserProvider>(context, listen: false)
                              .uid)
                          .update({'status': isPrivate});
                    }),
                Text(
                  "Private on",
                  style: TextStyle(
                      fontSize: height * 0.025,
                      overflow: TextOverflow.ellipsis,
                      color: MyColors.myBlack),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            _drawerOption("Home", width, height, 0, 0, Icons.home_outlined),
            _drawerOption("Help", width, height, 1, 0, Icons.help),
            _drawerOption("About us", width, height, 2, 0, Icons.info_outline),
            _drawerOption("Log out", width, height, 3, 0, Icons.logout),
          ]),
        ),
        bottomNavigationBar: SizedBox(
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.nfc), label: "Nfc Write"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.phonelink_ring_sharp), label: "Out Link"),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.userFriends), label: "Friends"),
            ],
            backgroundColor: MyColors.myBlack,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: whichScreen,
            unselectedItemColor: selectedScreenColor,
            selectedItemColor: MyColors.myWhite,
            onTap: onItemTapped,
          ),
        ),
        body: _children[whichScreen]);
  }

  Widget _drawerOption(String optionName, double width, double height,
      int cIndex, lIndex, IconData icon) {
    String? loginType =
        Provider.of<UserProvider>(context, listen: false).loginType;
    return InkWell(
      onTap: cIndex == currentScreen
          ? () {}
          : cIndex == 0
              ? () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const HomeScreen(whichScreen: 0)));
                }
              : cIndex == 1
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HelpScreen()));
                    }
                  : cIndex == 2
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AboutUsScreen()));
                        }
                      : loginType == "Google"
                          ? () async {
                              await GoogleService()
                                  .signOutGoogle(context)
                                  .then((value) async {
                                removeProviderData(context);
                                final SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                await sharedPreferences.remove('docId');
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const LogOptionScreen()));
                              });
                            }
                          : loginType == "email"
                              ? () async {
                                  await EmailSignServices()
                                      .userLogOut(context)
                                      .then((value) async {
                                    removeProviderData(context);
                                    final SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    await sharedPreferences.remove('docId');
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const LogOptionScreen()));
                                  });
                                }
                              : () async {
                                  await FacebookSignServices()
                                      .signOutGoogle()
                                      .then((value) async {
                                    removeProviderData(context);
                                    final SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    await sharedPreferences.remove('docId');
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const LogOptionScreen()));
                                  });
                                },
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.02),
        height: height * 0.1,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: width * 0.04),
              height: height * 0.09,
              width: width * 0.02,
              decoration: BoxDecoration(
                  color: currentScreen == cIndex
                      ? MyColors.myBlack
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(height * 0.02),
                      topRight: Radius.circular(height * 0.02))),
            ),
            Padding(
              padding: EdgeInsets.only(right: width * 0.04),
              child: Icon(icon,
                  color: currentScreen == cIndex
                      ? MyColors.myBlack
                      : MyColors.myOrange,
                  size: height * 0.035),
            ),
            Text(
              optionName,
              style: TextStyle(
                  fontSize: height * 0.03, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }

  removeProviderData(context) {
    setState(() {
      Provider.of<UserProvider>(context, listen: false).email = "";
      Provider.of<UserProvider>(context, listen: false).imageUrl = "";
      Provider.of<UserProvider>(context, listen: false).isVerify = false;
      Provider.of<UserProvider>(context, listen: false).uid = "";
      Provider.of<UserProvider>(context, listen: false).name = "";

      Provider.of<UserProvider>(context, listen: false).userName = "";
      Provider.of<UserProvider>(context, listen: false).bio = "";
      Provider.of<UserProvider>(context, listen: false).links = [];
      Provider.of<UserProvider>(context, listen: false).directOn = {};
      Provider.of<UserProvider>(context, listen: false).friend = [];

      Provider.of<UserProvider>(context, listen: false).status = false;
      Provider.of<UserProvider>(context, listen: false).number = "";
      Provider.of<UserProvider>(context, listen: false).loginType = "";

      Provider.of<UserProvider>(context, listen: false).userNameLink = "";
    });
  }
}
