import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/income_friend_provider.dart';
import 'package:tic/business_logic_layer/authentication/data/providers/user_provider.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:tic/data_layer/models/deep_link_name.dart';
import 'package:tic/presentation_layer/screens/home_screen/home_screen.dart';
import 'package:tic/presentation_layer/widgets/log_create_widgets/field_box.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({Key? key}) : super(key: key);

  @override
  _UserNameScreenState createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  int groupValue = -1;
  String fullUserName="";
  String fullBio="";
  String selectedDate = 'dd/mm/yyyy';
  String genderHint = "Press to choose your gender";
  bool isUpdating=false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myBlack,
        elevation: 0,
        leading: IconButton(
          splashColor: const Color(0xFFff0000),
          splashRadius: height * 0.03,
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(
            Icons.arrow_back,
            color: MyColors.myWhite,
          ),
        ),
        title: const Text("Complete Register"),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        width: width,
        height: height * 0.07,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              primary: MyColors.myBlack,
              elevation: 10),
          onPressed: ()async {
            bool isValidate=formkey.currentState!.validate();

            bool userNameValidate=_userNameValidate();
            bool bioValidate=_bioValidate();
            bool genderValidate=genderHint!="Press to choose your gender"?true:false;
            bool birthValidate=_birthValidate();

            if(userNameValidate&&bioValidate&&genderValidate&&birthValidate){
              setState(() {
                isUpdating=true;
                Provider.of<UserProvider>(context,listen: false).bio=fullBio;
                Provider.of<UserProvider>(context,listen: false).userName=fullUserName;
              });
              await FirebaseFirestore.instance.collection("User").doc(
                Provider.of<UserProvider>(context,listen: false).uid
              ).update({
                "userName":fullUserName,
                "bio":fullBio,
                "gender":genderHint,
                "birthDay":selectedDate
              }).then((value) async{
                final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                sharedPreferences.setString("docId",
                    Provider.of<UserProvider>(context,listen: false).uid as String
                );
                if (Provider.of<IncomeFriend>(context, listen: false).friendUserName!.isNotEmpty) {
                  setState(() {
                    DeepLinkName.deepLinkName=Provider.of<IncomeFriend>(context, listen: false).friendUserName as String;
                  });
                }else{
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const HomeScreen(whichScreen: 0)));
                }
              }
              );
            }
            setState(() {
              isUpdating=false;
            });
          },
          child:isUpdating?const CircularProgressIndicator(
            color: MyColors.myWhite,
          ): Text(
            "Continue to home page",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: height * 0.025),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FieldBox(
                  onTab: () {},
                  onPressSuffix: (){},
                  width: width,
                  height: height * 0.14,
                  boxName: "Username",
                  boxHint: "Enter username without spacing",
                  boxController: userNameController,
                  fieldType: "userName",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  isHaveSuffix: false,
                  isSecure: false,
                  maxLines: 1,
                  readOnly: false,
                ),
                FieldBox(
                  onTab: () {},
                  width: width,
                  height: height * 0.14,
                  boxName: "Bio",
                  boxHint: "Enter a small summary about you",
                  boxController: bioController,
                  fieldType: "bio",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  isHaveSuffix: false,
                  isSecure: false,
                  maxLines: 1,
                  readOnly: false,
                  onPressSuffix: (){},
                ),
                FieldBox(
                  onTab: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            elevation: 0,
                            child: genderBoxDialog(width, height, context),
                          );
                        });
                  },
                  width: width,
                  height: height * 0.14,
                  boxName: "Gender",
                  boxHint: genderHint,
                  boxController: genderController,
                  fieldType: "gender",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  isHaveSuffix: false,
                  isSecure: false,
                  maxLines: 1,
                  readOnly: true,
                  onPressSuffix: (){},
                ),
                FieldBox(
                  onTab: () {
                    birthDayDialog(context, height);
                  },
                  width: width,
                  height: height * 0.14,
                  boxName: "Birthday",
                  boxHint: selectedDate.trim(),
                  boxController: birthDayController,
                  fieldType: "birth",
                  maxLines: 1,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  isHaveSuffix: false,
                  isSecure: false,
                  readOnly: true,
                  onPressSuffix: (){},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> birthDayDialog(BuildContext context, double height) {
    return showDialog(
      context: context,
      builder: (context) => SfDateRangePicker(
        backgroundColor: MyColors.myWhite,
        selectionColor: MyColors.myBlack,
        todayHighlightColor: MyColors.myBlack,
        endRangeSelectionColor: MyColors.myBlack,
        startRangeSelectionColor: MyColors.myBlack,
        rangeSelectionColor: MyColors.myBlack,
        onSelectionChanged: _onSelectionChanged,
        selectionMode: DateRangePickerSelectionMode.single,
        allowViewNavigation: true,
        headerHeight: height * 0.08,
        onCancel: () {
          Navigator.of(context).pop();
        },
        onSubmit: (value) {
          if (_selectedDate.isEmpty) {
            Navigator.of(context).pop();
          } else {
            setState(() {
              selectedDate = _selectedDate.substring(0, 10);
            });
            Navigator.of(context).pop();
          }
        },
        showTodayButton: true,
        showNavigationArrow: true,
        headerStyle: DateRangePickerHeaderStyle(
            backgroundColor: MyColors.myBlack,
            textStyle:
                TextStyle(color: MyColors.myWhite, fontSize: height * 0.03),
            textAlign: TextAlign.center),
        maxDate: DateTime.now(),
        minDate: DateTime(1960),
        initialSelectedDate: _selectedDate.isEmpty?DateTime.now():DateTime(1999),
        initialDisplayDate: _selectedDate.isEmpty?DateTime.now():DateTime.parse(_selectedDate),
        showActionButtons: true,
      ),
    );
  }

  Container genderBoxDialog(double width, double height, context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: width * 0.8,
      height: height * 0.23,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Select Gender",
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: height * 0.03,
                color: MyColors.myBlack,
                fontWeight: FontWeight.bold),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          groupValue = 0;
                          genderController.text = "Male";
                          genderHint = "Male";
                        });
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          onPrimary: MyColors.myBlack,
                          primary: MyColors.myWhite),
                      child: SizedBox(
                        width: width * 0.6,
                        height: height * 0.03,
                        child: Text(
                          "Male",
                          style: TextStyle(
                              color: MyColors.myBlack,
                              fontSize: height * 0.14 * 0.18,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.7,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          groupValue = 1;
                          genderController.text = "Female";
                          genderHint = "Female";
                        });
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          onPrimary: MyColors.myBlack,
                          primary: MyColors.myWhite),
                      child: SizedBox(
                        width: width * 0.6,
                        height: height * 0.03,
                        child: Text(
                          "Female",
                          style: TextStyle(
                              color: MyColors.myBlack,
                              fontSize: height * 0.14 * 0.18,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  primary: MyColors.myBlack, onPrimary: MyColors.myWhite),
              child: Text(
                "ok",
                style: TextStyle(
                    fontSize: height * 0.03,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.normal),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  bool _birthValidate(){
    if(selectedDate!="dd/mm/yyyy"){
      return true;
    }else{
      return false;
    }
  }
  bool _bioValidate(){
    bool isValidate=true;
    fullBio=bioController.text.trim();
    if(fullBio.isEmpty){
      return false;
    }else if(fullBio.length>20){
      return false;
    }else if(fullBio.length<3){
      return false;
    }
    return isValidate;
  }
  bool _userNameValidate() {
    bool isValidate=true;
    String userName=userNameController.text.trim();
    if(userName.isEmpty){
      return false;
    }else if(userName.length>15||userName.length<3){
      return false;
    }else{
      for(int i=0;i<userName.length;i++){
        if(userName[i]==" "){
          return false;
        }else{
          fullUserName+=userName[i];
        }
      }
      if(fullUserName.length<3||fullUserName.length>15){
        return false;
      }
    }

    return isValidate;
  }
}
