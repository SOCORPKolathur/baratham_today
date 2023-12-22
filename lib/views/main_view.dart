import 'package:baratham_today/views/bookmarks_view.dart';
import 'package:baratham_today/views/explore_view.dart';
import 'package:baratham_today/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../widgets/kText.dart';
import 'home_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int _selectedIndex = 0;

  List<Widget> pages = [
    HomeView(),
    ExploreView(),
    BookmarksView(),
    ProfileView(),
  ];

  int animatesetvalue = 0;

  PageController controller = PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: PageView.builder(
          controller: controller,
          itemCount: pages.length,
          itemBuilder: (ctx, i){
            return pages[i];
          },
          onPageChanged: (index){
            setState(() {
              _selectedIndex = index;
              animatesetvalue = index;
            });
          },
        ),
        bottomNavigationBar: Container(
          color: Constants.appBackgroundColor,
          child: Material(
            color: const Color(0xffFFFFFF),
            shadowColor: Colors.black38,
            elevation: 3,
            child: AnimatedContainer(
              height: height / 14.82,
              duration: const Duration(seconds: 1),
              decoration: const BoxDecoration(
                //color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(150, 60))
                // borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height / 94.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 0;
                              animatesetvalue = 0;
                            });
                            controller.animateToPage(0, curve: Curves.decelerate, duration: Duration(milliseconds: 300)); // for animated jump. Requires a curve and a duration
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/home_ico.png", height: height / 30.24,
                                width: width / 14.4,
                                color: animatesetvalue == 0
                                    ? Constants.primaryAppColor
                                    : Constants.bodyTextColor,
                                // color: animatesetvalue==0?Color(0xff00194A):
                                // Color(0xffA0A0A0)
                              ),
                              KText(
                                text: "Home",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: width / 30,
                                  color: animatesetvalue == 0
                                      ? Constants.primaryAppColor
                                      : Constants.bodyTextColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 1;
                              animatesetvalue = 1;
                            });
                            controller.animateToPage(1, curve: Curves.decelerate, duration: Duration(milliseconds: 300));
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              Image.asset("assets/explore_ico.png",
                                height: height / 30.24, width: width / 14.4,
                                color: animatesetvalue == 1
                                    ? Constants.primaryAppColor
                                    : Constants.bodyTextColor,
                              ),
                              KText(text: "Explore",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: width / 30,
                                    color: animatesetvalue == 1
                                        ? Constants.primaryAppColor
                                        : Constants.bodyTextColor,
                                  ))
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 2;
                              animatesetvalue = 2;
                            });
                            controller.animateToPage(2, curve: Curves.decelerate, duration: Duration(milliseconds: 300));
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              Image.asset("assets/bookmark_ico.png",
                                height: height / 30.24, width: width / 14.4,
                                color: animatesetvalue == 2
                                    ? Constants.primaryAppColor
                                    : Constants.bodyTextColor,
                              ),
                              KText(text: "Bookmark",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: width / 30,
                                    color: animatesetvalue == 2
                                        ? Constants.primaryAppColor
                                        : Constants.bodyTextColor,
                                  ))
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 3;
                              animatesetvalue = 3;
                            });
                            controller.animateToPage(3, curve: Curves.decelerate, duration: Duration(milliseconds: 300));
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              Image.asset("assets/profile_ico.png",
                                height: height / 30.24, width: width / 14.4,
                                color: animatesetvalue == 3
                                    ? Constants.primaryAppColor
                                    : Constants.bodyTextColor,
                              ),
                              KText(text: "Profile",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: width / 30,
                                    color: animatesetvalue == 3
                                        ? Constants.primaryAppColor
                                        : Constants.bodyTextColor,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }


}
