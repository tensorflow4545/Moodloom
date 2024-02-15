import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:HappyLink/BMICalculator/Components/Icon_Content.dart';
import 'package:HappyLink/User_View/views/common/app_bar.dart';
import 'package:HappyLink/controller/FireBase_controller/CurrentUserController.dart';
import 'package:HappyLink/controller/HomeController.dart';
import 'package:HappyLink/User_View/views/common/Alert_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:HappyLink/utils/Theme_services.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final themeService = Get.find<ThemeService>();

  final fireUserController = Get.find<CurrentUserController>();
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;

  @override
  void initState() {
    super.initState();
    // Load the API image URL when the widget is initialized
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeService.currentTheme.scafholdColor,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  backgroundColor: themeService.currentTheme.primaryColor,
                  radius: 60,
                  child: ClipOval(
                    child: _image != null
                        ? Image.file(
                            _image!,
                            fit: BoxFit.fill,
                            width: 100.0,
                            height: 100.0,
                          )
                        : Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 50,
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "${fireUserController.userModel.value.userDetails?.name}",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Personal Details",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        child: Text(
                          "Edit",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              detailsTag(
                  "Name",
                  "${fireUserController.userModel.value.userDetails?.name}",
                  Icons.person),
              detailsTag("Email", "${fireUserController.userModel.value.email}",
                  Icons.email),
              detailsTag(
                  "Contact",
                  "+91 ${fireUserController.userModel.value.userDetails?.phoneno}",
                  Icons.phone),
              detailsTag(
                  "Address",
                  "44/6 RCF, Row Houses,\n Sector-12,Vashi,Navi \n Mumbai 400703",
                  Icons.location_city),
              SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Support",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.brown.withOpacity(0.4),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              detailsTag("Language", "English", Icons.language),
              detailsTag("FAQ's", ".....", Icons.question_answer),
              detailsTag("Troubleshoot", "......", Icons.phone),
              SizedBox(
                height: 20,
              ),
              InkWell(
                radius: 20,
                onTap: () => alertDialog(context, fireUserController.logout),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 70,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeService.currentTheme.primaryColor),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container detailsTag(String name, String details, IconData icons) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icons,
                size: 17,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Flexible(
            child: Container(
              child: Text(
                details,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
