import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../models/news_model.dart';
import 'news_detail_view.dart';

class NewsListView extends StatefulWidget {
  const NewsListView({super.key, required this.title});

  final String title;

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
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
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: Constants.secondaryAppColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('News').orderBy("timestamp", descending: true).snapshots(),
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
