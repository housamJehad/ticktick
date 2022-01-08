import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tic/constant/my_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isOpen = false;
  final PanelController _panelController = PanelController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.8,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/img1.jpg"),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  height: height*0.16,
                  right: width*0.05,
                  child: InkWell(
                    onTap: (){
                    },
                    child: const CircleAvatar(
                      backgroundColor: MyColors.myWhite,
                      child: Icon(
                       Icons.send,color: MyColors.myFirstColor,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                          "Housam Jehad",
                          maxLines: 1,
                          style: TextStyle(
                              color: MyColors.myWhite,
                              fontSize: height * 0.03,
                              overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        "tick/HousamJehad.com",
                        maxLines: 1,
                        style: TextStyle(
                            color: MyColors.myWhite,
                            fontSize: height * 0.025,
                            fontWeight: FontWeight.w200,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  left: width * 0.08,
                  top: height * 0.53,
                ),
              ],
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.2,
            child: Container(
              color: Colors.green,
            ),
          ),
          SlidingUpPanel(
            controller: _panelController,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            minHeight: height * 0.25,
            maxHeight: height * 0.75,
            body: Container(
                color: Colors.transparent,
              ),
            panelBuilder: (ScrollController controller) =>
                _panelBody(controller, width, height),
            onPanelSlide: (value) {
              if (value >= 0) {
                if (!isOpen) {
                  setState(() {
                    isOpen = true;
                  });
                }
              }
            },
            onPanelClosed: () {
              setState(() {
                isOpen = false;
              });
            },
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _panelBody(
      ScrollController controller, double width, double height) {
    double hPadding = 40.0;
    return SingleChildScrollView(
      // controller: controller,
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: hPadding),
            height: !isOpen ? height * 0.25 : height * 0.35,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Visibility(
                  visible: isOpen,
                  child: const SizedBox(
                    height: 10,
                  ),
                ),
                isOpen ? _titleSection(width, height) : const SizedBox(),
                Visibility(
                  visible: isOpen,
                  child: const SizedBox(
                    height: 10,
                  ),
                ),
                _infoSection(width, height),
                Visibility(
                  visible: isOpen,
                  child: const SizedBox(
                    height: 10,
                  ),
                ),
                _actionSection(width,height),
                Visibility(
                  visible: isOpen,
                  child: const SizedBox(
                    height: 10,
                  ),
                ),
              ],
            ),
          ),
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 0,
              mainAxisSpacing: 1,
            ),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              _infoCell(const Color(0xff0c8af0), FontAwesomeIcons.facebook,
                  width * 0.2, height * 0.1),
              _infoCell(const Color(0xffd94343),
                  FontAwesomeIcons.envelopeOpenText, width * 0.2, height * 0.1),
              _infoCell(const Color(0xFF3bd952), FontAwesomeIcons.whatsapp,
                  width * 0.2, height * 0.1),
              _infoCell(Colors.amber, FontAwesomeIcons.plus, width * 0.2,
                  height * 0.1),
            ],
          )
        ],
      ),
    );
  }

  FittedBox _actionSection(double width,double height) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Visibility(
          //   visible: !isOpen,
          //   child: Container(
          //     width: width*0.25,
          //     height: height*0.045,
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //           elevation: 5, primary: MyColors.myOrange),
          //       onPressed: () {
          //         _panelController.open();
          //       },
          //       child: const FittedBox(
          //         child:  Text(
          //           "View Profile",
          //           style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Visibility(
          //     visible: !isOpen,
          //     child: const SizedBox(
          //       width: 5,
          //     )),
          SizedBox(
            width: width*0.25,
            height: height*0.045,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5, primary: MyColors.mySecondColor),
              onPressed: () {},
              child: const FittedBox(
                child: Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          SizedBox(
            width: width*0.1,
          ),
          SizedBox(
            width: width*0.25,
            height: height*0.045,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5, primary: MyColors.myFirstColor),
              onPressed: () {},
              child: const FittedBox(
                child: Text(
                  "Direct ON",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _infoSection(double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _infoCell(const Color(0xff0c8af0), FontAwesomeIcons.facebook,
            width * 0.2, height * 0.1),
        _infoCell(const Color(0xffd94343), FontAwesomeIcons.envelopeOpenText,
            width * 0.2, height * 0.1),
        _infoCell(const Color(0xFF3bd952), FontAwesomeIcons.whatsapp,
            width * 0.2, height * 0.1),
      ],
    );
  }

  Container _infoCell(
      Color mainColor, IconData icon, double width, double height) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        elevation: 5,
        color: mainColor,
        shadowColor:mainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Icon(
            icon,
            color: MyColors.myWhite,
            size: height * 0.5,
          ),
        ),
      ),
    );
  }

  Column _titleSection(double width, double height) {
    return Column(
      children: [
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isOpen
                  ? Container(
                      height: height * 0.08,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/img1.jpg"),
                              fit: BoxFit.cover)),
                    )
                  : const SizedBox(),
              isOpen
                  ? SizedBox(
                      width: width * 0.02,
                    )
                  : const SizedBox(),
              Center(
                  child: Column(
                    children:const [
                     Text(
                          "Housam Jehad",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize:30,
                              color: MyColors.myFirstColor),
                        ),
                     Text(
                          "Tick/housamjehad.com",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize:25,
                              color: MyColors.mySecondColor),
                        ),
                    ],
                  ),
              )
            ],
          ),
        )
      ],
    );
  }
}
