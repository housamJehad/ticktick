import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tic/constant/my_colors.dart';

class EditProfileTextField extends StatefulWidget {
  final TextEditingController textController;
  final int maxLines;
  final int minLength;
  final Widget prefTextFieldWidget;
  const EditProfileTextField({Key? key,required this.textController,required this.maxLines,required this.minLength,required this.prefTextFieldWidget}) : super(key: key);

  @override
  _EditProfileTextFieldState createState() => _EditProfileTextFieldState();
}

class _EditProfileTextFieldState extends State<EditProfileTextField> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
   return Center(
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: MyColors.myBlack,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
        margin: const EdgeInsets.only(top: 3),
        child: Center(
          child: TextFormField(
              controller: widget.textController,
              cursorColor: Colors.white,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: height*0.03
              ),
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                  prefixIcon:widget.prefTextFieldWidget,
                  suffixIcon: Icon(Icons.edit,color: Colors.white,size: height*0.03),
                  focusedBorder: InputBorder.none
              ),
              validator: MultiValidator([
                RequiredValidator(errorText: "* Required"),
                EmailValidator(errorText: "Enter at least 3 letters"),
                MinLengthValidator(widget.minLength, errorText:"Enter at least ${widget.minLength}letters")
              ])
          ),
        ),
      ),
    );
  }
}
