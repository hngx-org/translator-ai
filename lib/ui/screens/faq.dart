import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator_ai/utils/colors.dart';
import 'package:translator_ai/utils/size_calculator.dart';

class FAQView extends StatelessWidget {
  const FAQView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title:Text(
          'FAQs',
          style: GoogleFonts.nunito(
            color: AppColors.primary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.0,
            letterSpacing: 0.24,
          ),
        ),
        backgroundColor: AppColors.whiteColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(
                  vertical: sizer(false, 10, context),
                ),
                child: ProductExpansionTile(
                  title: "How can I change the language settings in the app?",
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: sizer(true, 40, context),
                      ),
                      child: Text(
                          "To change the language settings in the app, navigate to the settings menu or profile section. Look for the language preferences option and select your desired language from the available options.",
                          style: GoogleFonts.nunito(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductExpansionTile extends StatefulWidget {
  final String title;
  final List<String> subs;
  final List<Widget>? children;
  final bool initiallyExpanded, hasBottomBorder;

  const ProductExpansionTile({
    super.key,
    required this.title,
    this.subs = const [],
    this.children,
    this.initiallyExpanded = false,
    this.hasBottomBorder = true,
  });

  @override
  State<ProductExpansionTile> createState() => _ProductExpansionTileState();
}

class _ProductExpansionTileState extends State<ProductExpansionTile> {
  bool expanded = false;
  @override
  void initState() {
    setState(() {
      expanded = widget.initiallyExpanded;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.subs.isEmpty && widget.children == null) {
      return const SizedBox();
    }
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: widget.hasBottomBorder
                ? BorderSide(color: AppColors.blackColor)
                : BorderSide.none),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: sizer(false, 10, context),
                horizontal: sizer(true, 20, context),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(widget.title,
                        style: GoogleFonts.nunito(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: sizer(false, 8, context),
                  ),
                  Icon(
                    expanded ? Icons.remove : Icons.add,
                    color: AppColors.blackColor,
                    size: (24),
                  ),
                ],
              ),
            ),
          ),
          if (expanded)
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: sizer(false, 16, context)),
              child: Column(
                children: widget.children ??
                    [
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.subs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: sizer(false, 10, context)),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: sizer(false, 6, context),
                                ),
                                Icon(
                                  Icons.circle,
                                  color: AppColors.blackColor,
                                  size: (10),
                                ),
                                SizedBox(
                                  height: sizer(false, 16, context),
                                ),
                                Expanded(
                                    child: Text(
                                  widget.subs[index],
                                  // style: AppTypography.text14,
                                )),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
              ),
            )
        ],
      ),
    );
  }
}
