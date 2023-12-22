import 'package:baratham_today/constants.dart';
import 'package:baratham_today/views/home_view.dart';
import 'package:baratham_today/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/intro_widget.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {

  final PageController  _pageController = PageController();
  int _activePage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'color': '#ffe24e',
      'title': 'Get More News with fraction of seconds',
      'image': 'assets/intro-1.png',
      'description': "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      'skip': true
    },
    {
      'color': '#a3e4f1',
      'title': 'Baratham Today will help to develop all news',
      'image': 'assets/intro-2.png',
      'description': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'skip': true
    },
    {
      'color': '#31b77a',
      'title': 'Lorum Ipsum is simply \ndummy',
      'image': 'assets/intro-3.png',
      'description': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'skip': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (int page) {
                setState(() {
                  _activePage = page;
                });
              },
              itemBuilder: (BuildContext context, int index){
                return IntroWidget(
                  color: _pages[index]['color'],
                  title: _pages[index]['title'],
                  description: _pages[index]['description'],
                  image: _pages[index]['image'],
                  skip: _pages[index]['skip'],
                  onTab: onNextPage,
                  index: _activePage,
                );
              }
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicator(),
                ),
                InkWell(
                  onTap: onNextPage,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Constants.primaryAppColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Text(
                          _activePage == 2 ? "Get Started" : "Next",
                          style: GoogleFonts.poppins(
                            color: Constants.primaryWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildIndicator() {
    final indicators =  <Widget>[];

    for (var i = 0; i < _pages.length; i++) {

      if (_activePage == i) {
        indicators.add(_indicatorsTrue());
      } else {
        indicators.add(_indicatorsFalse());
      }
    }
    return  indicators;
  }

  Widget _indicatorsTrue() {
    final String color;
    if (_activePage == 0) {
      color = '#ffe24e';
    } else if(_activePage ==  1) {
      color = '#a3e4f1';
    } else {
      color = '#31b77a';
    }

    //Active Indicator
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: 10,
      width: 10,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Constants.primaryAppColor,
      ),
    );
  }

  Widget _indicatorsFalse() {
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: 9,
      width: 9,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Constants.lightGrey,
      ),
    );
  }

  void onNextPage(){
    if(_activePage  < _pages.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear,);
    }else if(_activePage  == _pages.length - 1){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const LoginView()));
    }
  }

}
