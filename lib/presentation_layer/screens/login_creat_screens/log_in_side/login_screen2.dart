import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/data_layer/web_services/email_sign_services.dart';
import 'package:tic/presentation_layer/widgets/log_create_widgets/field_box.dart';
import 'package:tic/presentation_layer/widgets/log_create_widgets/option_button.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({Key? key}) : super(key: key);

  @override
  _LoginScreen2State createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
              height: height * 0.3,
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
              height: height * 0.7,
              color: MyColors.myBlack,
              child: Column(
                children: [
                  Container(
                    height: height * 0.61,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: MyColors.myWhite,
                        border: Border.all(color: MyColors.myWhite, width: 0),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(60),
                            bottomRight: Radius.circular(60))),
                    child:
                        SingleChildScrollView(child: loginForm(width, height)),
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
                                "Don't have account ?",
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
                                      Navigator.pushReplacementNamed(
                                          context, '/createAccount2');
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        elevation: 5,
                                        shadowColor: MyColors.myWhite),
                                    child: FittedBox(
                                      child: Text(
                                        "Create",
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

  Widget loginForm(double width, double height) {
    return SizedBox(
      width: width,
      // color: Colors.white,
      child: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "Login Option",
              style: TextStyle(
                  color: MyColors.myBlack,
                  fontSize: height * 0.03,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            FieldBox(
              width: width,
              height: height * 0.12,
              boxName: "Email",
              boxHint: "Enter email like abs@gmail.com",
              boxController: emailController,
              fieldType: "email",
              maxLines: 1,
              onTab: (){},
              readOnly: false,
            ),
            const SizedBox(
              height: 5,
            ),
            FieldBox(
              width: width,
              height: height * 0.12,
              boxName: "Password",
              boxHint: "Enter password has at least 1 capital letter",
              boxController: passwordController,
              fieldType: "password",
              maxLines: 1,
              onTab: (){},
              readOnly: false,
            ),
            const SizedBox(
              height: 5,
            ),
            FittedBox(
              child: Row(
                children: [
                  Center(
                    child: SizedBox(
                      height: height * 0.06,
                      width: width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            EmailSignServices().userLogin(context: context,email: emailController.text,password: passwordController.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: MyColors.myBlack, elevation: 0),
                        child: Text(
                          "E-mail Login",
                          style: TextStyle(
                            color: MyColors.myWhite,
                            fontSize: height * 0.025,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forget password ?",
                        style: TextStyle(
                          color: MyColors.myBlack,
                          fontSize: height * 0.025,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.4,
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: MyColors.myBlack,
                    ),
                  ),
                ),
                const Text("OR"),
                Container(
                  width: width * 0.4,
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: MyColors.myBlack,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const OptionButton(
              optionText: "Google Login",
              optionIcon: FontAwesomeIcons.google,
              optionType: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            const OptionButton(
              optionText: "Facebook Login",
              optionIcon: FontAwesomeIcons.facebook,
              optionType: 0,
            )
          ],
        ),
      ),
    );
  }
}
