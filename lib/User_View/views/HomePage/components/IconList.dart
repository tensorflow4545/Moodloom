import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:HappyLink/utils/Theme_services.dart';
import 'package:HappyLink/utils/colors.dart';
import 'package:HappyLink/utils/themes.dart';

class HorizontalIconList extends StatefulWidget {
  final Color? color;
  final String? asset;
  final String? label;
  final Function()? funct;
  HorizontalIconList(
      {super.key, this.color, this.asset, this.label, this.funct});

  @override
  State<HorizontalIconList> createState() => _HorizontalIconListState();
}

class _HorizontalIconListState extends State<HorizontalIconList> {
  final themeService = Get.find<ThemeService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            width: 69.5811538696289,
            height: 72.94798278808594,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.color,
            ),
            child: IconButton(
              iconSize: 100,
              onPressed: () {
                widget.funct?.call();
              },
              icon: SvgPicture.asset(widget.asset!),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.label!,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: CustomColors.textColor),
          )
        ],
      ),
    );
  }
}
