import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/controllers/link_launcher.dart';
import 'package:tic/data_layer/models/link.dart';
import 'package:tic/presentation_layer/screens/profile_screen/editing_profile_side_screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:tic/presentation_layer/widgets/profile_widgets/contact_cell.dart';

class ProfileTestScreen extends StatefulWidget {
  const ProfileTestScreen({Key? key}) : super(key: key);
  @override
  _ProfileTestScreenState createState() => _ProfileTestScreenState();
}

class _ProfileTestScreenState extends State<ProfileTestScreen> {
  List<Widget> gridOfContacts = [];
  List<Link> links = [];
  @override
  void dispose() {
    gridOfContacts.clear();
    links.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      body: Container(
        color: MyColors.myWhite,
        child: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('User')
                  .doc(
                      "${Provider.of<UserProvider>(context, listen: false).uid}")
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(MyColors.myOrange)),
                  );
                } else {
                  Map<String, dynamic> data =
                      snapshot.data?.data() as Map<String, dynamic>;
                  links.clear();
                  gridOfContacts.clear();
                  return Column(
                    children: [
                      headSection(width, height, data),
                      centerSection(width, height, data),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget centerSection(double width, double height, data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: height * 0.85 / height,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: getContactList(width, height, data),
      ),
    );
  }

  getContactList(double width, double height, data) {
    links.clear();
    gridOfContacts.clear();
    data['links'].forEach((key, value) {
      links.add(Link(type: key, link: value));
    });
    for (int i = 0; i < links.length; i++) {
      gridOfContacts.add(ContactCell(
        height: height * 0.20,
        width: width * 0.26,
        contactIconData: LinkLauncher().getIconData(links[i].type),
        description: "1${links[i].link}",
        linkController: TextEditingController(),
      ));
    }
    return gridOfContacts;
  }

  Widget headSection(double width, double height, data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: height * 0.14,
                    width: width * 0.3,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                          radius: height * 0.07,
                          backgroundImage: NetworkImage(
                            data['photoUrl'],
                          )),
                    ),
                  ),
                ],
              ),
              FittedBox(
                child: Container(
                  width: width * 0.5,
                  height: height * 0.1,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        data['name'],
                        maxLines: 1,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: height * 0.025,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data['bio'],
                        maxLines: 3,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: height * 0.025,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          FittedBox(
            child: SizedBox(
              width: width,
              height: height * 0.06,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Text(
                    data['email'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: MyColors.myBlack, fontSize: height * 0.025),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: height*0.005,),
          _actionSection(width, height),
        ],
      ),
    );
  }

  FittedBox _actionSection(double width, double height) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: MyColors.myOrange)),
            width: width * 0.45,
            height: height * 0.045,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5, primary: MyColors.myWhite),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()));
              },
              child: const FittedBox(
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                      color: MyColors.myBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.02,
          ),
          SizedBox(
            width: width * 0.45,
            height: height * 0.045,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5, primary: MyColors.myOrange),
              onPressed: () {},
              child: const FittedBox(
                child: Text(
                  "Direct on",
                  style: TextStyle(
                      color: MyColors.myBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
