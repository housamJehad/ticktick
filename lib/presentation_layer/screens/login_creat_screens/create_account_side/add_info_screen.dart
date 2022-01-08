import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tic/constant/my_colors.dart';

class AddInfoScreen extends StatefulWidget {
  const AddInfoScreen({Key? key}) : super(key: key);

  @override
  _AddInfoScreenState createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      appBar: AppBar(
        backgroundColor: MyColors.myBlack,
        title: const Text(
          "Edit Profile",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: MyColors.myWhite),
        ),
        centerTitle: true,
        leading: const SizedBox(),
      ),
      bottomNavigationBar: Container(
        padding:const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        color: MyColors.myWhite,
        height: height * 0.1,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: MyColors.myBlack, elevation: 10),
          onPressed: () {},
          child: Text(
            "Save Profile",
            style: TextStyle(
                fontSize: height * 0.03,
                fontWeight: FontWeight.bold,
                color: MyColors.myWhite),
          ),
        ),
      ),
      body:SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildHead(width, height),
              buildCenter(width, height),
              buildFoot(width, height),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHead(double width, double height) {
    return SizedBox(
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: SizedBox(
              height: height * 0.35,
              width: width,
              child: Stack(
                children: [
                  Card(
                    elevation: 10,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    color: MyColors.myWhite,
                    child: Center(
                      child: Icon(
                        Icons.person_outline_rounded,
                        size: height * 0.3,
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.22,
                    right: width * 0.08,
                    child: CircleAvatar(
                      backgroundColor: MyColors.myBlack,
                      maxRadius: 35,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: MyColors.myWhite,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCenter(double width, double height) {
    TextEditingController userNameController =
        TextEditingController(text: "Housam Jehad");
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.04,
            child: Center(
                child: Text(
              "Personal Information",
              style:
                  TextStyle(color: MyColors.myBlack, fontSize: height * 0.035),
            )),
          ),
          SizedBox(
            height: height * 0.22,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.2,
                  width: width,
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        SizedBox(
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            cursorColor: MyColors.myOrange,
                            controller: userNameController,
                            style: TextStyle(fontSize: height * 0.025),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: MyColors.myBlack,
                                ),
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: MyColors.myBlack,
                                ),
                                focusColor: MyColors.myOrange,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColors.myOrange))),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            maxLines: 5,
                            style: TextStyle(fontSize: height * 0.025),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusColor: MyColors.myOrange,
                              hintText: "Bio about yourself ",
                            ),
                            cursorColor: MyColors.myOrange,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.057,
                width: width * 0.43,
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 10,
                    child: Center(
                        child: Text(
                      "Your Gender",
                      style: TextStyle(
                        fontSize: height * 0.025,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ),
                ),
              ),
              SizedBox(
                // margin: EdgeInsets.only(left: 20),
                height: height * 0.057,
                width: width * 0.43,
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 10,
                    child: Center(
                        child: Text("Your date of birth",
                            style: TextStyle(fontSize: height * 0.025),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildFoot(double width, double height) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      child: Column(
        children: [
           SizedBox(
            child: Center(
              child: Text(
                "Add Social Media",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: height*0.04
                ),
              ),
            ),
          ),
          buildSocialList(width,height)
        ],
      ),
    );
  }

  Widget buildSocialList(double width,double height) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 0,
          mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        buildTagCard(FontAwesomeIcons.facebook,Colors.blue,width,height,"Facebook"),
        buildTagCard(FontAwesomeIcons.snapchat,Colors.yellow,width,height,"Snapchat"),
        buildTagCard(FontAwesomeIcons.tiktok,Colors.black,width,height,"TikTok"),
      ],
    );
  }

  Widget buildTagCard(IconData icon,Color color,double width,double height,String text) {
    return Container(
      margin:const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: const BoxDecoration(
        color: MyColors.myWhite,
      ),
      child: InkWell(
        onTap: () {},
        child: Card(
          elevation: 10,
          child: GridTile(
            child: SizedBox(
             child: Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Container(
                       height: 50,
                       width: 50,
                       decoration: BoxDecoration(
                         color: color,
                         borderRadius: BorderRadius.circular(30)
                       ),
                       child: Icon(icon,color: Colors.white,)
                   ),
                   const SizedBox(
                     height: 10,
                   ),
                   Center(
                     child: Text(
                       text
                     ),
                   ),
                 ],
               ),
             ),
            ),
          ),
        ),
      ),
    );
  }
}
