import 'package:flutter/material.dart';
import 'package:tic/constant/my_colors.dart';


class ProfileContactCell extends StatefulWidget {
  final List<Color> mainColor;
  final double width, height;
  final IconData cellIcon;
  final Color iconColor;
  final String cellName;
  final String url;
  final String type;

  const ProfileContactCell({Key? key,required this.mainColor,required this.width,required this.height,required this.cellIcon,required this.iconColor,required this.cellName,required this.url,required this.type}) : super(key: key);

  @override
  _ProfileContactCellState createState() => _ProfileContactCellState();
}

class _ProfileContactCellState extends State<ProfileContactCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      height: widget.height,
      child: InkWell(
        onTap: () {
        },
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                height: widget.height * 0.98,
                width: widget.width + widget.width / 2,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    elevation: 10,
                    shadowColor: widget.mainColor[1],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Ink(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: widget.mainColor)),
                    child: Center(
                      child: Icon(
                        widget.cellIcon,
                        color: widget.iconColor,
                        size: widget.height * 0.6,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: widget.height * 0.04,
              ),
              Text(
                widget.cellName,
                style: TextStyle(
                    color: MyColors.myBlack,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    fontSize: widget.height * 0.2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
