import 'package:flutter/material.dart';

Future<dynamic> alertDialog(BuildContext context, Function? logout) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Log Out'),
              ),
              ListTile(
                title: Text('Are you sure you want to logout??'),
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      logout!();
                    },
                    child: Text('confirm'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
