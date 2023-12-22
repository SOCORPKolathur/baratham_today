import 'package:baratham_today/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'kText.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    super.key,
    required this.color,
    required this.title,
    required this.description,
    required this.skip,
    required this.image,
    required this.onTab,
    required this.index,});

  final String color;
  final String title;
  final String description;
  final bool skip;
  final String image;
  final VoidCallback onTab;
  final int index;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: height * 0.65,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.fill
              )
          ),
        ),
        Positioned(
          top: height * 0.65,
          right: 0,
          left: 0,
          child: Container(
            height: MediaQuery.of(context).size.height / 2.16,
            decoration: BoxDecoration(
                color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: title,
                    style: GoogleFonts.poppins(
                      color: Constants.secondaryAppColor,
                      fontSize: width/18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: height/47.25),
                  KText(
                    text: description,
                    style: GoogleFonts.poppins(
                      color: Constants.bodyTextColor,
                      fontSize: width/25.71428571428571,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}