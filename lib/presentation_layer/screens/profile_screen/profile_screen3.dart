import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/controllers/link_launcher.dart';
import 'package:tic/data_layer/models/link.dart';
import 'package:tic/presentation_layer/screens/profile_screen/editing_profile_side_screens/edit_profile_screen/direct_on_screen.dart';
import 'package:tic/presentation_layer/screens/profile_screen/editing_profile_side_screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:tic/presentation_layer/widgets/profile_widgets/contact_cell.dart';

class ProfileTestScreen2 extends StatefulWidget {
  const ProfileTestScreen2({Key? key}) : super(key: key);
  @override
  _ProfileTestScreen2State createState() => _ProfileTestScreen2State();
}

class _ProfileTestScreen2State extends State<ProfileTestScreen2> {
  List<ContactCell> gridOfContacts = [];
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
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColors.myWhite,
      body: Container(
        decoration: BoxDecoration(
            color: MyColors.myBlack,
            border: Border.all(color: MyColors.myWhite, width: 0)),
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
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
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        border: Border.all(color: MyColors.myWhite, width: 0),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(60)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 5, top: 20, right: 15, left: 15),
            child: _actionSection(width, height,data),
          ),
          GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: height * 0.9 / height,
            ),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: getContactList(width, height, data),
          ),
        ],
      ),
    );
  }

  getContactList(double width, double height, data) {
    links.clear();
    gridOfContacts.clear();
    data['links'].forEach((key, value) {
      if (value != "") {
        links.add(Link(type: key, link: value));
      }
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

    int pos;
    ContactCell temp = ContactCell(
        width: 0,
        height: 0,
        description: "",
        linkController: TextEditingController(),
        contactIconData: gridOfContacts[0].contactIconData);

    for (int i = 0; i < gridOfContacts.length; i++) {
      pos = i;
      for (int j = i + 1; j < gridOfContacts.length; j++) {
        if (gridOfContacts[j].contactIconData.priority <
            gridOfContacts[pos]
                .contactIconData
                .priority)
        {
          pos = j;
        }
      }
      temp = gridOfContacts[pos]; //swap the current element with the minimum element
      gridOfContacts[pos] = gridOfContacts[i];
      gridOfContacts[i] = temp;
    }

    return gridOfContacts;
  }

  Widget headSection(double width, double height, data) {
    return Container(
      height: height * 0.175,
      decoration: const BoxDecoration(
        color: MyColors.myWhite,
        border: Border(),
      ),
      child: Container(
        height: height * 0.17,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: const BoxDecoration(
          color: MyColors.myBlack,
          border: Border(),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
        ),
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
                              color: MyColors.myWhite,
                              overflow: TextOverflow.ellipsis,
                              fontSize: height * 0.025,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          data['bio'],
                          maxLines: 3,
                          style: TextStyle(
                            color: MyColors.myWhite,
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
          ],
        ),
      ),
    );
  }

  FittedBox _actionSection(double width, double height,Map<String,dynamic>data) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: const Border()),
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
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DirectOnScreen(data: data)));
              },
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
