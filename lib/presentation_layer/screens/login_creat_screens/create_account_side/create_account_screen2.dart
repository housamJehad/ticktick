import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/presentation_layer/widgets/log_create_widgets/option_button.dart';
import 'package:tic/presentation_layer/widgets/log_create_widgets/registration_form.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height * 0.18,
              decoration: const BoxDecoration(
                color: MyColors.myBlack,
                borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(60)),
              ),
              child: Center(
                child: Container(
                  width: width,
                  height: height * 0.12,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/tickLogo2.png"),
                      )),
                ),
              ),
            ),
            Container(
              height: height * 0.84,
              color: MyColors.myBlack,
              child: Column(
                children: [
                  Container(
                    height: height * 0.73,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: MyColors.myWhite,
                        border: Border.all(color: MyColors.myWhite, width: 0),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(60),
                            bottomRight: Radius.circular(60))),
                    child: const SingleChildScrollView(
                        child: RegistrationForm()),
                  ),
                  Container(
                    color: MyColors.myWhite,
                    child: Container(
                      height: height * 0.09,
                      decoration: BoxDecoration(
                        color: MyColors.myBlack,
                        border: Border.all(color: MyColors.myBlack, width: 0),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(60)),
                      ),
                      child: Center(
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have account ?",
                                style: TextStyle(
                                    color: MyColors.myWhite,
                                    fontSize: height * 0.025,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                height: height * 0.04,
                                width: width * 0.19,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/login2');
                                      },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        elevation: 5,
                                        shadowColor: MyColors.myWhite),
                                    child: FittedBox(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: MyColors.myBlack,
                                            fontSize: height * 0.025,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  void modelBottomSheet(double width, double height) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(30),
            )),
        context: context,
        builder: (context) {
          return Container(
            height: height * 0.25,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                OptionButton(
                  optionText: "E-mail Login",
                  optionIcon: Icons.email,
                  optionType: 0,
                ),
                SizedBox(
                  height: 20,
                ),
                OptionButton(
                  optionText: "Google Login",
                  optionIcon: FontAwesomeIcons.google,
                  optionType: 1,
                )
              ],
            ),
          );
        });
  }
}
