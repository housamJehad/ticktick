import 'package:flutter/material.dart';
import 'package:tic/constant/contact_icon_data.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/controllers/link_launcher.dart';
import 'package:tic/presentation_layer/widgets/profile_widgets/dialog_to_get_link.dart';

class ContactCell extends StatefulWidget {
  final double width, height;
  final String description;
  final TextEditingController linkController;
  final ContactIconData contactIconData;
  const ContactCell({
    Key? key,
    required this.width,
    required this.height,
    required this.description,
    required this.linkController,
    required this.contactIconData,
  }) : super(key: key);

  @override
  _ContactCellState createState() => _ContactCellState();
}

class _ContactCellState extends State<ContactCell> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
          child:Container(
            height: widget.height+widget.height*0.25,
            // width: widget.width+widget.width,
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
            child: ElevatedButton(
              onPressed: () {
                if (widget.description == "1add") {
                  Navigator.pushNamed(context, '/allContact');
                } else if (widget.description.isEmpty) {
                      () {};
                } else if (widget.description.startsWith("1", 0)) {
                  LinkLauncher().launchLink(
                      widget.description
                          .substring(1, widget.description.length),
                      widget.contactIconData.cellName);
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogToGetLink(
                          delete: false,
                          description: widget.description,
                          linkController: widget.linkController,
                          type: widget.contactIconData.cellName,
                          contactIconData: widget.contactIconData,
                        );
                      });
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                primary: Colors.white,
                elevation: 0,
                shadowColor: widget.contactIconData.mainColor[1],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    height: widget.height * 0.98,
                    width: widget.width + widget.width / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: widget.contactIconData.iconColor,
                      image: DecorationImage(
                        image: AssetImage(widget.contactIconData.photo),
                        fit: BoxFit.cover,
                      ),
                    ),

                  ),
                  SizedBox(
                    height: widget.height * 0.07,
                  ),
                  Text(
                    widget.contactIconData.cellName,
                    style: TextStyle(
                        color: MyColors.myBlack,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                        fontSize: widget.height * 0.15),
                  )
                ],
              ),
            ),
          ),
    );
  }

}












//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:tic/constant/contact_icon_data.dart';
// import 'package:tic/constant/my_colors.dart';
// import 'package:tic/controllers/link_launcher.dart';
// import 'package:tic/presentation_layer/widgets/profile_widgets/dialog_to_get_link.dart';
//
// class ContactCell extends StatefulWidget {
//   final double width, height;
//   final String description;
//   final TextEditingController linkController;
//   final ContactIconData contactIconData;
//   const ContactCell({
//     Key? key,
//     required this.width,
//     required this.height,
//     required this.description,
//     required this.linkController,
//     required this.contactIconData,
//   }) : super(key: key);
//
//   @override
//   _ContactCellState createState() => _ContactCellState();
// }
//
// class _ContactCellState extends State<ContactCell> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.zero,
//       margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//       height: widget.height,
//       child: InkWell(
//         onTap: () {
//           if (widget.description == "1add") {
//             Navigator.pushNamed(context, '/allContact');
//           } else if (widget.description.isEmpty) {
//                 () {};
//           } else if (widget.description.startsWith("1", 0)) {
//             LinkLauncher().launchLink(
//                 widget.description.substring(1, widget.description.length),
//                 widget.contactIconData.cellName);
//           } else {
//             showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return DialogToGetLink(
//                     delete: false,
//                     description: widget.description,
//                     linkController: widget.linkController,
//                     type: widget.contactIconData.cellName,
//                     contactIconData: widget.contactIconData,
//                   );
//                 });
//           }
//         },
//         child: FittedBox(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 padding: EdgeInsets.zero,
//                 height: widget.height * 0.98,
//                 width: widget.width + widget.width / 2,
//                 child: ElevatedButton(
//                     onPressed: () {
//                       if (widget.description == "1add") {
//                         Navigator.pushNamed(context, '/allContact');
//                       } else if (widget.description.isEmpty) {
//                             () {};
//                       } else if (widget.description.startsWith("1", 0)) {
//                         LinkLauncher().launchLink(
//                             widget.description
//                                 .substring(1, widget.description.length),
//                             widget.contactIconData.cellName);
//                       } else {
//                         showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return DialogToGetLink(
//                                 delete: false,
//                                 description: widget.description,
//                                 linkController: widget.linkController,
//                                 type: widget.contactIconData.cellName,
//                                 contactIconData: widget.contactIconData,
//                               );
//                             });
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.zero,
//                       elevation: 10,
//                       shadowColor: widget.contactIconData.mainColor[1],
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30)),
//                     ),
//                     child:
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         color: widget.contactIconData.iconColor,
//                         image: DecorationImage(
//                           image: AssetImage(widget.contactIconData.photo),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     )
//                 ),
//               ),
//               SizedBox(
//                 height: widget.height * 0.07,
//               ),
//               Text(
//                 widget.contactIconData.cellName,
//                 style: TextStyle(
//                     color: MyColors.myBlack,
//                     fontWeight: FontWeight.w400,
//                     overflow: TextOverflow.ellipsis,
//                     fontSize: widget.height * 0.15),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }
