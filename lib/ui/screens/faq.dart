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
        title: Text(
          "FAQs",
          style: GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.bold),
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
                  title: " Is it on-premise, proxy or cloud-based",
                  children: [
                    Text(
                        "On-premise systems require businesses to purchase equipment or to work with an outsourced provider. They have IT architectures that need routine maintenance. They may use a lot of electricity, which can add to the expense of maintenance as well. On-premise systems can require expensive service contracts, so make sure to consider that expense when making your decision.",
                        style: GoogleFonts.nunito(
                            fontSize: 14, fontWeight: FontWeight.w400))
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
                vertical: sizer(false, 20, context),
                horizontal: sizer(true, 30, context),
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
