import 'package:baratham_today/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SearchWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? value;
  final String? Function(String?)? onSubmitted;

  SearchWidget(
      {super.key,
        this.value,
        required this.controller,
        required this.onSubmitted,
      });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  bool isObsecure = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Container(
      padding: EdgeInsets.only(right: width/24),
      height: size.height * 0.1,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onFieldSubmitted: widget.onSubmitted,
            controller: widget.controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: width/36, vertical: height/189),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(Icons.search,color: const Color(0xff757879)),
                onPressed: () {

                },
              ),
              hintText: "Search",
              hintStyle: GoogleFonts.poppins(
                color:  Color(0xffA7A1A1),
                fontSize: width/25.71428571428571,
              ),
            ),
          ),
        ],
      ),
    );
  }
}