import 'package:baratham_today/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'kText.dart';

class SecondaryButton extends StatefulWidget {
  const SecondaryButton({super.key, required this.onTap, required this.title, required this.icon});

  final Function onTap;
  final String title;
  final String icon;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
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
        height: height/16.8,
        width: width * 0.42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Constants.lightGrey,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height/37.8,
                width: width/18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      widget.icon,
                    )
                  )
                ),
              ),
              SizedBox(width: width/36),
              KText(
                text: widget.title,
                style: GoogleFonts.poppins(
                  color: Constants.bodyTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: width/25.71428571428571,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
