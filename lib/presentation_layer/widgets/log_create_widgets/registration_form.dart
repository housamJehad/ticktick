import 'package:flutter/material.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/data_layer/web_services/email_sign_services.dart';
import 'package:tic/presentation_layer/widgets/log_create_widgets/field_box.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isSecure=true;



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      // color: Colors.white,
      child: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Registration",
              style: TextStyle(
                  color: MyColors.myBlack,
                  fontSize: height * 0.03,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FieldBox(
                  width: width * 0.425,
                  height: height * 0.13,
                  boxName: "First Name",
                  boxHint: "First Name",
                  boxController: firstNameController,
                  fieldType: "name",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  isHaveSuffix: false,
                  isSecure: false,
                  onTab: () {},
                  onPressSuffix: (){},
                  maxLines: 1,
                  readOnly: false,
                ),
                const SizedBox(
                  width: 2,
                ),
                FieldBox(
                  width: width * 0.425,
                  height: height * 0.13,
                  boxName: "Second Name",
                  boxHint: "Second Name",
                  boxController: secondNameController,
                  fieldType: "name",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  isHaveSuffix: false,
                  isSecure: false,
                  maxLines: 1,
                  onTab: () {},
                  onPressSuffix: (){},
                  readOnly: false,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            FieldBox(
              width: width,
              height: height * 0.14,
              boxName: "Email",
              boxHint: "Enter email like abs@gmail.com",
              boxController: emailController,
              fieldType: "email",
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              isHaveSuffix: false,
              isSecure: false,
              maxLines: 1,
              onTab: () {},
              onPressSuffix: (){},
              readOnly: false,
            ),
            const SizedBox(
              height: 5,
            ),
            FieldBox(
              width: width,
              height: height * 0.14,
              boxName: "Phone Number",
              boxHint: "Enter phone number like 079*******",
              boxController: phoneController,
              fieldType: "phone",
              maxLines: 1,
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              isHaveSuffix: false,
              isSecure: false,
              onTab: () {},
              onPressSuffix: (){},
              readOnly: false,
            ),
            const SizedBox(
              height: 5,
            ),
            FieldBox(
              width: width,
              height: height * 0.14,
              boxName: "Password",
              boxHint: "Enter password has at least 8 letters",
              boxController: passwordController,
              fieldType: "password",
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.done,
              isHaveSuffix: true,
              isSecure: isSecure,
              maxLines: 1,
              onTab: () {},
              onPressSuffix: (){
                setState(() {
                  isSecure=!isSecure;
                });
              },
              readOnly: false,
            ),

            const SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                height: height * 0.06,
                width: width,
                child: ElevatedButton(
                  onPressed: () {
                    print(formkey.currentState!.validate());
                    if (formkey.currentState!.validate()) {
                      EmailSignServices().registration(
                          context: context,
                          password: passwordController.text.trim().toLowerCase(),
                          name: firstNameController.text.trim().toLowerCase() +
                              " " +
                              secondNameController.text.trim().toLowerCase(),
                          email: emailController.text.trim().toLowerCase(),
                          phone: phoneController.text.trim().toLowerCase());
                    } else {}
                  },
                  style: ElevatedButton.styleFrom(
                    primary: MyColors.myBlack,
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: MyColors.myWhite,
                      fontSize: height * 0.025,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 20,),
            buildFoot(width, height),
          ],
        ),
      ),
    );
  }

  Widget buildFoot(double width, double height) {
    return FittedBox(
      child: Row(
        children: [
          Text(
            'By registering, you agree to our',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black54,
              fontSize: height * 0.025,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Terms and Privacy Policy',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: MyColors.myBlack,
                fontSize: height * 0.025,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pressBox(
    double width,
    double height,
    String boxName,
  ) {
    return FittedBox(
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.3,
              width: width,
              child: Text(
                boxName,
                style: TextStyle(
                    color: MyColors.myBlack,
                    fontSize: height * 0.3,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: height * 0.5,
              width: width,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.transparent,
                    padding: EdgeInsets.zero),
                child: Row(
                  children: [
                    Text(
                      "Press Here",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: height * 0.25,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
