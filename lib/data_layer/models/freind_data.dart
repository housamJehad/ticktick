class FriendData{

  String?name;
  String?photoUrl;
  Map<String,dynamic>links;
  bool ?status;
  int ?index;
  String?bio;
  String?email;
  String ?uid;
  bool?isDirect;
  Map<String,dynamic>?directOn;
  FriendData({required this.name,required this.photoUrl,required this.links,required this.status,required this.index,required this.bio,required this.email,required this.uid,required this.isDirect,required this.directOn});
}