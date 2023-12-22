import 'package:baratham_today/views/language_view.dart';
import 'package:baratham_today/widgets/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../constants.dart';
import '../widgets/kText.dart';

class OtpVerificationView extends StatefulWidget {

  OtpVerificationView({Key? key, required this.phone, required this.firstName});

  final String phone;
  final String firstName;

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {

  int counter = 60;
  TextEditingController otp = TextEditingController();
  bool isLoading = false;


  void initState() {
    super.initState();
    _verifyphone();
  }

  var _verificationCode;

  _verifyphone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verificationid, int? resendtoken) {
          setState(() {
            _verificationCode = verificationid;
          });
        },
        codeAutoRetrievalTimeout: (String verificationid) {
          setState(() {
            _verificationCode = verificationid;
          });
        },
        timeout: Duration(seconds: 120));
  }



  bool ison = false;
  String userId = "";
  var first;

  startTimer() async {
    while(counter > 0){
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Constants.primaryWhite, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Constants.primaryWhite,
        border: Border.all(
          color: Constants.bodyTextColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: Constants.primaryAppColor,
      border: Border.all(color: Constants.primaryWhite,),
      borderRadius: BorderRadius.circular(10),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: TextStyle(fontSize: 20, color: Constants.primaryAppColor, fontWeight: FontWeight.w600),
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: Constants.bodyTextColor),
        borderRadius: BorderRadius.circular(10),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              color: Colors.white70,
            ),
            SizedBox(
              height: size.height,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: size.height * 0.05),
                      Column(
                        children: [
                          SizedBox(height: size.height * 0.07),
                          KText(
                            text: "OTP Verification",
                            style: GoogleFonts.poppins(
                              fontSize: size.width/11.416666667,
                              color: Constants.bodyTextColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: size.height/173.2),
                          KText(
                            text: "Enter the OTP sent to ${widget.phone}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Constants.bodyTextColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: size.height * 0.05),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Pinput(
                              controller: otp,
                              length: 6,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              keyboardType: TextInputType.number,
                              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                              showCursor: true,
                              onCompleted: (pin) => print(pin),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                KText(
                                  text: "Resend code in ",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Constants.bodyTextColor,
                                  ),
                                ),
                                Text(
                                  "${counter}s",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Constants.primaryAppColor,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.46),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: size.height/43.3),
                          PrimaryButton(
                            onTap: (){

                              setState(() {
                                isLoading = true;
                              });
                              try {
                                FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
                                  verificationId: _verificationCode,
                                  smsCode: otp.text,
                                )).then((value) async {
                                  if (value.user != null) {
                                    String? fcmToken = await FirebaseMessaging.instance.getToken();
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> LanguagesView(phone: widget.phone,userName: widget.firstName)));
                                  }
                                });
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            },
                            title: "Verify OTP",
                          )
                        ],
                      ),
                      SizedBox(height: size.height/173.2)
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                alignment: AlignmentDirectional.center,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                ),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  width: size.width/1.37,
                  height: size.height/4.33,
                  alignment: AlignmentDirectional.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                          height: size.height/17.32,
                          width: size.height/17.32,
                          child: CircularProgressIndicator(
                            color: Constants.primaryAppColor,
                            value: null,
                            strokeWidth: 7.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 25.0),
                        child: Center(
                          child: KText(
                            text: "loading..Please wait...",
                            style: TextStyle(
                              color: Constants.primaryAppColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Constants.primaryAppColor, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: Offset(2, 4),
            )
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.info_outline, color: Constants.primaryAppColor),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: KText(
                text: "Invalid credentials",
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
            ),
          ],
        ),
    ),
  );

}
