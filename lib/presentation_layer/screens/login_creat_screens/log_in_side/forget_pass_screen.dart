import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/data_layer/web_services/email_sign_services.dart';
import 'package:tic/presentation_layer/widgets/log_create_widgets/field_box.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  _ForgetPassScreenState createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isSecure = true;
  void onPasswordPress() {
    setState(() {
      isSecure = !isSecure;
    });
  }

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
              height: height * 0.4,
              decoration: const BoxDecoration(
                color: MyColors.myBlack,
                borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(60)),
              ),
              child: Center(
                child: Container(
                  width: width,
                  height: height * 0.14,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/tickLogo2.png"),
                      )),
                ),
              ),
            ),
            Container(
              height: height * 0.6,
              color: Colors.black,
              child: Column(
                children: [
                  Container(
                    height: height * 0.5,
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
                                      Navigator.pushNamed(
                                          context, '/createAccount');
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
              height: height * 0.05,
            ),
            Text(
              "Forget Password",
              style: TextStyle(
                  color: MyColors.myBlack,
                  fontSize: height * 0.03,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            FieldBox(
              width: width,
              height: height * 0.12,
              boxName: "Email",
              fieldType: 'email',
              boxHint: "Enter email like abs@gmail.com",
              boxController: emailController,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.done,
              readOnly: false,
              isSecure: false,
              isHaveSuffix: false,
              maxLines: 1,
              onTab: () {},
              onPressSuffix: (){},
            ),
            SizedBox(height: height*0.02,),
            Center(
              child: SizedBox(
                height: height * 0.06,
                width: width *0.85,
                child: ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      EmailSignServices().forgetPass(email: emailController.text.trim(),context: context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: MyColors.myBlack,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    "Send email to reset pass",
                    style: TextStyle(
                      color: MyColors.myWhite,
                      fontSize: height * 0.025,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
