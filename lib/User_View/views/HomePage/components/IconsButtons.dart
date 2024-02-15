import 'package:flutter/material.dart';

class IconTags extends StatefulWidget {
  final String? label;
  final double? width;
  final double? height;
  final IconData assets;
  final Function()? function;
  IconTags({
    super.key,
    this.label,
    required this.assets,
    this.height,
    this.width,
    this.function,
  });

  @override
  State<IconTags> createState() => _IconTagsState();
}

class _IconTagsState extends State<IconTags> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                widget.function?.call();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(80, 60),
                primary: Colors.lightBlue.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 4,
              ),
              child: Icon(
                widget.assets,
                color: Colors.white,
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.label ?? "",
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
