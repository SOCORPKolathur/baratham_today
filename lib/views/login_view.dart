import 'package:baratham_today/constants.dart';
import 'package:baratham_today/views/home_view.dart';
import 'package:baratham_today/views/otp_verification_view.dart';
import 'package:baratham_today/views/sign_up_view.dart';
import 'package:baratham_today/widgets/custom_text_form_filed.dart';
import 'package:baratham_today/widgets/primary_button.dart';
import 'package:baratham_today/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/kText.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/24, vertical: height/75.6),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height/25.2),
                    KText(
                      text: "HELLO",
                      style: GoogleFonts.poppins(
                        color: Constants.secondaryAppColor,
                        fontWeight: FontWeight.w700,
                        fontSize: width/8,
                      ),
                    ),
                    KText(
                      text: "Again!",
                      style: GoogleFonts.poppins(
                        color: Constants.primaryAppColor,
                        fontWeight: FontWeight.w700,
                        fontSize: width/8,
                      ),
                    ),
                    SizedBox(height: height/75.6),
                    KText(
                      text: "Welcome back you've \n been missed",
                      style: GoogleFonts.poppins(
                        color: Constants.bodyTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: width/18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height/25.2),
                CustomTextFormField(
                  label: "Username",
                  required: true,
                  passType: false,
                  controller: userNameController,
                  validator: (val){
            
                  },
                  onSubmitted: (val){
            
                  },
                ),
                SizedBox(height: height/37.8),
                CustomTextFormField(
                  label: "Phone",
                  required: true,
                  passType: false,
                  controller: phoneController,
                  validator: (val){},
                  onSubmitted: (val){},
                ),
                SizedBox(height: height/75.6),
                Padding(
                  padding: EdgeInsets.only(right: width/24),
                  child: SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (val){},
                              splashRadius: 2,
                              visualDensity: VisualDensity.compact,
                            ),
                            KText(
                              text: "Remember Me",
                              style: GoogleFonts.poppins(
                                  color: Constants.bodyTextColor,
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        KText(
                          text: "Forgot Password?",
                          style: GoogleFonts.poppins(
                            color: const Color(0xff5890FF)
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height/75.6),
                PrimaryButton(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> OtpVerificationView(phone: phoneController.text,firstName: userNameController.text)));
                  },
                  title: "Login",
                ),
                SizedBox(height: height/50.4),
                Center(
                  child: KText(
                    text: "Or Continue with",
                    style: GoogleFonts.poppins(
                      color: Constants.bodyTextColor,
                    ),
                  ),
                ),
                SizedBox(height: height/50.4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SecondaryButton(
                      onTap: (){},
                      title: "Facebook",
                      icon: "assets/facebook.png",
                    ),
                    SecondaryButton(
                      onTap: (){},
                      title: "Google",
                      icon: "assets/google.png",
                    )
                  ],
                ),
                SizedBox(height: height/50.4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KText(
                      text: "don't have an account?",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Constants.bodyTextColor,
                      ),
                    ),
                    SizedBox(width: width/72),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const SignUpView()));
                      },
                      child: KText(
                        text: "Sign Up",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          color: Constants.primaryAppColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
