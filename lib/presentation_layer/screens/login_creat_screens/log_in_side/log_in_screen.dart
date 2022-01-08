import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/constant/strings.dart';
import 'package:tic/data_layer/web_services/facebook_sign_services.dart';
import 'package:tic/data_layer/web_services/google_services.dart';
import 'package:tic/presentation_layer/screens/home_screen/home_screen.dart';
import 'package:tic/presentation_layer/widgets/log_create_widgets/log_in_form_field_widget.dart';
import 'package:tic/responsive.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: MyColors.myWhite,
        body: Container(
          height: double.infinity,
          color: MyColors.myWhite,
          child: Stack(children: [
            Positioned(
              left: Responsive.isTablet(context) ? width * 0.83 : width * 0.63,
              bottom:
                  Responsive.isTablet(context) ? height * 0.9 : height * 0.85,
              child: Container(
                height: 400,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height),
                  color: MyColors.myWhite,
                  gradient: const LinearGradient(colors: [
                    MyColors.myWhite,
                    MyColors.myOrange,
                    // MyColors.myOrange,
                  ]),
                ),
              ),
            ),
            Positioned(
              right: Responsive.isTablet(context) ? width * 0.8 : width * 0.6,
              top: Responsive.isTablet(context) ? height * 0.9 : height * 0.9,
              child: Container(
                height: 400,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height),
                  color: MyColors.myWhite,
                  gradient: const LinearGradient(
                      colors: [MyColors.myOrange, MyColors.myWhite]),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: Responsive.isTablet(context) ? 10 : 5,
                  horizontal: Responsive.isTablet(context) ? width * 0.2 : 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildHead(width, height),
                    buildCenter(width, height, context),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              //TODO FORGOT PASSWORD SCREEN GOES HERE
                            },
                            child: Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                  color: MyColors.mySecondColor,
                                  fontSize: height * 0.025),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/createAccount',
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: MyColors.myOrange,
                                  fontSize: height * 0.025),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }

  Widget buildHead(double width, double height) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height:
                Responsive.isTablet(context) ? height * 0.03 : height * 0.08,
          ),
          Center(
            child: Stack(children: [
              Positioned(
                child: Icon(
                  Icons.network_wifi,
                  color: MyColors.myOrange,
                  size: height * 0.03,
                ),
                top: Responsive.isTablet(context)
                    ? height * 0.03
                    : height * 0.05,
                left: Responsive.isTablet(context) ? width * 0.3 : width * 0.23,
              ),
              SizedBox(
                width: width * 0.4,
                height: height * 0.175,
                child: Center(
                  child: Text(
                    "Tick",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: MyColors.myFirstColor,
                        fontSize: height * 0.04,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: Responsive.isTablet(context) ? 20 : 10,
          ),
          Text(
            "Sign in",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: height * 0.035,
                color: MyColors.myFirstColor,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Hi there nice to see you",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontSize: height * 0.03, color: MyColors.mySecondColor),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget buildCenter(double width, double height, context) {
    return Column(
      children: [
        const LoginFormValidation(
          buttonText: "Sign in",
          nextScreen: homeScreen,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "or use one of your social profiles",
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style:
              TextStyle(color: MyColors.mySecondColor, fontSize: height * 0.03),
        ),
        const SizedBox(
          height: 20,
        ),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildLoginOptionCard(Colors.red, FontAwesomeIcons.google,
                  Colors.white, width, height, "Google", context, 0, 1),
              SizedBox(
                width: width * 0.011,
              ),
              buildLoginOptionCard(
                  const Color(0xff0c8af0),
                  FontAwesomeIcons.facebook,
                  Colors.white,
                  width,
                  height,
                  "Facebook",
                  context,
                  1,
                  0),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget buildLoginOptionCard(
      Color color,
      IconData icon,
      iconColor,
      double width,
      double height,
      String text,
      var context,
      int isFacebook,
      int isGoogle) {
    return InkWell(
      onTap: isGoogle == 1
          ? () async {
              var user = await GoogleService().signInWithGoogle(context);
              setState(() {
                Provider.of<UserProvider>(context, listen: false).email =
                    user?.email;
                Provider.of<UserProvider>(context, listen: false).name =
                    user?.name;
                Provider.of<UserProvider>(context, listen: false).uid =
                    user?.uid;
                Provider.of<UserProvider>(context, listen: false).isVerify =
                    user?.isVerify;
                Provider.of<UserProvider>(context, listen: false).imageUrl =
                    user?.photoUrl;
                Provider.of<UserProvider>(context, listen: false).loginType =
                    "Google";
                Provider.of<UserProvider>(context, listen: false).links =
                    user?.links;
                Provider.of<UserProvider>(context, listen: false).friend =
                    user?.friends;
                Provider.of<UserProvider>(context, listen: false).bio =
                    user?.bio;
              });
              if(Provider.of<UserProvider>(context, listen: false).uid!.isEmpty){
                await FirebaseFirestore.instance
                    .collection('User')
                    .get()
                    .then((QuerySnapshot querySnapshot) {
                  for (var doc in querySnapshot.docs) {
                    if (doc['email'] == Provider.of<UserProvider>(context, listen: false).email) {
                     setState(() {
                       Provider.of<UserProvider>(context, listen: false).uid=doc['uid'];
                     });
                    }
                  }
                });
              }
              if (user?.email != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const HomeScreen(whichScreen: 0,)));
              }
            }
          : () async {
              var user = await FacebookSignServices().signInWithFacebook();
              setState(() {
                Provider.of<UserProvider>(context, listen: false).email =
                    user?.email;
                Provider.of<UserProvider>(context, listen: false).name =
                    user?.displayName;
                Provider.of<UserProvider>(context, listen: false).uid =
                    user?.uid;
                Provider.of<UserProvider>(context, listen: false).isVerify =
                    user?.emailVerified;
                Provider.of<UserProvider>(context, listen: false).imageUrl =
                    user?.photoURL;
                Provider.of<UserProvider>(context, listen: false).loginType =
                    "Facebook";
              });
              if (user?.email != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const HomeScreen(whichScreen: 0,)));
              }
            },
      child: Container(
        height: height * 0.06,
        width: width * 0.4,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    icon,
                    color: iconColor,
                    size: height * 0.025,
                  ),
                ),
              ),
              Center(
                child: FittedBox(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        color: MyColors.myWhite, fontSize: height * 0.025),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
