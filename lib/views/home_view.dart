import 'package:baratham_today/constants.dart';
import 'package:baratham_today/models/news_model.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TitleWidget(),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> NotificationsView(userDocId: FirebaseAuth.instance.currentUser!.uid)));
                        },
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 45,
                            width: 45,
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
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
                              Text(
                                "Trending",
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: Constants.secondaryAppColor,
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const NewsListView(title: "Trending")));
                                },
                                child: Text(
                                  "See All",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Constants.bodyTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
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
                                          height: 200.0,
                                          viewportFraction: 1,
                                          autoPlay: news.imgs!.isEmpty ? false : true,
                                        ),
                                        items: news.imgs!.map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: 200,
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
                                      SizedBox(height: 5),
                                      Text(
                                        news.location!,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Constants.bodyTextColor,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      SizedBox(
                                        height: 30,
                                        width: width,
                                        child: Text(
                                          news.title!,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 17,
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
                                                radius: 10,
                                                backgroundImage: NetworkImage(news.channelImg!),
                                              ),
                                              SizedBox(width: 5),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    news.channelName!,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: Constants.secondaryAppColor,
                                                    ),
                                                  ),
                                                  SizedBox(width: 15),
                                                  Icon(Icons.access_time_filled,size: 15,),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "14m ago",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 10,
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
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Latest",
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: Constants.secondaryAppColor,
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const NewsListView(title: "Latest")));
                                },
                                child: Text(
                                  "See All",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Constants.bodyTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            child: TabBar(
                              tabAlignment: TabAlignment.start,
                              isScrollable: true,
                              controller: tabController,
                              onTap: (index){},
                              unselectedLabelColor: Constants.bodyTextColor,
                              labelColor: Constants.primaryAppColor,
                              labelStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              dividerHeight: 0,
                              tabs: tabs.map((e) => Tab(text: e)).toList(),
                            ),
                          ),
                          SizedBox(height: 10),
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
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('News').orderBy("timestamp", descending: true).snapshots(),
      builder: (context, snap) {
        if(snap.hasData){
          return ListView.builder(
            itemCount: snap.data!.docs.length,
            itemBuilder: (ctx, i){
              NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: NewsTileWidget(news: news),
              );
            },
          );
        }return Container();
      }
    );
  }

  buildSportsNewsWidget(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('News').where("category", isEqualTo: 'Sports').snapshots(),
        builder: (context, snap) {
          if(snap.hasData){
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (ctx, i){
                NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: NewsTileWidget(news: news),
                );
              },
            );
          }return Container();
        }
    );
  }

  buildPoliticsNewsWidget(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('News').where("category", isEqualTo: 'Politics').snapshots(),
        builder: (context, snap) {
          if(snap.hasData){
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (ctx, i){
                NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: NewsTileWidget(news: news),
                );
              },
            );
          }return Container();
        }
    );
  }

  buildBusinessNewsWidget(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('News').where("category", isEqualTo: 'Business').snapshots(),
        builder: (context, snap) {
          if(snap.hasData){
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (ctx, i){
                NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: NewsTileWidget(news: news),
                );
              },
            );
          }return Container();
        }
    );
  }

  buildHealthNewsWidget(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('News').where("category", isEqualTo: 'Health').snapshots(),
        builder: (context, snap) {
          if(snap.hasData){
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (ctx, i){
                NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: NewsTileWidget(news: news),
                );
              },
            );
          }return Container();
        }
    );
  }

  buildTravelNewsWidget(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('News').where("category", isEqualTo: 'Travel').snapshots(),
        builder: (context, snap) {
          if(snap.hasData){
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (ctx, i){
                NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: NewsTileWidget(news: news),
                );
              },
            );
          }return Container();
        }
    );
  }

  buildScienceNewsWidget(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('News').where("category", isEqualTo: 'Science').snapshots(),
        builder: (context, snap) {
          if(snap.hasData){
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (ctx, i){
                NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: NewsTileWidget(news: news),
                );
              },
            );
          }return Container();
        }
    );
  }


}
