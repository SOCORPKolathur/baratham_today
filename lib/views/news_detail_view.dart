import 'package:baratham_today/models/comments_model.dart';
import 'package:baratham_today/models/news_model.dart';
import 'package:baratham_today/models/user_model.dart';
import 'package:baratham_today/widgets/comment_tile_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class NewsDetailsView extends StatefulWidget {
  const NewsDetailsView({super.key, required this.news});

  final NewsModel news;

  @override
  State<NewsDetailsView> createState() => _NewsDetailsViewState();
}

class _NewsDetailsViewState extends State<NewsDetailsView> with SingleTickerProviderStateMixin {

  int commentsCount = 0;

  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 300), vsync: this, value: 1.0);

  @override
  void initState() {
    getCommentCount();
    super.initState();
  }

  getCommentCount() async {
    var doc = await FirebaseFirestore.instance.collection('News').doc(widget.news.id).collection('Comments').get();
    setState(() {
      commentsCount = doc.docs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryWhite,
        centerTitle: true,
        title: const Text(
          "",
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              "assets/share_ico.png",
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder: (context, userSnap) {
          if(userSnap.hasData){
            UserModel user = UserModel.fromJson(userSnap.data!.data() as Map<String,dynamic>);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 00),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                      NetworkImage(widget.news.channelImg!),
                                    ),
                                    SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.news.channelName!,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Constants.secondaryAppColor,
                                          ),
                                        ),
                                        Text(
                                          "14m ago",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Constants.bodyTextColor,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff1877F2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Following",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Constants.primaryWhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 200.0,
                                viewportFraction: 1,
                                autoPlay: widget.news.imgs!.isEmpty ? false : true,
                              ),
                              items: widget.news.imgs!.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 200,
                                      width: width,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: CachedNetworkImageProvider(i),
                                          )),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.news.location!,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Constants.bodyTextColor,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.news.title!,
                              style: GoogleFonts.poppins(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: Constants.secondaryAppColor,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              widget.news.description!,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Constants.bodyTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    elevation: 2,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Constants.primaryWhite,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 10),
                              IconButton(
                                onPressed: () {
                                  setState(() {

                                  });
                                },
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                              Text(
                                "${widget.news.likes!.length} likes",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Constants.secondaryAppColor,
                                ),
                              ),
                              SizedBox(width: 10),
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    elevation: 3,
                                    backgroundColor: Constants.appBackgroundColor,
                                    useSafeArea: false,
                                    builder: (BuildContext context) {
                                      return bottomSheetWidget(user);
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.chat_outlined,
                                  color: Constants.secondaryAppColor,
                                  size: 30,
                                ),
                              ),
                              Text(
                                "${commentsCount}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Constants.secondaryAppColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              StreamBuilder(
                                stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Bookmarks').doc(widget.news.id).snapshots(),
                                builder: (ctx, bsnap){
                                  if(bsnap.hasData){
                                    bool isWishListed = bsnap.data!.exists;
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            updateBookmarkList(widget.news,isWishListed);
                                            _controller
                                                .reverse()
                                                .then((value) => _controller.forward());
                                          },
                                          child: Center(
                                            child: ScaleTransition(
                                              scale: Tween(begin: 0.2, end: 1.0).animate(
                                                  CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
                                              child: Icon(
                                                isWishListed ? Icons.bookmark : Icons.bookmark_border,
                                                color: Constants.secondaryAppColor,
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                      ],
                                    );
                                  }return Container();
                                },
                              ),
                              SizedBox(width: 10),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        }
      ),
    );
  }

  TextEditingController commentController = TextEditingController();

  bottomSheetWidget(UserModel user) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        color: Constants.appBackgroundColor,
        height: 1000,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 4,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Constants.secondaryAppColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('News')
                    .doc(widget.news.id)
                    .collection('Comments')
                    .orderBy("timestamp", descending: true)
                    .snapshots(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    return Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListView.builder(
                        itemCount: snap.data!.docs.length,
                        itemBuilder: (ctx, i) {
                          CommentModel comment =
                              CommentModel.fromJson(snap.data!.docs[i].data());
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CommentTileWidget(comment: comment));
                        },
                      ),
                    ),
                    );
                  }
                  return Container();
                }),
            Container(
              height: 60,
              width: width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          controller: commentController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            border: const OutlineInputBorder(),
                            hintText: "Type your comment",
                            hintStyle: GoogleFonts.poppins(
                              color: Color(0xffA7A1A1),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () async {
                        CommentModel commentModel = CommentModel(
                          timestamp: DateTime.now().millisecondsSinceEpoch,
                          time: DateFormat('hh:mm aa').format(DateTime.now()),
                          date: DateFormat("dd-MM-yyyy").format(DateTime.now()),
                          likes: [],
                          message: commentController.text,
                          replies: [],
                          userImg: user.imgUrl,
                          userName: user.name,
                          viewComments: false,
                        );
                        var json = commentModel.toJson();
                        await FirebaseFirestore.instance
                            .collection('News')
                            .doc(widget.news.id)
                            .collection('Comments')
                            .doc()
                            .set(json);
                        commentController.clear();
                      },
                      child: Container(
                        height: 50,
                        width: 55,
                        decoration: BoxDecoration(
                          color: Color(0xff1877F2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Image.asset("assets/send.png"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  updateBookmarkList(NewsModel news, bool isWishListed){
    setState(() {
      if(isWishListed){
        FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Bookmarks').doc(news.id).delete();
      }else{
        var json = news.toJson();
        FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Bookmarks').doc(news.id).set(
            json
        );
      }
    });
  }

}
