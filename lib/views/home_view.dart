import 'package:baratham_today/constants.dart';
import 'package:baratham_today/models/news_model.dart';
import 'package:baratham_today/views/change_language_view.dart';
import 'package:baratham_today/views/news_detail_view.dart';
import 'package:baratham_today/views/news_list_view.dart';
import 'package:baratham_today/views/notifications_view.dart';
import 'package:baratham_today/widgets/filter_search_widget.dart';
import 'package:baratham_today/widgets/title_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/kText.dart';
import '../widgets/news_tile_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {

  TabController? tabController;
  TextEditingController searchController = TextEditingController();

  List<String> tabs = [
    'All',
    'Sports',
    'Politics',
    'Business',
    'Health',
    'Travel',
    'Science',
  ];

  @override
  void initState() {
    tabController = TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width/24, vertical: height/75.6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TitleWidget(),
                    Padding(
                      padding: EdgeInsets.only(right: width/72),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx)=> NotificationsView(userDocId: FirebaseAuth.instance.currentUser!.uid)));
                              },
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: height/16.8,
                                width: width/8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Constants.primaryWhite,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/noti_ico.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx)=> ChangeLanguageView()));
                            },
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: height/16.8,
                                width: width/8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Constants.primaryWhite,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.translate,
                                  )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height/37.8),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FilterSearchWidget(
                            controller: searchController,
                            onSubmitted: (val){

                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                text: "Trending",
                                style: GoogleFonts.poppins(
                                  fontSize: width/21.17647058823529,
                                  fontWeight: FontWeight.w800,
                                  color: Constants.secondaryAppColor,
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const NewsListView(title: "Trending")));
                                },
                                child: KText(
                                  text: "See All",
                                  style: GoogleFonts.poppins(
                                    fontSize: width/24,
                                    fontWeight: FontWeight.w500,
                                    color: Constants.bodyTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height/151.2),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('News').snapshots(),
                            builder: (context, snap) {
                              if(snap.hasData){
                                NewsModel news = NewsModel.fromJson(snap.data!.docs.first.data());
                                return InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> NewsDetailsView(news: news)));
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CarouselSlider(
                                        options: CarouselOptions(
                                          height: height/3.78,
                                          viewportFraction: 1,
                                          autoPlay: news.imgs!.isEmpty ? false : true,
                                        ),
                                        items: news.imgs!.map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: height/3.78,
                                                width: width,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                        image: CachedNetworkImageProvider(
                                                            i
                                                        )
                                                    )
                                                ),
                                              );
                                            },
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(height: height/151.2),
                                      KText(
                                        text: news.location!,
                                        style: GoogleFonts.poppins(
                                          fontSize: width/25.71428571428571,
                                          fontWeight: FontWeight.w400,
                                          color: Constants.bodyTextColor,
                                        ),
                                      ),
                                      SizedBox(height: height/151.2),
                                      SizedBox(
                                        height: height/25.2,
                                        width: width,
                                        child: KText(
                                          text: news.title!,
                                          style: GoogleFonts.poppins(
                                            fontSize: width/21.17647058823529,
                                            fontWeight: FontWeight.w400,
                                            color: Constants.secondaryAppColor,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: width/36,
                                                backgroundImage: NetworkImage(news.channelImg!),
                                              ),
                                              SizedBox(width: width/72),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  KText(
                                                    text: news.channelName!,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: width/30,
                                                      fontWeight: FontWeight.w600,
                                                      color: Constants.secondaryAppColor,
                                                    ),
                                                  ),
                                                  SizedBox(width: width/24),
                                                  Icon(Icons.access_time_filled,size:  width/24),
                                                  SizedBox(width: width/72),
                                                  KText(
                                                    text: "14m ago",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: width/36,
                                                      fontWeight: FontWeight.w500,
                                                      color: Constants.bodyTextColor,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Icon(Icons.more_horiz),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Container();
                            }
                          ),
                          SizedBox(height: height/30.24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                text: "Latest",
                                style: GoogleFonts.poppins(
                                  fontSize: width/21.17647058823529,
                                  fontWeight: FontWeight.w800,
                                  color: Constants.secondaryAppColor,
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const NewsListView(title: "Latest")));
                                },
                                child: KText(
                                  text: "See All",
                                  style: GoogleFonts.poppins(
                                    fontSize: width/24,
                                    fontWeight: FontWeight.w500,
                                    color: Constants.bodyTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height/75.6),
                          SizedBox(
                            height: height/15.12,
                            child: TabBar(
                              tabAlignment: TabAlignment.start,
                              isScrollable: true,
                              controller: tabController,
                              onTap: (index){},
                              unselectedLabelColor: Constants.bodyTextColor,
                              labelColor: Constants.primaryAppColor,
                              labelStyle: GoogleFonts.poppins(
                                fontSize: width/30,
                                fontWeight: FontWeight.w600,
                              ),
                              dividerHeight: 0,
                              tabs: tabs.map((e) => Tab(text: e)).toList(),
                            ),
                          ),
                          SizedBox(height: height/75.6),
                          SizedBox(
                            height: height * 0.56,
                            width: size.width,
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                buildAllNewsWidget(),
                                buildSportsNewsWidget(),
                                buildPoliticsNewsWidget(),
                                buildBusinessNewsWidget(),
                                buildHealthNewsWidget(),
                                buildTravelNewsWidget(),
                                buildScienceNewsWidget(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildAllNewsWidget(){
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('News').orderBy("timestamp", descending: true).snapshots(),
      builder: (context, snap) {
        if(snap.hasData){
          return ListView.builder(
            itemCount: snap.data!.docs.length,
            itemBuilder: (ctx, i){
              NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
              return Padding(
                padding: EdgeInsets.symmetric(vertical: height/94.5),
                child: NewsTileWidget(news: news),
              );
            },
          );
        }return Container();
      }
    );
  }

  buildSportsNewsWidget(){
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('News').where("category", isEqualTo: 'Sports').snapshots(),
        builder: (context, snap) {
          if(snap.hasData){
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (ctx, i){
                NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height/94.5),
                  child: NewsTileWidget(news: news),
                );
              },
            );
          }return Container();
        }
    );
  }

  buildPoliticsNewsWidget(){
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('News').where("category", isEqualTo: 'Politics').snapshots(),
        builder: (context, snap) {
          if(snap.hasData){
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (ctx, i){
                NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height/94.5),
                  child: NewsTileWidget(news: news),
                );
              },
            );
          }return Container();
        }
    );
  }

  buildBusinessNewsWidget(){
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('News').where("category", isEqualTo: 'Business').snapshots(),
        builder: (context, snap) {
          if(snap.hasData){
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (ctx, i){
                NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height/94.5),
                  child: NewsTileWidget(news: news),
                );
              },
            );
          }return Container();
        }
    );
  }

  buildHealthNewsWidget(){
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('News').where("category", isEqualTo: 'Health').snapshots(),
        builder: (context, snap) {
          if(snap.hasData){
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (ctx, i){
                NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height/94.5),
                  child: NewsTileWidget(news: news),
                );
              },
            );
          }return Container();
        }
    );
  }

  buildTravelNewsWidget(){
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('News').where("category", isEqualTo: 'Travel').snapshots(),
        builder: (context, snap) {
          if(snap.hasData){
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (ctx, i){
                NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height/94.5),
                  child: NewsTileWidget(news: news),
                );
              },
            );
          }return Container();
        }
    );
  }

  buildScienceNewsWidget(){
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('News').where("category", isEqualTo: 'Science').snapshots(),
        builder: (context, snap) {
          if(snap.hasData){
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (ctx, i){
                NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height/94.5),
                  child: NewsTileWidget(news: news),
                );
              },
            );
          }return Container();
        }
    );
  }


}
