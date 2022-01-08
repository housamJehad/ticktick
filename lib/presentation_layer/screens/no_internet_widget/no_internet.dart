import 'package:flutter/material.dart';
import 'package:tic/constant/my_colors.dart';


class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height:height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width,
              height: height*0.6,
              decoration:const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/notc.png")
                  )
              ),
            ),
            SizedBox(
              height: height*0.03,
            ),
            Text(
              "Check your internet connection",
              style: TextStyle(
                color: MyColors.myBlack,
                fontSize: height*0.03
              ),
            )
          ],
        ),
      ),
    );
  }
}


