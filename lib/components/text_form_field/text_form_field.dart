import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class TextFormFieldComponent extends StatefulWidget {
  String hintText;
  String labelText;
  var labelicon;
  bool obsecure;
  TextEditingController controller;
  TextFormFieldComponent(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      required this.labelicon,
      this.obsecure = false});

  @override
  State<TextFormFieldComponent> createState() => _TextFormFieldComponentState();
}

class _TextFormFieldComponentState extends State<TextFormFieldComponent> {
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      onFocusChange: (hasFocus) {
        setState(() {});
      },
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
              color: focusNode.hasFocus ? Colors.yellow : Colors.black,
              width: focusNode.hasFocus ? 2 : 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
                labelText: widget.labelText,
                labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, color: Colors.yellow),
                hintText: widget.hintText,
                hintStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                )),
          ),
        ),
      ),
    );
  }
}
