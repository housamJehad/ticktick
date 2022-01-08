import 'package:flutter/material.dart';
import 'package:tic/constant/my_colors.dart';

class PopUp extends StatelessWidget {
  final String errorText;
  const PopUp({Key? key, required this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(width, height, context, errorText),
    );
  }

  Widget contentBox(double width, double height, context, String errorText) {
    return Container(
        width: width * 0.8,
        height: height * 0.2,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: MyColors.myWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.05,
              width: width * 0.8,
              // color: Colors.red,
              child: Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                    backgroundColor: MyColors.myBlack,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      splashRadius: 10,
                      icon: const Icon(
                        Icons.exit_to_app_outlined,
                        color: MyColors.myWhite,
                      ),
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              errorText,
              maxLines: 2,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: height * 0.025,
                  color: MyColors.myBlack,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Ok",
                  maxLines: 2,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: height * 0.025,
                      fontWeight: FontWeight.normal),
                ),
                style: ElevatedButton.styleFrom(
                  primary: MyColors.myBlack,
                  onPrimary: MyColors.myWhite,
                ),
              ),
            )
          ],
        ));
  }
}
