import 'package:baratham_today/views/verification_complete_view.dart';
import 'package:baratham_today/widgets/primary_button.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../widgets/kText.dart';
import '../widgets/search_widget.dart';

class ChooseTopicsView extends StatefulWidget {
  const ChooseTopicsView({super.key});

  @override
  State<ChooseTopicsView> createState() => _ChooseTopicsViewState();
}

class _ChooseTopicsViewState extends State<ChooseTopicsView> {

  TextEditingController searchController = TextEditingController();

  List<String> tags = [];
  List<String> options = [
    "National",
    "International",
    "Sport",
    "Lifestyle",
    "Business",
    "Health",
    "Fashion",
    "Technology",
    "Science",
    "Art",
    "Politics",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: KText(
          text: "Choose Your Topics",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Constants.bodyTextColor,
          ),
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Column(
            children: [
              SearchWidget(
                controller: searchController,
                onSubmitted: (val){

                },
              ),
              Expanded(
                child: Container(
                  child: ChipsChoice<String>.multiple(
                    value: tags,
                    onChanged: (val) => setState(() => tags = val),
                    choiceItems: C2Choice.listFrom<String, String>(
                      source: options,
                      value: (i, v) => v,
                      label: (i, v) => v,
                      tooltip: (i, v) => v,
                    ),
                    choiceCheckmark: true,
                    textDirection: TextDirection.rtl,
                    wrapped: true,
                    alignment: WrapAlignment.center,
                  ),
                ),
              ),
              PrimaryButton(
                  onTap: () async {
                    await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).update({
                      "topics" : tags,
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const VerificationComleteView()));
                  },
                  title: "Next",
              )
            ],
          ),
        ),
      ),
    );
  }
}



class CustomChip extends StatelessWidget {
  final String label;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final bool selected;
  final Function(bool selected) onSelect;

  const CustomChip({
    Key? key,
    required this.label,
    this.color,
    this.width,
    this.height,
    this.margin,
    this.selected = false,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      duration: const Duration(milliseconds: 300),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: selected
            ? (color ?? Colors.green)
            : theme.unselectedWidgetColor.withOpacity(.12),
        borderRadius: BorderRadius.all(Radius.circular(selected ? 25 : 10)),
        border: Border.all(
          color: selected
              ? (color ?? Colors.green)
              : theme.colorScheme.onSurface.withOpacity(.38),
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(selected ? 25 : 10)),
        onTap: () => onSelect(!selected),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // AnimatedCheckmark(
            //   active: selected,
            //   color: Colors.white,
            //   size: const Size.square(32),
            //   weight: 5,
            //   duration: const Duration(milliseconds: 400),
            // ),
            Positioned(
              left: 9,
              right: 9,
              bottom: 7,
              child: KText(
                text: label,
                maxLines: 1,
                style: TextStyle(
                  color: selected ? Colors.white : theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  final String title;
  final Widget child;

  const Content({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  ContentState createState() => ContentState();
}

class ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            // color: Colors.blueGrey[50],
            child: KText(
              text: widget.title,
              style: const TextStyle(
                // color: Colors.blueGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Flexible(fit: FlexFit.loose, child: widget.child),
        ],
      ),
    );
  }
}

void _about(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              'chips_choice',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.black87),
            ),
            subtitle: const Text('by davigmacode'),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Easy way to provide a single or multiple choice chips.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black54),
                  ),
                  Container(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
