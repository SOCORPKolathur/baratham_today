import 'package:baratham_today/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'kText.dart';


class CustomTextFormField extends StatefulWidget {
  final IconData? icon;
  final String label;
  final TextEditingController? controller;
  bool passType;
  bool required;
  final String? value;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSubmitted;

  CustomTextFormField(
      {super.key,
        this.icon,
        required this.label,
        this.value,
        required this.passType,
        required this.required,
        required this.controller,
        required this.validator,
        required this.onSubmitted,
      });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  bool isObsecure = false;
  @override
  void initState() {
    if (widget.value != null) {
      widget.controller!.text = widget.value ?? '';
    }
    if(widget.passType){
      isObsecure = true;
    }
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
          Row(
            children: [
              KText(
                text: widget.label,
                style: GoogleFonts.poppins(
                  color: const Color(0xff4E4B66),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Visibility(
                visible: widget.required,
                child: Text(
                  "*",
                  style: TextStyle(
                    color: Color(0xffC30052)
                  ),
                ),
              ),
            ],
          ),
          TextFormField(
            onFieldSubmitted: widget.onSubmitted,
            controller: widget.controller,
            validator: widget.validator,
            obscureText: isObsecure,
            enableSuggestions: !widget.passType,
            autocorrect: !widget.passType,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: width/36, vertical: height/189),
              border: const OutlineInputBorder(),
              suffixIcon:widget.passType ? IconButton(
                icon: Icon(isObsecure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,color: const Color(0xff757879)),
                onPressed: () {
                  setState(() {
                    isObsecure = !isObsecure;
                  },
                  );
                },
              ) : null,
              hintText: "",
              hintStyle: GoogleFonts.poppins(
                color:  const Color(0xffA7A1A1),
                fontSize: width/25.71428571428571,
              ),
            ),
          ),
        ],
      ),
    );
  }
}