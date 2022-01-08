import 'package:flutter/material.dart';


class OutLinkScreen extends StatefulWidget {
  const OutLinkScreen({Key? key}) : super(key: key);
  @override
  _OutLinkScreenState createState() => _OutLinkScreenState();
}

class _OutLinkScreenState extends State<OutLinkScreen> {
  Widget whichScreen=const SizedBox();
  @override
  void initState() {
    super.initState();
     setState(() {
       whichScreen=const Center(child:Text("There is no link to show"));
     });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:whichScreen,
    );
  }
}
