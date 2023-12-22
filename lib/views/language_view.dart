import 'package:baratham_today/constants.dart';
import 'package:baratham_today/views/choose_topics_view.dart';
import 'package:baratham_today/widgets/search_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguagesView extends StatefulWidget {
  const LanguagesView({super.key, required this.phone, required this.userName});

  final userName;
  final phone;

  @override
  State<LanguagesView> createState() => _LanguagesViewState();
}

class _LanguagesViewState extends State<LanguagesView> {

  TextEditingController searchController = TextEditingController();
  int selectedIndex = 5000;

  List<ChooseLanguageModel> languagesList = [
    ChooseLanguageModel(
      name: "Tamil",
      orgName: "தமிழ்",
      code: "ta",
    ),
    ChooseLanguageModel(
      name: "English",
      orgName: "English",
      code: "en_US",
    ),
    ChooseLanguageModel(
      name: "Hindi",
      orgName: "हिंदी",
      code: "hi",
    ),
    ChooseLanguageModel(
      name: "Telugu",
      orgName: "తెలుగు",
      code: "te",
    ),
    ChooseLanguageModel(
      name: "Malayalam",
      orgName: "മലയാളം",
      code: "ml",
    ),
    ChooseLanguageModel(
      name: "Kannada",
      orgName: "ಕನ್ನಡ",
      code: "kn",
    ),
    ChooseLanguageModel(
      name: "Bengali",
      orgName: "বাংলা",
      code: "bn",
    ),
    ChooseLanguageModel(
      name: "Spanish",
      orgName: "Español",
      code: "es",
    ),
    ChooseLanguageModel(
      name: "Portuguese",
      orgName: "Português",
      code: "pt",
    ),
    ChooseLanguageModel(
      name: "French",
      orgName: "Français",
      code: "fr",
    ),
    ChooseLanguageModel(
      name: "Dutch",
      orgName: "Nederlands",
      code: "nl",
    ),
    ChooseLanguageModel(
      name: "German",
      orgName: "Deutsch",
      code: "de",
    ),
    ChooseLanguageModel(
      name: "Italian",
      orgName: "Italiano",
      code: "it",
    ),
    ChooseLanguageModel(
      name: "Swedish",
      orgName: "Svenska",
      code: "sv",
    )
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Select Your Language",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Constants.bodyTextColor,
          ),
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Column(
            children: [
              SearchWidget(
                  controller: searchController,
                  onSubmitted: (val){

                  },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: languagesList.length,
                  itemBuilder: (ctx, i){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            selectedIndex = i;
                          });
                          await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).set({
                            "name" : widget.userName,
                            "phone" : widget.phone,
                            "lanCode" : languagesList[i].code!,
                            "imgUrl" : "",
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const ChooseTopicsView()));
                        },
                        child: Container(
                          height: 40,
                          width: width,
                          decoration: BoxDecoration(
                            color: selectedIndex == i ? Colors.red : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              languagesList[i].name!,
                              style: GoogleFonts.poppins(
                                color: selectedIndex == i ? Constants.primaryWhite : Constants.bodyTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}


class ChooseLanguageModel {
  ChooseLanguageModel({this.name, this.code, this.orgName});

  String? name;
  String? orgName;
  String? code;
}