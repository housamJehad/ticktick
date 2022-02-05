import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/constant/contact_icon_data.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/controllers/link_launcher.dart';
import 'package:tic/data_layer/models/link.dart';
import 'package:tic/presentation_layer/widgets/profile_widgets/dialog_to_get_link.dart';
import 'package:tic/presentation_layer/widgets/profile_widgets/edit_profile_screen_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController bioController = TextEditingController(text: "");
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('User');
  final _storage = FirebaseStorage.instance;
  String name = "";
  String bio = "";
  File? image;
  String imageUrl = "";
  String imagePath = "";
  File imageTemporary = File("");
  @override
  void initState() {
    nameController.text =
        Provider.of<UserProvider>(context, listen: false).name as String;
    bioController.text =
        Provider.of<UserProvider>(context, listen: false).bio as String;
    imageUrl =
        Provider.of<UserProvider>(context, listen: false).imageUrl as String;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('User')
            .doc("${Provider.of<UserProvider>(context, listen: false).uid}")
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(MyColors.myOrange)),
            );
          } else {
            Map<String, dynamic> data =
                snapshot.data?.data() as Map<String, dynamic>;
            Provider.of<UserProvider>(context, listen: false).name =
                data['name'];

            Provider.of<UserProvider>(context, listen: false).bio = data['bio'];

            return WillPopScope(
              onWillPop: () async {
                if (Provider.of<UserProvider>(context, listen: false)
                            .bio
                            ?.trim() ==
                        bioController.text.trim() &&
                    Provider.of<UserProvider>(context, listen: false)
                            .name
                            ?.trim() ==
                        nameController.text.trim() &&
                    imageTemporary.path.toString().isEmpty) {
                  Navigator.of(context).pushNamed('/home');
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return showExitDialog(width, height, context);
                      });
                }
                return true;
              },
              child: Scaffold(
                backgroundColor: MyColors.myWhite,
                bottomNavigationBar: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: width,
                  height: height * 0.07,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: MyColors.myBlack, elevation: 10),
                    onPressed: () {
                      if (Provider.of<UserProvider>(context, listen: false)
                                  .bio
                                  ?.trim() ==
                              bioController.text.trim() &&
                          Provider.of<UserProvider>(context, listen: false)
                                  .name
                                  ?.trim() ==
                              nameController.text.trim() &&
                          imageTemporary.path.toString().isEmpty) {
                        Navigator.of(context).pushNamed('/home');
                        // Navigator.of(context).pushNamed(
                        //     '/home');
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return showExitDialog(width, height, context);
                            });
                      }
                    },
                    child: Text(
                      "Save",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: height * 0.025),
                    ),
                  ),
                ),
                appBar: AppBar(
                  backgroundColor: MyColors.myBlack,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      if (Provider.of<UserProvider>(context, listen: false)
                                  .bio
                                  ?.trim() ==
                              bioController.text.trim() &&
                          Provider.of<UserProvider>(context, listen: false)
                                  .name
                                  ?.trim() ==
                              nameController.text.trim() &&
                          imageTemporary.path.toString().isEmpty) {
                        Navigator.of(context).pushNamed('/home',);
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return showExitDialog(width, height, context);
                            });
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: MyColors.myWhite,
                    ),
                  ),
                  title: const Text("Edit profile"),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      personalSection(width, height, data),
                      contactSection(width, height, data),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  showExitDialog(double width, double height, context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(width, height, context),
    );
  }

  contentBox(double width, double height, context) {
    return Container(
      width: width,
      height: height,
      color: Colors.transparent,
      child: Center(
        child: Container(
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
              FittedBox(
                child: Text(
                  "Make changes",
                  maxLines: 2,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: height * 0.025,
                      color: MyColors.myBlack,
                      fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Provider.of<UserProvider>(context, listen: false).name =
                          nameController.text;
                      Provider.of<UserProvider>(context, listen: false).bio =
                          bioController.text;
                      if (imageTemporary.path.toString() != "") {
                        var snapshot = await _storage
                            .ref()
                            .child('folderName/$imagePath')
                            .putFile(imageTemporary);

                        var downloadUrl = await snapshot.ref.getDownloadURL();
                        setState(() {
                          imageUrl = downloadUrl;
                        });
                        Provider.of<UserProvider>(context, listen: false).imageUrl =
                            imageUrl;
                      }
                      users
                          .doc(
                              "${Provider.of<UserProvider>(context, listen: false).uid}")
                          .update(
                        {
                          'name': nameController.text,
                          'bio': bioController.text,
                          'photoUrl': imageUrl
                        },
                      ).then((value) => Navigator.of(context)
                              .pushNamed('/home'));
                    },
                    child: Text(
                      "Save",
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
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/home',);
                    },
                    child: Text(
                      "Don't save",
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  upLoadImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        imageTemporary = File(image!.path);
        this.image = imageTemporary;
      });
      setState(() {
        imagePath = image!.path.toString();
      });
    } on PlatformException catch (e) {}
  }

  Widget personalSection(
      double width, double height, Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Personal Information",
            maxLines: 1,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: height * 0.025,
                color: MyColors.myBlack,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Form(
            key: formkey,
            child: Column(children: [
              EditProfileTextField(
                textController: nameController,
                maxLines: 1,
                prefTextFieldWidget: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: height * 0.03,
                ),
                minLength: 3,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              EditProfileTextField(
                textController: bioController,
                maxLines: 1,
                prefTextFieldWidget: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: height * 0.03,
                ),
                minLength: 10,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                width: width,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: MyColors.myBlack,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.only(
                    left: 15, right: 2, top: 2, bottom: 2),
                margin: const EdgeInsets.only(top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.photo,
                      color: MyColors.myWhite,
                      size: height * 0.035,
                    ),
                    SizedBox(
                      width: width * 0.06,
                    ),
                    SizedBox(
                      height: height * 0.08,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: imageTemporary.path.toString() == ""
                            ? CircleAvatar(
                                radius: 30,
                                child: ClipOval(
                                  child: CircleAvatar(
                                    radius: height * 0.04,
                                    backgroundImage: NetworkImage(
                                      imageUrl,
                                    ),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius: 30,
                                child: ClipOval(
                                  child: CircleAvatar(
                                    radius: height * 0.04,
                                    backgroundImage: FileImage(
                                      imageTemporary,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.06,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        upLoadImage();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: MyColors.myWhite,
                          onPrimary: MyColors.myBlack),
                      child: Text(
                        "Change Photo",
                        style: TextStyle(fontSize: height * 0.025),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  Widget contactSection(width, height, Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Contact Information",
            maxLines: 1,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: height * 0.025,
                color: MyColors.myBlack,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: getContactList(width, height, data),
            ),
          ),
        ],
      ),
    );
  }

  Widget editableContactCell(
      ContactIconData iconData, width, height, String link, String type) {
    return SizedBox(
        height: height * 0.095,
        width: width,
        child: Card(
          elevation: 2,
          color: const Color(0xFFf4f4f4),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                FittedBox(
                  child: Container(
                    margin: const EdgeInsets.only(right: 4),
                    height: height * 0.06,
                    width: width * 0.12,
                    child: Align(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            primary: iconData.iconColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(iconData.photo),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width: width * 0.43,
                    child: Text(
                      iconData.cellName,
                      style: TextStyle(
                        color: MyColors.myBlack,
                        fontSize: height * 0.02,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                SizedBox(
                  width: width * 0.05,
                ),
                CircleAvatar(
                    radius: 20,
                    backgroundColor: MyColors.myBlack,
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DialogToGetLink(
                                    delete: true,
                                    description: "Enter text to update",
                                    linkController:
                                        TextEditingController(text: link),
                                    type: type,
                                    contactIconData: iconData,
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            // size: height * 0.025,
                          )),
                    )),
              ]),
            ),
          ),
        ));
  }

  List<Widget> gridOfContacts = [];
  List<Link> links = [];
  getContactList(double width, double height, data) {
    links.clear();
    gridOfContacts.clear();

    data['links'].forEach((key, value) {
      if(value!=""&&value!="add"){
        if(!data['directOn'].containsKey(key)){
          links.add(Link(type: key, link: value));
        }
      }
    });
    for (int i = 0; i < links.length; i++) {
      if (links[i].type == "add_@123") continue;
      if (links[i].link == "") continue;

      gridOfContacts.add(
        editableContactCell(
          LinkLauncher().getIconData(links[i].type),
          width,
          height,
          links[i].link,
          links[i].type,
        ),
      );
    }
    return gridOfContacts;
  }
}
