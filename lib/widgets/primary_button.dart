import 'package:baratham_today/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'kText.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({super.key, required this.onTap, required this.title});

  final Function onTap;
  final String title;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return InkWell(
      onTap: (){
        widget.onTap();
      },
      child: Container(
        height: height/15.12,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Constants.primaryAppColor,
        ),
        child: Center(
          child: KText(
            text: widget.title,
            style: GoogleFonts.poppins(
              color: Constants.primaryWhite,
              fontWeight: FontWeight.w600,
              fontSize: width/21.17647058823529,
            ),
          ),
        ),
      ),
    );
  }
}
