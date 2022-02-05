import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/constant/contact_icon_data.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/controllers/link_launcher.dart';
import 'package:tic/data_layer/models/link.dart';


class DirectOnScreen extends StatefulWidget {
  const DirectOnScreen({Key? key, required this.data}) : super(key: key);
  final Map<String,dynamic>data;
  @override
  _DirectOnScreenState createState() => _DirectOnScreenState();
}

class _DirectOnScreenState extends State<DirectOnScreen> {
  List<Widget> gridOfContacts = [];
  List<Link> links = [];
  bool isCheck=false;
  bool originalCheck=false;
  int groupValue=-1;
  String directKey="";
  int originalIndex=-1;
  int changedIndex=-1;
  @override
  void initState() {
    setState(() {
      originalCheck=widget.data['isDirect'];
    });
    if(!widget.data["isDirect"]){
      setState(() {
        isCheck=false;
      });
    }else{
      setState(() {
        isCheck=true;
        widget.data['directOn'].forEach((key,value){
             directKey=key;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: ()async{
          selectDialog(width, height, context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.myBlack,
          elevation: 0,
          leading: IconButton(
            onPressed: ()async{
              selectDialog(width, height, context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: MyColors.myWhite,
            ),
          ),
          title: const Text("Direct On"),
        ),
          bottomNavigationBar: Container(
            margin:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            width: width,
            height: height * 0.07,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: MyColors.myBlack, elevation: 10),
              onPressed: ()async{
                selectDialog(width, height, context);
              },
              child: Text(
                "Save",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: height * 0.025),
              ),
            ),
          ),
        body: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: [
                contactSection(width, height, widget.data)
              ],
            ),
          ),
        )
      ),
    );
  }
  selectDialog(double width,double height,context){
    if(originalCheck==isCheck){
      if(isCheck){
        if(changedIndex>-1&&originalIndex!=changedIndex){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return showExitDialog(width, height, context);
              });
        }else{
          Navigator.of(context)
              .pushNamed('/home',);
        }
      } else if(!isCheck){
        Navigator.of(context)
            .pushNamed('/home',);
      }
    }

    else if(originalCheck!=isCheck){
      if(isCheck){
        if(changedIndex!=-1){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return showExitDialog(width, height, context);
              });
        }else{
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return showSelectDialog(width, height, context);
              });
        }
      }else if(!isCheck){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return showDeleteDialog(width, height, context);
            });
      }
    }
  }

  showExitDialog(double width, double height, context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(width, height, context,"update","Are you sure to make changes"),
    );
  }
  showSelectDialog(double width, double height, context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(width, height, context,"select","Please select one of your contact"),
    );
  }
  showDeleteDialog(double width, double height, context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(width, height, context,"delete","Are you sure to make changes"),
    );
  }

  contentBox(double width, double height, context,String type,String dialogText) {
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
              Text(
                dialogText,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if(type=="update"){
                        Map<String,dynamic>buffer={links[changedIndex].type:links[changedIndex].link};
                        await FirebaseFirestore.instance.collection('User').doc(Provider.of<UserProvider>(context,listen: false).uid).update({
                          'directOn':buffer,'isDirect':true
                        }).then((value) =>Navigator.of(context).pushNamed(
                            '/home')
                        );
                      }else if(type=="select"){
                        Navigator.of(context).pop();
                      }else{
                        await FirebaseFirestore.instance.collection('User').doc(Provider.of<UserProvider>(context,listen: false).uid).update({
                          'directOn': {},'isDirect':false
                        }).then((value) =>Navigator.of(context).pushNamed(
                            '/home',)
                        );
                      }
                    },
                    child: Text(
                      type=="select"?"Select":"Save",
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
                  type=="select"?const SizedBox():ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          '/home',);
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
  Widget contactSection(width, height, Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Direct Off",
                maxLines: 1,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: height * 0.025,
                    color: MyColors.myBlack,
                    fontWeight: FontWeight.bold),
              ),
              Switch(
                value: isCheck,
                activeColor: MyColors.myBlack,
                onChanged: (value){
                  setState(() {
                    isCheck=value;
                  });
                },
              ),
              Text(
                "Direct On",
                maxLines: 1,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: height * 0.025,
                    color: MyColors.myBlack,
                    fontWeight: FontWeight.bold),
              ),
            ],
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


  getContactList(double width, double height, data) {
    links.clear();
    gridOfContacts.clear();
    data['links'].forEach((key, value) {
      if(value!=""&&value!="add"){
        links.add(Link(type: key, link: value));
      }
    });
    int index=0;
    for (int i = 0; i < links.length; i++) {
      if (links[i].type == "add_@123") continue;
      if (links[i].link == "") continue;
      if(links[i].type==directKey){
        if(changedIndex>-1){
          groupValue=changedIndex;
        }else{
          setState(() {
            originalIndex=index;
            groupValue=index;
            changedIndex=index;
          });
        }
      }
      gridOfContacts.add(
        editableContactCell(
          LinkLauncher().getIconData(links[i].type),
          width,
          height,
          links[i].link,
          links[i].type,
          index++
        ),
      );
    }
    return gridOfContacts;
  }

  Widget editableContactCell(
      ContactIconData iconData, width, height, String link, String type,int index) {
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
                isCheck?
                Radio<int>(
                  activeColor: MyColors.myBlack,
                    value: index,
                    groupValue: groupValue,
                    onChanged: (value){
                      setState(() {
                        changedIndex=value as int;
                        groupValue=value;
                      });

                    }
                ):const SizedBox(width: 10,),
              ]),
            ),
          ),
        ));
  }
}
