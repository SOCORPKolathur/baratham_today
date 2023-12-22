import 'package:baratham_today/constants.dart';
import 'package:baratham_today/views/home_view.dart';
import 'package:baratham_today/views/otp_verification_view.dart';
import 'package:baratham_today/views/sign_up_view.dart';
import 'package:baratham_today/widgets/custom_text_form_filed.dart';
import 'package:baratham_today/widgets/primary_button.dart';
import 'package:baratham_today/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      "HELLO",
                      style: GoogleFonts.poppins(
                        color: Constants.secondaryAppColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 45,
                      ),
                    ),
                    Text(
                      "Again!",
                      style: GoogleFonts.poppins(
                        color: Constants.primaryAppColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 45,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Welcome back you've \n been missed",
                      style: GoogleFonts.poppins(
                        color: Constants.bodyTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
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
                SizedBox(height: 20),
                CustomTextFormField(
                  label: "Phone",
                  required: true,
                  passType: false,
                  controller: phoneController,
                  validator: (val){},
                  onSubmitted: (val){},
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
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
                            Text(
                              "Remember Me",
                              style: GoogleFonts.poppins(
                                  color: Constants.bodyTextColor,
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Text(
                          "Forgot Password?",
                          style: GoogleFonts.poppins(
                            color: const Color(0xff5890FF)
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                PrimaryButton(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> OtpVerificationView(phone: phoneController.text,firstName: userNameController.text)));
                  },
                  title: "Login",
                ),
                SizedBox(height: 15),
                Center(
                  child: Text(
                    "Or Continue with",
                    style: GoogleFonts.poppins(
                      color: Constants.bodyTextColor,
                    ),
                  ),
                ),
                SizedBox(height: 15),
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
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "don't have an account?",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Constants.bodyTextColor,
                      ),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const SignUpView()));
                      },
                      child: Text(
                        "Sign Up",
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
