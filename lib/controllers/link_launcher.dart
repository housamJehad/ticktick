import 'package:tic/constant/contact_icon_data.dart';
import 'package:tic/constant/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkLauncher {

  Future<void> launchLink(String url, String type) async {
    String finalUrl = "";
    String testUrl = "";
    if (!url.contains("https://")) {
      testUrl = "https://" + url;
    } else {
      testUrl = url;
    }
    if (await canLaunch(testUrl)) {
      if (type == "Facebook") {
        if (url.contains("m.facebook.com")) {
          if (url.contains("https://")) {
            finalUrl = url;
          } else {
            finalUrl = "https://" + url;
          }
          await launch(finalUrl, forceSafariVC: false, forceWebView: false);
        } else {
          await launch("https://m.facebook.com/",
              forceSafariVC: false, forceWebView: false);
        }
      }
      if (type == "Instagram") {
        if (url.contains("instagram.com")) {
          if (url.contains("https://")) {
            finalUrl = url;
          } else {
            finalUrl = "https://" + url;
          }
        } else {
          finalUrl = "https://instagram.com/" + url + "/";
        }
        await launch(finalUrl, forceSafariVC: false, forceWebView: false);
      }
      if (type == "TikTok") {
        if (url.contains("tiktok.com")) {
          if (url.contains("https://")) {
            finalUrl = url;
          } else {
            finalUrl = "https://" + url;
          }
          await launch(finalUrl, forceSafariVC: false, forceWebView: false);
        } else {
          await launch("https://tiktok.com",
              forceSafariVC: false, forceWebView: false);
        }
      }
      if (type == "Snapchat") {
        if (url.contains("snapchat.com")) {
          if (url.contains("https://")) {
            finalUrl = url;
          } else {
            finalUrl = "https://" + url;
          }
          await launch(finalUrl, forceSafariVC: false, forceWebView: false);
        } else {
          await launch("https://snapchat.com",
              forceSafariVC: false, forceWebView: false);
        }
      }
      if (type == "Twitter") {
        if (url.contains("twitter.com")) {
          if (url.contains("https://")) {
            finalUrl = url;
          } else {
            finalUrl = "https://" + url;
          }
          await launch(finalUrl, forceSafariVC: false, forceWebView: false);
        } else {
          await launch("https://twitter.com",
              forceSafariVC: false, forceWebView: false);
        }
      }
      if (type == "Linkedin") {
        if (url.contains("linkedin.com")) {
          if (url.contains("https://")) {
            finalUrl = url;
          } else {
            finalUrl = "https://" + url;
          }
          await launch(finalUrl, forceSafariVC: false, forceWebView: false);
        } else {
          await launch("https://linkedin.com",
              forceSafariVC: false, forceWebView: false);
        }
      }
      if (type == "E-mail") {
        finalUrl = 'mailto:$url';
        await launch(finalUrl, forceSafariVC: false, forceWebView: false);
      }
      if (type == "Phone") {
        finalUrl = 'tel:$url';
        await launch(finalUrl, forceSafariVC: false, forceWebView: false);
      }
      if (type == "Message") {
        finalUrl = 'sms:$url';
        await launch(finalUrl, forceSafariVC: false, forceWebView: false);
      }
      if (type == "Custom Link") {
        if (url.contains("https://")) {
          finalUrl = url;
        } else {
          finalUrl = "https://" + url;
        }
        await launch(finalUrl, forceSafariVC: false, forceWebView: false);
      }
      if (type == "Whatsapp") {
        finalUrl = 'whatsapp://send?phone=$url';
        await launch(finalUrl, forceSafariVC: false, forceWebView: false);
      }
      if (type == "Youtube") {
        if (url.contains("youtube.com")) {
          if (url.contains("https://")) {
            finalUrl = url;
          } else {
            finalUrl = "https://" + url;
          }
          await launch(finalUrl, forceSafariVC: false, forceWebView: false);
        } else {
          await launch("https://youtube.com",
              forceSafariVC: false, forceWebView: false);
        }
      }
      if (type == "Telegram") {
        if (url.contains("t.me")) {
          if (url.contains("https://")) {
            finalUrl = url;
          } else {
            finalUrl = "https://" + url;
          }
          await launch(finalUrl, forceSafariVC: false, forceWebView: false);
        } else {
          await launch("https://telegram.com",
              forceSafariVC: false, forceWebView: false);
        }
      }
      if (type == "Pinterest") {
        if (url.contains("pin.it")) {
          if (url.contains("https://")) {
            finalUrl = url;
          } else {
            finalUrl = "https://" + url;
          }
          await launch(finalUrl, forceSafariVC: false, forceWebView: false);
        } else {
          await launch("https://pinterest.com",
              forceSafariVC: false, forceWebView: false);
        }
      }
    }
  }

  ContactIconData getIconData(String iconType) {
    if (iconType == "Facebook") {
      return MyColors.facebookIcon;
    }
    if (iconType == "add_@123") {
      return MyColors.addIcon;
    }
    if (iconType == "Instagram") {
      return MyColors.instagramIcon;
    }
    if (iconType == "TikTok") {
      return MyColors.tiktokIcon;
    }
    if (iconType == "Snapchat") {
      return MyColors.snapchatIcon;
    }
    if (iconType == "Twitter") {
      return MyColors.twitterIcon;
    }
    if (iconType == "Linkedin") {
      return MyColors.linkedinIcon;
    }
    if (iconType == "E-mail") {
      return MyColors.emailIcon;
    }
    if (iconType == "Phone") {
      return MyColors.phoneIcon;
    }
    if (iconType == "Message") {
      return MyColors.messageIcon;
    }
    if (iconType == "Custom Link") {
      return MyColors.customLinkIcon;
    }
    if (iconType == "Whatsapp") {
      return MyColors.whatsappIcon;
    }
    if (iconType == "Viber") {
      return MyColors.viberIcon;
    }
    if (iconType == "Youtube") {
      return MyColors.youtubeIcon;
    }
    if (iconType == "Telegram") {
      return MyColors.telegramIcon;
    }
    if (iconType == "Pinterest") {
      return MyColors.pinterestIcon;
    }

    if (iconType == "Discord") {
      return MyColors.discordIcon;
    }
    return MyColors.locationIcon;
  }

}
