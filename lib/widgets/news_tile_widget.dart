import 'package:baratham_today/models/news_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../views/news_detail_view.dart';

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
        height: 100,
        width: width,
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
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
            SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.news.location!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Constants.bodyTextColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    width: width,
                    child: Text(
                      widget.news.title!,
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
                            backgroundImage: NetworkImage(widget.news.channelImg!),
                          ),
                          SizedBox(width: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.news.channelName!,
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
            )
          ],
        ),
      ),
    );
  }
}
