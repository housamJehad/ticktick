class ContactList{
  List<Type> contactList=[
    Type(type: "Facebook",url: "https://m.facebook.com/housam.jehad.1"),
    Type(type: "Instagram",url: "hajq987"),
    Type(type: "TikTok",url: "https://vm.tiktok.com/ZSeFSxeTJ/"),
    Type(type: "Snapchat",url: "https://snapchat.com/add/modelroz"),
    Type(type: "Twitter",url: "https://twitter.com/Housam47745921?s=09"),
    Type(type: "Linkedin",url: "https://www.linkedin.com/in/housam-jehad-ab1b42173"),
    Type(type: "E-mail",url: "housamjehad77@gmail.com"),
    Type(type: "Phone",url: "0772552652"),
    Type(type: "Message",url: "0771445632"),
    Type(type: "Custom Link",url: "codeforces.com"),
    Type(type: "Whatsapp",url: "+962777297298"),
    Type(type: "Youtube",url: "https://www.youtube.com/channel/UC-xKe8OUANsGbZ5bPvy8PPQ"),
    Type(type: "Telegram",url: "https://t.me/desimovies"),
    Type(type: "Pinterest",url: "https://www.pinterest.com/housamjehad79"),
  ];
  addTypeToList(Type newType){
    contactList.add(newType);
  }
}


class Type{
  String type;
  String url;

  Type({required this.type, required this.url});
}