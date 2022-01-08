import 'package:flutter/material.dart';

class ContactIconData{
  List<Color>mainColor=[];
  String cellName;
  IconData cellIcon;
  Color iconColor;
  int priority;
  String photo;
  ContactIconData({required this.mainColor,required this.cellName,required this.cellIcon,required this.iconColor,required this.priority,required this.photo});
}