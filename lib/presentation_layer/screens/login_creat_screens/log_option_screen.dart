import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tic/constant/my_colors.dart';

class LogOptionScreen extends StatefulWidget {
  const LogOptionScreen({Key? key}) : super(key: key);

  @override
  _LogOptionScreenState createState() => _LogOptionScreenState();
}

class _LogOptionScreenState extends State<LogOptionScreen> {
  String animation = "assets/animation/lf30_editor_d6bz3dmq.json";

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      color: MyColors.myWhite,
      child: Scaffold(
        backgroundColor: MyColors.myWhite,
        body: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: width,
                  height: height * 0.8,
                  color: MyColors.myWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Align(
                        child: Container(
                          height: height * 0.1,
                          decoration: const BoxDecoration(
                              color: MyColors.myWhite,
                              image: DecorationImage(
                                image: AssetImage("assets/images/tickLogo1.png"),
                              )),
                        ),
                        alignment: Alignment.center,
                      ),
                      Center(
                        child: Lottie.asset(
                          animation,
                          width: width,
                          repeat: true,
                          reverse: true,
                          animate: true,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width,
                  height: height * 0.2,
                  child: logOptionSection(width, height),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logOptionSection(double width, double height) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: width * 0.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.myBlack),
              child: logOptionButton(width, height, MyColors.myWhite,
                  MyColors.myWhite, MyColors.myWhite, "Log In", 0)),
          logOptionButton(width, height, MyColors.myBlack, MyColors.myBlack,
              MyColors.myWhite, "Create Account", 1),
        ],
      ),
    );
  }

  Widget logOptionButton(double width, double height, Color primaryColor,
      Color onPrimaryColor, Color shadowColor, String text, int type) {
    return SizedBox(
      child: TextButton(
        onPressed: () {

          type == 0
              ? Navigator.pushNamed(context, '/login2')
              : Navigator.pushNamed(context, '/createAccount2');
        },
        child: Text(text,
            style: TextStyle(
              fontSize: height * 0.025,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            )),
      ),
    );
  }
}
