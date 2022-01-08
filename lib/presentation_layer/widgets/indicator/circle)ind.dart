import 'package:flutter/material.dart';
import 'package:tic/constant/my_colors.dart';
class CircleInd extends StatelessWidget {
  const CircleInd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: MyColors.myWhite,
      width: width,
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: MyColors.myBlack,
              strokeWidth: width * 0.009,
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Text(
              "Check data",
              style:
              TextStyle(fontSize: height * 0.04, color: MyColors.myBlack),
            ),
          ],
        ),
      ),
    );
  }
}