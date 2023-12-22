import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../models/news_model.dart';
import '../widgets/kText.dart';
import 'news_detail_view.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        leadingWidth: 0,
        backgroundColor: Constants.appBackgroundColor,
        title: KText(
          text: "Explore",
          style: GoogleFonts.poppins(
            fontSize: width/14.4,
            fontWeight: FontWeight.w800,
            color: Constants.secondaryAppColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width/24, vertical: height/75.6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KText(
                  text: "Topic",
                  style: GoogleFonts.poppins(
                    fontSize: width/21.17647058823529,
                    fontWeight: FontWeight.w700,
                    color: Constants.secondaryAppColor,
                  ),
                ),
                KText(
                  text: "See All",
                  style: GoogleFonts.poppins(
                    fontSize: width/24,
                    fontWeight: FontWeight.w500,
                    color: Constants.bodyTextColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: height/75.6),
            KText(
              text: "Popular Topics",
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Constants.secondaryAppColor,
              ),
            ),
            SizedBox(height: height/75.6),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('News').snapshots(),
                  builder: (context, snap) {
                    if(snap.hasData){
                      return ListView.builder(
                        itemCount: snap.data!.docs.length,
                        itemBuilder: (context, i) {
                          NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx)=> NewsDetailsView(news: news)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
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
                                              Icon(Icons.access_time_filled,size: width/24),
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
                            ),
                          );
                        }
                      );
                    }
                    return Container();
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
