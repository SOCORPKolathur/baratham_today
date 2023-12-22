import 'package:baratham_today/constants.dart';
import 'package:baratham_today/views/intro_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/kText.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  
  @override
  void initState() {
    navigate();
    super.initState();
  }
  
  navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const IntroView()));
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 20),
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
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            KText(
              text: "--  Your NEWS Partner  --",
              style: GoogleFonts.justAnotherHand(
                color: Constants.secondaryAppColor,
                fontSize: 27,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
