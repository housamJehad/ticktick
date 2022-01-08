import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tic/constant/contact_icon_data.dart';

class MyColors {
  static const Color myOrange = Color(0xffc0c4cf);
  static const Color myBlack = Color(0xff050828);
  static const myGray = Colors.black54;
  static const Color myWhite = Colors.white;
  static const Color mySecondColor = Colors.black54;
  static const Color myFirstColor = Colors.black;
  static ContactIconData facebookIcon = ContactIconData(
      mainColor: const [Color(0xff0c8af0), Color(0xff0c8af0)],
      iconColor: MyColors.myWhite,
      cellName: "Facebook",
      cellIcon: FontAwesomeIcons.facebook,
      priority: 7,
      photo: "assets/logo3/facebook1.png"
  );

  static ContactIconData instagramIcon = ContactIconData(
      mainColor: const [
        Color(0xff405DE6),
        Color(0xff5851D8),
        Color(0xff833AB4),
        Color(0xffC13584),
        Color(0xffE1306C),
        Color(0xffF56040),
        Color(0xffF77737),
        Color(0xffFCAF45),
        Color(0xffFFDC80)
      ],
      iconColor:const Color(0xffF77737),
      cellName: "Instagram",
      cellIcon: FontAwesomeIcons.instagram,
      photo: "assets/logo3/instagram1.png",
      priority: 8);

  static ContactIconData tiktokIcon = ContactIconData(
      mainColor: const [Colors.black, Colors.black],
      iconColor:Colors.black,
      cellName: "TikTok",
      cellIcon: FontAwesomeIcons.tiktok,
      photo: "assets/logo3/tiktok.png",
      priority: 9);

  static ContactIconData addIcon = ContactIconData(
      mainColor: const [MyColors.myWhite, MyColors.myWhite],
      iconColor: Colors.white,
      cellName: "Add",
      cellIcon: FontAwesomeIcons.plus,
      photo: "assets/logo3/plus3.png",
      priority: 20);
  static ContactIconData snapchatIcon = ContactIconData(
      mainColor: const [Color(0xFFfffc00), Color(0xFFfffc00)],
      iconColor: const Color(0xFFfffc00),
      cellName: "Snapchat",
      cellIcon: LineIcons.snapchat,
    photo: "assets/logo3/snapchat.png",
    priority: 10,
  );

  static ContactIconData twitterIcon = ContactIconData(
      mainColor: const [Color(0xff1AA2F8), Color(0xff1AA2F8)],
      iconColor: const Color(0xff1AA2F8),
      cellName: "Twitter",
      cellIcon: FontAwesomeIcons.twitter,
      photo: "assets/logo3/twitter.png",
      priority: 11);

  static ContactIconData linkedinIcon = ContactIconData(
      mainColor: const [Color(0xFF0A6ABF), Color(0xFF0A6ABF)],
      iconColor: const Color(0xFF0A6ABF),
      cellName: "Linkedin",
      cellIcon: FontAwesomeIcons.linkedin,
      photo: "assets/logo3/linkedin.png",
      priority: 12);


  static ContactIconData emailIcon = ContactIconData(
      mainColor: const [Color(0xff0c8af0), Color(0xff0c8af0)],
      iconColor: const Color(0xff0c8af0),
      cellName: "E-mail",
      cellIcon: Icons.mail,
    photo: "assets/logo3/email2.png",
    priority: 1,
  );

  static ContactIconData phoneIcon = ContactIconData(
      mainColor: [Colors.green, Colors.green],
      cellIcon: FontAwesomeIcons.phoneAlt,
      iconColor: Colors.green,
      cellName: "Phone",
      photo: "assets/logo3/phone1.png",
      priority: 2);

  static ContactIconData messageIcon = ContactIconData(
      mainColor: const [Colors.blue, Colors.blue],
      cellIcon: Icons.message,
      iconColor: Colors.blue,
      cellName: "Message",
      photo: "assets/logo3/message1.png",
      priority: 3);

  static ContactIconData customLinkIcon = ContactIconData(
      mainColor: const [MyColors.myBlack, MyColors.myBlack],
      cellIcon: FontAwesomeIcons.link,
      iconColor: Colors.white,
      cellName: "Custom Link",
      photo: "assets/logo3/link.png",
      priority: 4);

  static ContactIconData whatsappIcon = ContactIconData(
      mainColor: const [Color(0xFF3bd952), Color(0xFF3bd952)],
      cellIcon: FontAwesomeIcons.whatsapp,
      iconColor: const Color(0xFF3bd952),
      cellName: "Whatsapp",
      photo: "assets/logo3/whatsapp.png",
      priority: 5);

  static ContactIconData viberIcon = ContactIconData(
      mainColor: const [Colors.deepPurple, Colors.deepPurple],
      cellIcon: FontAwesomeIcons.viber,
      iconColor: Colors.deepPurple,
      cellName: "Viber",
      photo: "assets/logo3/viber1.png",
      priority: 6);

  static ContactIconData youtubeIcon = ContactIconData(
      mainColor: const [Color(0xffF20505), Color(0xffF20505)],
      cellIcon: FontAwesomeIcons.youtube,
      iconColor: const Color(0xffF20505),
      cellName: "Youtube",
      photo: "assets/logo3/youtube1.png",
      priority: 14);

  static ContactIconData telegramIcon = ContactIconData(
      mainColor: const [Color(0xff2AA2de), Color(0xff2AA2de)],
      cellIcon: FontAwesomeIcons.telegram,
      iconColor: const Color(0xff2AA2de),
      cellName: "Telegram",
      photo: "assets/logo3/telegram1.png",
      priority: 15);

  static ContactIconData pinterestIcon = ContactIconData(
      mainColor: const [Color(0xffCC0C1B), Color(0xffCC0C1B)],
      cellIcon: FontAwesomeIcons.pinterest,
      iconColor: const Color(0xffCC0C1B),
      cellName: "Pinterest",
      photo: "assets/logo3/pint1.png",
      priority: 16);

  static ContactIconData discordIcon = ContactIconData(
      mainColor: const [Color(0xff5663f7), Color(0xff5663f7)],
      cellIcon: FontAwesomeIcons.steam,
      iconColor: const Color(0xff5663f7),
      cellName: "Discord",
      photo: "assets/logo3/discord1.png",
      priority: 18);

  static ContactIconData locationIcon = ContactIconData(
      mainColor: const [Color(0xfff04033), Color(0xfff04033)],
      cellIcon: FontAwesomeIcons.mapMarkerAlt,
      iconColor: Colors.green,
      cellName: "Location",
      photo: "assets/logo3/map1.png",
      priority: 19);
}
