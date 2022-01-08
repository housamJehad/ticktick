import 'package:flutter/material.dart';
import 'package:tic/constant/my_colors.dart';

class FieldBox extends StatefulWidget {
  final double width, height;
  final String boxName, boxHint, fieldType;
  final int maxLines;
  final bool readOnly;
  final VoidCallback onTab;
  final TextEditingController boxController;
  const FieldBox(
      {Key? key,
      required this.width,
      required this.height,
      required this.boxName,
      required this.boxHint,
      required this.boxController,
      required this.fieldType,
      required this.maxLines,
      required this.onTab,
      required this.readOnly})
      : super(key: key);

  @override
  _FieldBoxState createState() => _FieldBoxState();
}

class _FieldBoxState extends State<FieldBox> {
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    double width = widget.width;
    double height = widget.height;
    return FittedBox(
      child: InkWell(
        onTap: widget.onTab,
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.24,
                  width: width,
                  child: Text(
                    widget.boxName,
                    style: TextStyle(
                        color: MyColors.myBlack,
                        fontSize: height * 0.21,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                FittedBox(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: TextFormField(
                              readOnly: widget.readOnly,
                              maxLines: widget.maxLines,
                              controller: widget.boxController,
                              cursorColor: MyColors.myBlack,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: widget.boxHint),
                              validator: widget.fieldType == "email"
                                  ? (String? text) {
                                      String fullText = text as String;
                                      if (fullText.isEmpty) {
                                        setState(() {
                                          errorMessage = "*Required";
                                        });
                                      } else {
                                        Pattern pattern =
                                            r"^[a-zA-Z0-9.!#$%&'+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                            r"{0,253}[a-zA-Z0-9])?)$";
                                        RegExp regex =
                                            RegExp(pattern as String);
                                        if (!regex.hasMatch(fullText)) {
                                          setState(() {
                                            errorMessage =
                                                'Enter a valid email address';
                                          });
                                        } else {
                                          setState(() {
                                            errorMessage = "";
                                          });
                                        }
                                      }
                                    }
                                  :widget.fieldType=="gender"?(String? text){
                                 if(widget.boxHint=="Press to choose your gender"){
                                   setState(() {
                                     errorMessage="*Required";
                                   });
                                 }else{
                                   setState(() {
                                     errorMessage="";
                                   });
                                 }
                              }:widget.fieldType=="birth"?(String? text){
                                if(widget.boxHint=="dd/mm/yyyy"){
                                  setState(() {
                                    errorMessage="*Required";
                                  });
                                }else{
                                  setState(() {
                                    errorMessage="";
                                  });
                                }
                              }:widget.fieldType=="userName"?(String? text){
                                String fullText=text as String;
                                fullText=fullText.trim();
                                if(fullText.isEmpty){
                                  setState(() {
                                    errorMessage="*Required";
                                  });
                                }else{
                                  if(fullText.length>15){
                                    setState(() {
                                      errorMessage="Enter at most 15 letters";
                                    });
                                  } else if(fullText.length<3){
                                    setState(() {
                                      errorMessage="Enter at least 3 letters";
                                    });
                                  }else{
                                    if(fullText.length>3){
                                      bool hasSpace=false;
                                      for(int i=0;i<fullText.length;i++){
                                        if(fullText[i]==" "){
                                          setState(() {
                                            errorMessage="Enter username without space";
                                            hasSpace=true;
                                          });
                                          break;
                                        }
                                      }
                                      if(hasSpace){
                                        setState(() {
                                          errorMessage="Enter username without space";
                                        });
                                      }else{
                                        setState(() {
                                          errorMessage="";
                                        });
                                      }
                                    }
                                  }
                                }
                              }:widget.fieldType=="bio"?(String? text){
                                String fullText=text as String;
                                fullText=fullText.trim();
                                if(fullText.isEmpty){
                                  errorMessage = "*Required";
                                }else if(fullText.length<3){
                                 setState(() {
                                   errorMessage = "Enter at least 3 letters";
                                 });
                                }else if(fullText.length>20){
                                  setState(() {
                                    errorMessage = "Enter at most 20 letters";
                                  });
                                }else{
                                  setState(() {
                                    errorMessage="";
                                  });
                                }
                              }: (String? text) {
                                      String fullText = text as String;
                                      if (fullText.isEmpty) {
                                        setState(() {
                                          errorMessage = "*Required";
                                        });
                                      } else {
                                        if (widget.fieldType == "name") {
                                          if (fullText.length < 3) {
                                            setState(() {
                                              errorMessage =
                                                  "Enter at least 3 letters";
                                            });
                                          } else if (fullText.length > 10) {
                                            setState(() {
                                              errorMessage =
                                                  "Enter at most 10 letters";
                                            });
                                          } else {
                                            setState(() {
                                              errorMessage = "";
                                            });
                                          }
                                        } else if (widget.fieldType ==
                                            "phone") {
                                          if (fullText.length < 10) {
                                            setState(() {
                                              errorMessage = "Enter 10 number";
                                            });
                                          } else if (fullText.length > 10) {
                                            setState(() {
                                              errorMessage =
                                                  "Enter at most 10 letters";
                                            });
                                          } else {
                                            setState(() {
                                              errorMessage = "";
                                            });
                                          }
                                        } else if (widget.fieldType ==
                                            'password') {
                                          if (fullText.length < 8) {
                                            setState(() {
                                              errorMessage =
                                                  "Enter at least 8 letters or numbers";
                                            });
                                          } else if (fullText.length > 15) {
                                            setState(() {
                                              errorMessage =
                                                  "Enter at most 15 letters or numbers";
                                            });
                                          } else {
                                            setState(() {
                                              errorMessage = "";
                                            });
                                          }
                                        }
                                      }
                                    },
                            ),
                    ),
                  ),
                ),
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
