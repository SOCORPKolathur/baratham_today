import 'package:baratham_today/models/comments_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import 'kText.dart';

class CommentTileWidget extends StatefulWidget {
  const CommentTileWidget({super.key, required this.comment,required this.onReply});

  final CommentModel comment;
  final Function onReply;

  @override
  State<CommentTileWidget> createState() => _CommentTileWidgetState();
}

class _CommentTileWidgetState extends State<CommentTileWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              widget.comment.userImg!,
            )
          ),
          SizedBox(width: width/72),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: widget.comment.userName!,
                  style: GoogleFonts.poppins(
                    fontSize: width/24,
                    fontWeight: FontWeight.w600,
                    color: Constants.secondaryAppColor,
                  ),
                ),
                SizedBox(height: height/151.2),
                KText(
                  text: widget.comment.message!,
                  style: GoogleFonts.poppins(
                    fontSize: width/25.71428571428571,
                    fontWeight: FontWeight.w400,
                    color: Constants.secondaryAppColor,
                  ),
                ),
                SizedBox(height: height/75.6),
                Row(
                  children: [
                    KText(
                      text: "4w",
                      style: GoogleFonts.poppins(
                        fontSize: width/24,
                        fontWeight: FontWeight.w400,
                        color: Constants.bodyTextColor,
                      ),
                    ),
                    SizedBox(width: width/36),
                    Icon(
                      Icons.favorite_border,
                      color: Constants.bodyTextColor,
                      size: width/24,
                    ),
                    KText(
                      text: " ${widget.comment.likes!.length} likes",
                      style: GoogleFonts.poppins(
                        fontSize: width/24,
                        fontWeight: FontWeight.w400,
                        color: Constants.bodyTextColor,
                      ),
                    ),
                    SizedBox(width: width/36),
                    InkWell(
                      onTap: (){
                        widget.onReply();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.reply_outlined,
                            color: Constants.bodyTextColor,
                            size: width/24,
                          ),
                          KText(
                            text: " reply",
                            style: GoogleFonts.poppins(
                              fontSize: width/24,
                              fontWeight: FontWeight.w400,
                              color: Constants.bodyTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height/75.6),
                Row(
                  children: [
                    Visibility(
                      visible: widget.comment.replies!.isNotEmpty,
                      child: KText(
                        text: "${widget.comment.replies!.length} replies",
                        style: GoogleFonts.poppins(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(width: width/36),
                    Visibility(
                      visible: (widget.comment.replies!.isNotEmpty && !widget.comment.viewComments!),
                      child: InkWell(
                        onTap: (){
                          setState((){
                            widget.comment.viewComments = true;
                          });
                        },
                        child: KText(
                          text: "View All",
                          style: GoogleFonts.poppins(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height/75.6),
                Visibility(
                  visible: widget.comment.viewComments!,
                  child: Container(
                    child: Column(
                      children: [
                        for(int j = 0; j < widget.comment.replies!.length; j++)
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      widget.comment.replies![j].userImg!,
                                    )
                                ),
                                SizedBox(width: width/72),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      KText(
                                        text: widget.comment.replies![j].userName!,
                                        style: GoogleFonts.poppins(
                                          fontSize: width/24,
                                          fontWeight: FontWeight.w600,
                                          color: Constants.secondaryAppColor,
                                        ),
                                      ),
                                      SizedBox(height: height/151.2),
                                      KText(
                                        text: widget.comment.replies![j].message!,
                                        style: GoogleFonts.poppins(
                                          fontSize: width/25.71428571428571,
                                          fontWeight: FontWeight.w400,
                                          color: Constants.secondaryAppColor,
                                        ),
                                      ),
                                      SizedBox(height: height/75.6),
                                      Row(
                                        children: [
                                          KText(
                                            text: "4w",
                                            style: GoogleFonts.poppins(
                                              fontSize: width/24,
                                              fontWeight: FontWeight.w400,
                                              color: Constants.bodyTextColor,
                                            ),
                                          ),
                                          SizedBox(width: width/36),
                                          Icon(
                                            Icons.favorite_border,
                                            color: Constants.bodyTextColor,
                                            size: width/24,
                                          ),
                                          KText(
                                            text: " ${widget.comment.replies![j].likes!.length} likes",
                                            style: GoogleFonts.poppins(
                                              fontSize: width/24,
                                              fontWeight: FontWeight.w400,
                                              color: Constants.bodyTextColor,
                                            ),
                                          ),
                                          SizedBox(width: width/36),
                                          // Icon(
                                          //   Icons.reply_outlined,
                                          //   color: Constants.bodyTextColor,
                                          //   size: width/24,
                                          // ),
                                          // KText(
                                          //   text: " reply",
                                          //   style: GoogleFonts.poppins(
                                          //     fontSize: width/24,
                                          //     fontWeight: FontWeight.w400,
                                          //     color: Constants.bodyTextColor,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                      ],
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
}
