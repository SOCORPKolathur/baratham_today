import 'package:baratham_today/constants.dart';
import 'package:baratham_today/views/main_view.dart';
import 'package:baratham_today/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/kText.dart';

class VerificationComleteView extends StatefulWidget {
  const VerificationComleteView({super.key});

  @override
  State<VerificationComleteView> createState() => _VerificationComleteViewState();
}

class _VerificationComleteViewState extends State<VerificationComleteView> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: height * 0.35),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/12),
                  child: Column(
                    children: [
                      KText(
                        text: "Baratham",
                        style: GoogleFonts.deliusSwashCaps(
                          color: Constants.primaryAppColor,
                          fontSize: width/6,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          KText(
                            text: "Today",
                            style: GoogleFonts.deliusSwashCaps(
                              color: Constants.secondaryAppColor,
                              fontSize: width/12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height/21.6),
                Column(
                  children: [
                    KText(
                      text: "Congratulations!",
                      style: GoogleFonts.poppins(
                        color: Constants.bodyTextColor,
                        fontSize: width/13.33333333333333,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    KText(
                      text: "Your account is ready to use",
                      style: GoogleFonts.poppins(
                        color: Constants.bodyTextColor,
                        fontSize: width/27.69230769230769,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                PrimaryButton(
                  onTap: (){
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                                MainView()),
                            (Route<dynamic> route) => false);
                  },
                  title: "Go to Homepage",
                ),
                SizedBox(height: height/75.6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
