import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/income_friend_provider.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/controllers/link_launcher.dart';
import 'package:tic/data_layer/models/freind_data.dart';
import 'package:tic/data_layer/models/link.dart';
import 'package:tic/presentation_layer/screens/home_screen/home_screen.dart';
import 'package:tic/presentation_layer/widgets/friend_widgets/content_box.dart';
import 'package:tic/presentation_layer/widgets/profile_widgets/contact_cell.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FriendDetailScreen1 extends StatefulWidget {
  final FriendData friendData;
  final int type;
  final bool isFriend;
  final Map<String, dynamic> data;
  const FriendDetailScreen1(
      {Key? key,
      required this.friendData,
      required this.type,
      required this.data,
      required this.isFriend})
      : super(key: key);
  @override
  _FriendDetailScreen1State createState() => _FriendDetailScreen1State();
}

class _FriendDetailScreen1State extends State<FriendDetailScreen1> {
  bool isWeb = false, isBigScreen = false, isFriend = false;
  String finalDocId = "";
  List<ContactCell> gridOfContacts = [];
  List<Link> links = [];
  CollectionReference users = FirebaseFirestore.instance.collection('User');
  @override
  void dispose() {
    gridOfContacts.clear();
    links.clear();
    super.dispose();
  }

  Future getExistData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? docId = sharedPreferences.getString("docId");
    setState(() {
      if (docId == null) {
        finalDocId = "";
      } else {
        finalDocId = docId;
      }
    });
  }

  @override
  void initState() {
    getExistData();
    if (kIsWeb) {
      setState(() {
        isWeb = true;
      });
    }
    super.initState();
  }

  showRemoveDialog() {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: ContentBox(data: widget.data,newFriend: widget.friendData),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (width > 650) {
      setState(() {
        isBigScreen = true;
        width = width - (width - 650);
        height = height - (height - 1100);
      });
    }
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: MyColors.myWhite,
        appBar: AppBar(
          backgroundColor: MyColors.myBlack,
          elevation: 0,
          leading: !isWeb
              ?  IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            Provider.of<IncomeFriend>(context,listen: false).friendUserName="";
                          });
                          Navigator.of(context).pushNamed("/home");
                        },)
              : const SizedBox(),
          actions: [
            IconButton(
                onPressed: () async {
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  await Share.share(
                      "https://tick-1c025.web.app/page/${widget.friendData.email}",
                      sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
                },
                icon: const Icon(
                  Icons.send,
                )),
          ],

          title: Text("${widget.friendData.name}"),
        ),
        body: WillPopScope(
          onWillPop: () async {
            setState(() {
              Provider.of<IncomeFriend>(context,listen: false).friendUserName="";
            });
            Navigator.of(context).pushNamed("/home");

            return true;
          },
          child: widget.friendData.status as bool
              ? SizedBox(
                  child: Center(
                    child: Text(
                      "Private account",
                      style: TextStyle(
                        color: MyColors.myBlack,
                        overflow: TextOverflow.ellipsis,
                        fontSize: height * 0.04,
                      ),
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: MyColors.myBlack,
                      border: Border.all(color: MyColors.myWhite, width: 0)),
                  padding: EdgeInsets.zero,
                  margin: isBigScreen
                      ? EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width -
                              (MediaQuery.of(context).size.width - 650))
                      : EdgeInsets.zero,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      headSection(width, height),
                      centerSection(width, height),
                    ],
                  )),
                ),
        ));
  }

  Widget centerSection(double width, double height) {
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
            child: _actionSection(width, height),
          ),
          GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: height * 0.9 / height,
            ),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: getContactList(width, height),
          ),
        ],
      ),
    );
  }

  getContactList(double width, double height) {
    links.clear();
    gridOfContacts.clear();

    if (widget.friendData.isDirect as bool) {
      widget.friendData.directOn?.forEach((key, value) {
        if (value != "") {
          links.add(Link(type: key, link: value));
        }
      });
    } else {
      widget.friendData.links.forEach((key, value) {
        if (value != "") {
          links.add(Link(type: key, link: value));
        }
      });
    }

    for (int i = 0; i < links.length; i++) {
      if (links[i].type == "add_@123") continue;
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
            gridOfContacts[pos].contactIconData.priority) {
          pos = j;
        }
      }
      temp = gridOfContacts[
          pos]; //swap the current element with the minimum element
      gridOfContacts[pos] = gridOfContacts[i];
      gridOfContacts[i] = temp;
    }

    return gridOfContacts;
  }

  Widget headSection(double width, double height) {
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
                              widget.friendData.photoUrl as String,
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
                          widget.friendData.name as String,
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
                          widget.friendData.bio as String,
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

  FittedBox _actionSection(double width, double height) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5),
            ),
            width: width * 0.45,
            height: height * 0.045,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5, primary: MyColors.myWhite),
              onPressed: () async {
                String finalUrl = 'mailto:${widget.friendData.email}';
                await launch(finalUrl,
                    forceSafariVC: false, forceWebView: false);
              },
              child: const FittedBox(
                child: Text(
                  "Send Email",
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
          widget.data.isNotEmpty
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: width * 0.45,
                  height: height * 0.045,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5, primary: MyColors.myOrange),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return showRemoveDialog();
                          });
                    },
                    child: const FittedBox(
                      child: Text(
                        "Remove",
                        style: TextStyle(
                            color: MyColors.myBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: width * 0.45,
                  height: height * 0.045,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5, primary: MyColors.myOrange),
                    onPressed: isWeb
                        ? () async{
                      await launch("https://tick-1c025.web.app/page/${widget.friendData.email}", forceSafariVC: false, forceWebView: false);

                    }
                        : widget.isFriend
                            ? () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return showRemoveDialog();
                                    });
                              }
                            : () {
                                List<dynamic>? friendIds =
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .friend;
                                friendIds?.add(widget.friendData.uid);
                                users
                                    .doc(
                                        "${Provider.of<UserProvider>(context, listen: false).uid}")
                                    .update(
                                  {"friends": friendIds},
                                ).then((value) => Navigator.of(context).pushNamed("/home"));
                              },
                    child: FittedBox(
                      child: Text(
                        isWeb
                            ? "Open in app"
                            : widget.isFriend
                                ? "Remove"
                                : "Add Friend",
                        style: const TextStyle(
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
