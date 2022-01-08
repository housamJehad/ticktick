import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/constant/contact_icon_data.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/controllers/link_launcher.dart';
import 'package:tic/data_layer/models/link.dart';
import 'package:tic/presentation_layer/widgets/profile_widgets/contact_cell.dart';

class DialogToGetLink extends StatefulWidget {
  final String description;
  final TextEditingController linkController;
  final String type;
  final ContactIconData contactIconData;
  final bool delete;
  const DialogToGetLink(
      {Key? key,
      required this.description,
      required this.linkController,required this.type, required this.contactIconData,required this.delete})
      : super(key: key);
  @override
  _DialogToGetLinkState createState() => _DialogToGetLinkState();
}

class _DialogToGetLinkState extends State<DialogToGetLink> {

  CollectionReference users = FirebaseFirestore.instance.collection('User');
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context, width, height),
    );
  }

  contentBox(context, double width, double height) {
    Map<String,dynamic>contactList={};
    List<Link>links=[];
    return Container(
      width: width * 0.8,
      height: height * 0.4,
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ContactCell(
            width: width * 0.17,
            height: height * 0.12,
            description: '',linkController: TextEditingController(),
            contactIconData: widget.contactIconData,
          ),
          Text(
            widget.description,
            maxLines: 2,
            style: TextStyle(
              fontSize: height * 0.02,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          SizedBox(
              width: width * 0.65,
              height: height * 0.07,
              child: Card(
                elevation: 2,
                child: TextFormField(
                  enableInteractiveSelection: true,
                  readOnly: false,
                  toolbarOptions: const ToolbarOptions(
                    paste: true,copy: true,cut: true,selectAll: true
                  ),
                  controller: widget.linkController,
                  cursorColor: MyColors.myOrange,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: height * 0.027,
                    color: MyColors.myBlack,
                    overflow: TextOverflow.ellipsis,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "EnterText",
                    prefixIcon: Icon(Icons.text_fields),
                  ),
                ),
              )),
          SizedBox(
            height: height * 0.02,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text(
                    "open",
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: height * 0.025,
                        color: MyColors.myWhite),
                  ),
                  onPressed: () {
                    LinkLauncher().launchLink(widget.linkController.text, widget.type);
                    },
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    primary: MyColors.myBlack,
                  ),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  child: Text(
                    "Save",
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: height * 0.025,
                        color: MyColors.myWhite),
                  ),
                  onPressed: () async{
                      contactList=await FirebaseFirestore.instance.collection('User').doc("${
                          Provider.of<UserProvider>(context, listen: false).uid
                      }").get().then((value) => value['links']);

                     if(contactList.containsKey(widget.type)){
                       contactList.update(widget.type, (value) => widget.linkController.text);
                     }else{
                       contactList.putIfAbsent(widget.type, () => widget.linkController.text);
                     }
                      users.doc("${Provider.of<UserProvider>(context, listen: false).uid}")
                          .update({'links': contactList}).then((value) => Navigator.of(context).pop());

                     contactList.forEach((key, value) {
                       links.add(Link(type: key, link: value));
                     });
                     setState(() {
                        Provider.of<UserProvider>(context, listen: false).links=links;
                      });
                     },
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    primary: MyColors.myBlack,
                  ),
                ),
                const SizedBox(width: 10,),
                Visibility(
                  visible: widget.delete,
                  child: ElevatedButton(
                    child: Text(
                      "Delete",
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: height * 0.025,
                          color: MyColors.myWhite),
                    ),
                    onPressed: () async{
                      contactList=await FirebaseFirestore.instance.collection('User').doc("${
                          Provider.of<UserProvider>(context, listen: false).uid
                      }").get().then((value) => value['links']);
                      setState(() {
                        widget.linkController.text="";
                      });

                      if(contactList.containsKey(widget.type)){
                        contactList.update(widget.type, (value) => widget.linkController.text);
                      }else{
                        contactList.putIfAbsent(widget.type, () => widget.linkController.text);
                      }
                      users.doc("${Provider.of<UserProvider>(context, listen: false).uid}")
                          .update({'links': contactList}).then((value) => Navigator.pushNamedAndRemoveUntil(context, '/edit', (route) => false));
                      contactList.forEach((key, value) {
                        links.add(Link(type: key, link: value));
                      });
                      setState(() {
                        Provider.of<UserProvider>(context, listen: false).links=links;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      primary: MyColors.myBlack,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  //
  // Future<void> _lunchInBrowser(String url,String type)async{
  //   String finalUrl="";
  //   String testUrl="";
  //   if(!url.contains("https://")){
  //     testUrl="https://"+url;
  //   }else{
  //     testUrl=url;
  //   }
  //   print(testUrl);
  //   print(type);
  //   print(url);
  //   if(await canLaunch(testUrl)){
  //     if(type=="Facebook"){
  //       if(url.contains("m.facebook.com")){
  //         if(url.contains("https://")){
  //           finalUrl=url;
  //         }else{
  //           finalUrl="https://"+url;
  //         }
  //         await launch(finalUrl,forceSafariVC: false,forceWebView: false);
  //       }else{
  //         await launch("https://m.facebook.com/",forceSafariVC: false,forceWebView: false);
  //       }
  //     }
  //     if(type=="Instagram"){
  //       if(url.contains("instagram.com")){
  //         if(url.contains("https://")){
  //           finalUrl=url;
  //         }else{
  //           finalUrl="https://"+url;
  //         }
  //       }else{
  //         finalUrl="https://instagram.com/"+url+"/";
  //       }
  //       await launch(finalUrl,forceSafariVC: false,forceWebView: false);
  //     }
  //   }
  // }
}
