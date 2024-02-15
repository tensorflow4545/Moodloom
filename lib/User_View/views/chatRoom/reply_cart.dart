import 'package:flutter/material.dart';

class ReplyCart extends StatelessWidget {
  final String message;
  ReplyCart({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: Colors.white54,
          child: Stack(
            children: [
              Padding(
                  padding:
                      EdgeInsets.only(right: 10, left: 50, top: 10, bottom: 20),
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
              Positioned(
                bottom: 4,
                left: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
