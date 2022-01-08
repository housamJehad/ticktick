import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/data_layer/web_services/email_sign_services.dart';

class LoginFormValidation extends StatefulWidget {
  final String buttonText;
  final String nextScreen;
  const LoginFormValidation(
      {Key? key, required this.buttonText, required this.nextScreen})
      : super(key: key);
  @override
  _LoginFormValidationState createState() => _LoginFormValidationState();
}

class _LoginFormValidationState extends State<LoginFormValidation> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passwordController =TextEditingController();

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else {
      return null;
    }
  }

  bool emailEnable = false;
  bool passEnable = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Form(
      key: formkey,
      child: Column(
        children: <Widget>[
          Padding(
            padding:EdgeInsets.symmetric(vertical: height*0.01),
            child: TextFormField(
               controller: emailController,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: MyColors.myBlack,
                  fontSize: height*0.025,
                ),
                cursorColor: MyColors.myOrange,
                decoration:  InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter valid email id as abc@gmail.com',
                  labelStyle: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: MyColors.myOrange,
                    fontSize: height*0.025,
                  ),
                  hintStyle: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: MyColors.myGray,
                    fontSize: height*0.025,
                  ),
                  focusedBorder:const UnderlineInputBorder(
                    // borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: MyColors.myOrange,
                    ),
                  ),
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: "* Required"),
                  EmailValidator(errorText: "Enter valid email id"),
                ])
            ),
          ),
          Padding(
            padding:EdgeInsets.symmetric(vertical: height*0.01),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: MyColors.myBlack,
                fontSize: height*0.025,
              ),
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter secure password',
                labelStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: MyColors.myOrange,
                  fontSize: height*0.025,
                ),
                hintStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: MyColors.myGray,
                  fontSize: height*0.025,
                ),
                focusedBorder:const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: MyColors.myOrange,

                  ),
                ),
              ),
              validator: MultiValidator([
                RequiredValidator(errorText: "* Required"),
                MinLengthValidator(6,
                    errorText: "Password should be atleast 6 characters"),
                MaxLengthValidator(15,
                    errorText:
                        "Password should not be greater than 15 characters")
              ]),
              onTap: () {
                setState(() {
                  passEnable = true;
                });
              },
              onFieldSubmitted: (value) {
                setState(() {
                  passEnable = false;
                });
              },
              //validatePassword,        //Function to check validation
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: height * 0.07,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  EmailSignServices().userLogin(context: context,email: emailController.text,password: passwordController.text);
                } else {
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: MyColors.myOrange, elevation: 8,shadowColor: MyColors.mySecondColor),
              child: Text(
                widget.buttonText,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.03),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
