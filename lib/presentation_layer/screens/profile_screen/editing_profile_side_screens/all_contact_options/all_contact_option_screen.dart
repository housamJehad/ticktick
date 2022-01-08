import 'package:flutter/material.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/presentation_layer/widgets/profile_widgets/contact_cell.dart';

class AllContactOptionScreen extends StatefulWidget {
  const AllContactOptionScreen({Key? key}) : super(key: key);
  @override
  _AllContactOptionScreenState createState() => _AllContactOptionScreenState();
}

class _AllContactOptionScreenState extends State<AllContactOptionScreen> {
  List<TextEditingController> contactControllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 19; i++) {
      contactControllers.add(TextEditingController(text: ""));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
         return true;
       },
      child: Scaffold(
        backgroundColor: MyColors.myWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MyColors.myBlack,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("Contact List"),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          width: width,
          height: height * 0.07,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: MyColors.myBlack, elevation: 10),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
            },
            child: Text(
              "Save",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: height * 0.025),
            ),
          ),
        ),
        body: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _optionGroupText(width, height, "Social Media"),
                socialMediaSection(width, height),
                _optionGroupText(width, height, "Contact"),
                contactSection(width, height),
                _optionGroupText(width, height, "Other"),
                otherSection(width, height)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _optionGroupText(double width, double height, String groupName) {
    return Container(
      height: height * 0.06,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        color: MyColors.myBlack,
        elevation: 4,
        shadowColor: MyColors.myOrange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            groupName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: height * 0.03, color: MyColors.myWhite),
          ),
        ),
      ),
    );
  }

  Widget socialMediaSection(double width, double height) {
    return Container(
      color: MyColors.myWhite,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: height * 0.9 / height,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your facebook page link",
            linkController: contactControllers[0],
            contactIconData: MyColors.facebookIcon,
          ),
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            linkController: contactControllers[1],
            description: "Enter your instagram username",
            contactIconData: MyColors.instagramIcon,
          ),
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your tiktok link",
            linkController: contactControllers[2],
            contactIconData: MyColors.tiktokIcon,
          ),
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your snapchat link",
            linkController: contactControllers[3],
            contactIconData: MyColors.snapchatIcon,
          ),
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your twitter username",
            linkController: contactControllers[4],
            contactIconData: MyColors.twitterIcon,
          ),
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your linkedin link",
            linkController: contactControllers[5],
            contactIconData: MyColors.linkedinIcon,
          ),
        ],
      ),
    );
  }

  Widget contactSection(double width, double height) {
    return Container(
      color: MyColors.myWhite,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: height * 0.9 / height,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your e-mail",
            linkController: contactControllers[7],
            contactIconData: MyColors.emailIcon,
          ),
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your phone number",
            linkController: contactControllers[8],
            contactIconData: MyColors.phoneIcon,
          ),
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your phone number",
            linkController: contactControllers[9],
            contactIconData: MyColors.messageIcon,
          ),
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your custom link",
            linkController: contactControllers[10],
            contactIconData: MyColors.customLinkIcon,
          ),
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your whatsapp number",
            linkController: contactControllers[11],
            contactIconData: MyColors.whatsappIcon,
          ),
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your viber number",
            linkController: contactControllers[12],
            contactIconData: MyColors.viberIcon,
          ),
        ],
      ),
    );
  }

  Widget otherSection(double width, double height) {
    return Container(
      color: MyColors.myWhite,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: height * 0.9 / height,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your youtube channel link",
            linkController: contactControllers[13],
            contactIconData: MyColors.youtubeIcon,
          ),
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your telegram phone number",
            linkController: contactControllers[14],
            contactIconData: MyColors.telegramIcon,
          ),
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your pinterest link",
            linkController: contactControllers[15],
            contactIconData: MyColors.pinterestIcon,
          ),
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your discord link",
            linkController: contactControllers[17],
            contactIconData: MyColors.discordIcon,
          ),
          ContactCell(
            width: width * 0.24,
            height: height * 0.18,
            description: "Enter your location",
            linkController: contactControllers[18],
            contactIconData: MyColors.locationIcon,
          ),
        ],
      ),
    );
  }
}
