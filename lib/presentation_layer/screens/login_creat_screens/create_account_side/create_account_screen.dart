import 'package:flutter/material.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/constant/strings.dart';
import 'package:tic/presentation_layer/widgets/log_create_widgets/creat_account_form_fields.dart';
import 'package:tic/responsive.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      body: Container(
        height: double.infinity,
        color: MyColors.myWhite,
        child: Stack(
          children: [
            Positioned(
              left:Responsive.isTablet(context)? width * 0.83:width*0.63,
              bottom:Responsive.isTablet(context)? height * 0.9:height*0.85,
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
                  // border: Border.all(color: MyColors.myOrange)
                ),
              ),
            ),
            Positioned(
              right:Responsive.isTablet(context)? width * 0.8:width*0.6,
              top:Responsive.isTablet(context)? height * 0.9:height*0.9,
              child: Container(
                height: 400,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height),
                  color: MyColors.myWhite,
                  gradient: const LinearGradient(
                      colors: [MyColors.myOrange, MyColors.myWhite]),
                  // border: Border.all(color: MyColors.myOrange)
                ),
              ),
            ),
            Container(
              margin:  EdgeInsets.symmetric(
                  vertical:Responsive.isTablet(context)?10:5,
                  horizontal: Responsive.isTablet(context)?width*0.2:30
              ),
              child: SingleChildScrollView(
              child: Column(
                children: [
                  buildHead(width, height),
                  buildCenter(width, height),
                  buildFoot(width, height)
                ],
              ),
            ),
          ),
    ]
        ),
      ),
    );
  }

  Widget buildHead(double width, double height) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
              Container(
                margin: EdgeInsets.only(top: height*0.1),
                width: width,
                height: height * 0.1,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: MyColors.myFirstColor,
                        fontSize: height * 0.04,
                      fontWeight: FontWeight.bold
                    ),
                  ),
              ),
        ],
      ),
    );
  }

 Widget buildCenter(double width, double height) {
    return Column(
      children: const [
        SizedBox(
            child:CreateAccountForm(buttonText: "Sign up",nextScreen: userNameScreen,),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
 Widget buildFoot(double width,double height){
    return FittedBox(
      child: Row(
        children: [
          Text(
            'By registering, you agree to our',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: MyColors.mySecondColor,
              fontSize: height*0.025,
            ),
          ),
          TextButton(
            onPressed: (){},
            child:Text(
              'Terms',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: MyColors.myOrange,
                fontSize: height*0.025,
              ),
            ),
          ),
          Text(
            'and',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: MyColors.myFirstColor,
              fontSize: height*0.025,
            ),
          ),
          TextButton(
            onPressed: (){},
            child:Text(
              'Privacy Policy',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: MyColors.myOrange,
                fontSize: height*0.025,
              ),
            ),
          ),
        ],
      ),
    );
 }

}






//
// Text(
// "Sign up with",
// maxLines: 1,
// overflow: TextOverflow.ellipsis,
// style: TextStyle(
// fontSize: height * 0.04,
// // fontWeight: FontWeight.bold
// ),
// ),
// SizedBox(
// height: 10,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// buildLoginOptionCard(Colors.blue,
// FontAwesomeIcons.facebook, Colors.white),
// const SizedBox(
// width: 20,
// ),
// buildLoginOptionCard(Colors.red,
// FontAwesomeIcons.google, Colors.white),
// ],
// ),
// const SizedBox(
// height: 15,
// ),
// Text(
// "OR",
// overflow: TextOverflow.ellipsis,
// maxLines: 1,
// style: TextStyle(fontSize: height * 0.025),
// ),
// const SizedBox(
// height: 10,
// ),
// Text(
// "Input your email and password",
// overflow: TextOverflow.ellipsis,
// maxLines: 1,
// style: TextStyle(fontSize: height * 0.03, color: MyColors.myGray),
// ),
// const SizedBox(
// height: 20,
// ),