import 'package:baratham_today/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../widgets/search_widget.dart';
import 'language_view.dart';

class ChangeLanguageView extends StatefulWidget {
  const ChangeLanguageView({super.key});

  @override
  State<ChangeLanguageView> createState() => _ChangeLanguageViewState();
}

class _ChangeLanguageViewState extends State<ChangeLanguageView> {

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
            fontSize: width/20,
            fontWeight: FontWeight.w700,
            color: Constants.bodyTextColor,
          ),
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/24,vertical: height/75.6),
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
                          await Future.delayed(const Duration(microseconds: 200));
                          updateLanguage(languagesList[i].code!);
                        },
                        child: Container(
                          height: height/18.9,
                          width: width,
                          decoration: BoxDecoration(
                            color: selectedIndex == i ? Colors.red : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width/45, vertical: height/94.5),
                            child: Text(
                              languagesList[i].orgName!,
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

  updateLanguage(String lanCode){
    changeLocale(context, lanCode);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const MainView()));
  }


}
