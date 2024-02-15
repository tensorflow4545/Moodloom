import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Banners extends StatelessWidget {
  final Color? bgcolor;
  final String? joinTag;
  final String? asset;
  final String? heading;
  final String? time;
  final Function()? funct;
  Banners(
      {super.key,
      this.bgcolor,
      this.joinTag,
      this.asset,
      this.heading,
      this.time,
      this.funct});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 155,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bgcolor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading!,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        funct?.call();
                      },
                      child: Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              joinTag!,
                              style:
                                  TextStyle(color: Colors.pink, fontSize: 16),
                            ),
                            Icon(
                              Icons.play_circle,
                              color: Colors.pink,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SvgPicture.asset(asset!)
            ],
          ),
        ],
      ),
    );
  }
}
