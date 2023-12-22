import 'package:baratham_today/models/news_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../views/news_detail_view.dart';
import 'kText.dart';

class NewsTileWidget extends StatefulWidget {
  const NewsTileWidget({super.key, required this.news});

  final NewsModel news;

  @override
  State<NewsTileWidget> createState() => _NewsTileWidgetState();
}

class _NewsTileWidgetState extends State<NewsTileWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (ctx)=> NewsDetailsView(news: widget.news)));
      },
      child: SizedBox(
        height: height/7.56,
        width: width,
        child: Row(
          children: [
            Container(
              height: height/7.56,
              width: width/3.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(
                          widget.news.imgs!.first,
                      )
                  )
              ),
            ),
            SizedBox(width: width/72),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: widget.news.location!,
                    style: GoogleFonts.poppins(
                      fontSize: width/25.71428571428571,
                      fontWeight: FontWeight.w400,
                      color: Constants.bodyTextColor,
                    ),
                  ),
                  SizedBox(height: height/151.2),
                  SizedBox(
                    height: height/15.12,
                    width: width,
                    child: KText(
                      text: widget.news.title!,
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
                            backgroundImage: NetworkImage(widget.news.channelImg!),
                          ),
                          SizedBox(width: width/72),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              KText(
                                text: widget.news.channelName!,
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
            )
          ],
        ),
      ),
    );
  }
}
