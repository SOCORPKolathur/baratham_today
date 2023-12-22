import 'package:baratham_today/constants.dart';
import 'package:baratham_today/views/intro_view.dart';
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
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      KText(
                        text: "Baratham",
                        style: GoogleFonts.deliusSwashCaps(
                          color: Constants.primaryAppColor,
                          fontSize: 60,
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
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 35),
                Column(
                  children: [
                    KText(
                      text: "Congratulations!",
                      style: GoogleFonts.poppins(
                        color: Constants.bodyTextColor,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    KText(
                      text: "Your account is ready to use",
                      style: GoogleFonts.poppins(
                        color: Constants.bodyTextColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                PrimaryButton(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const MainView()));
                  },
                  title: "Go to Homepage",
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
