import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:HappyLink/BMICalculator/Screens/input_page.dart';
import 'package:HappyLink/User_View/views/BooksApi/GoogleBooks.dart';
import 'package:HappyLink/User_View/views/website/website.dart';
import 'package:HappyLink/controller/FireBase_controller/CurrentUserController.dart';

Drawer SideDrwaer(Color theme) {
  final controller = Get.find<CurrentUserController>();
  return Drawer(
    surfaceTintColor: Colors.white,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: ListView(
      children: [
        SizedBox(
          height: 30,
        ),
        ListTile(
          title: Text("${controller.userModel.value.userDetails?.name}"),
          subtitle: Text("${controller.userModel.value.email}"),
        ),
        Divider(
          thickness: 0.8,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => BookSearchPage());
              },
              child: Container(
                child: Column(
                  children: [
                    Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: theme,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.book_sharp,
                          color: Colors.white,
                        )),
                    Text("Books")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => InputPage());
              },
              child: Column(
                children: [
                  Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: theme,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.sports_gymnastics,
                        color: Colors.white,
                      )),
                  Text("BMI", style: TextStyle(fontSize: 16))
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: theme,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.medical_information,
                        color: Colors.white,
                      )),
                  Text("Medication", style: TextStyle(fontSize: 16))
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            padding: EdgeInsets.only(left: 15),
            child: Text("Explore", style: TextStyle(fontSize: 18))),
        Divider(
          thickness: 0.8,
        ),
        ListTile(
          onTap: () {
            Get.to(() => WebViewScreen(
                  url: "https://www.linkedin.com/in/satyam-rana-68938117b/",
                ));
          },
          leading: Icon(
            Icons.contact_support,
            size: 30,
            color: theme,
          ),
          title: Text("Contact US", style: TextStyle(fontSize: 16)),
        ),
        ListTile(
          onTap: () {
            Get.to(() => WebViewScreen(
                  url: "https://www.linkedin.com/in/aman-gangwar-8534b0246/",
                ));
          },
          leading: Icon(
            Icons.developer_mode,
            size: 30,
            color: theme,
          ),
          title: Text(
            "Developers",
            style: TextStyle(fontSize: 16),
          ),
        ),
        ListTile(
          onTap: () {
            Get.to(() => WebViewScreen(
                  url: "https://feynman034.netlify.app",
                ));
          },
          leading: Icon(
            Icons.web_asset,
            size: 30,
            color: theme,
          ),
          title: Text(
            "Website",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
    // backgroundColor: Colors.white.withOpacity(0.8),
    elevation: 0,
  );
}
