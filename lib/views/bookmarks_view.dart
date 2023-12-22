import 'package:baratham_today/widgets/filter_search_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../models/news_model.dart';
import '../widgets/news_tile_widget.dart';
import 'news_detail_view.dart';

class BookmarksView extends StatefulWidget {
  const BookmarksView({super.key});

  @override
  State<BookmarksView> createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<BookmarksView> {

  TextEditingController searchController = TextEditingController();

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
          "Bookmark",
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
            FilterSearchWidget(
              controller: searchController,
              onSubmitted: (val){

              },
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Bookmarks').orderBy("timestamp", descending: true).snapshots(),
                  builder: (context, snap) {
                    if(snap.hasData){
                      return ListView.builder(
                          itemCount: snap.data!.docs.length,
                          itemBuilder: (context, i) {
                            NewsModel news = NewsModel.fromJson(snap.data!.docs[i].data());
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: NewsTileWidget(news: news),
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
