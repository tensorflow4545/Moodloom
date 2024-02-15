import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:HappyLink/BMICalculator/Components/Icon_Content.dart';
import 'package:HappyLink/User_View/views/Counsellor/Counselors_profile.dart';
import 'package:HappyLink/User_View/views/common/Simmer_effect.dart';
import 'package:HappyLink/controller/FireBase_controller/AllComment.dart';
import 'package:HappyLink/controller/FireBase_controller/Counselors_controller.dart';
import 'package:HappyLink/data/status.dart';
import 'package:HappyLink/utils/Theme_services.dart';

class Counsellor extends StatefulWidget {
  const Counsellor({super.key});

  @override
  State<Counsellor> createState() => _CounsellorState();
}

class _CounsellorState extends State<Counsellor> {
  final themeService = Get.find<ThemeService>();
  final allcounselors = Get.put(AllCounselorController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allcounselors.postAllusers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counselors"),
      ),
      body: Obx(() {
        switch (allcounselors.status.value) {
          case Status.LOADING:
            return ThoughtSimmer();
          case Status.ERROR:
            Get.snackbar("Error", "Failed to load data");
            return Center(child: Text("Failed to load data"));
          case Status.COMPLETED:
            return ListView.builder(
              itemCount: allcounselors.counselors.length,
              itemBuilder: (context, index) {
                return CounsellorTag(
                    allcounselors.counselors[index].name!,
                    allcounselors.counselors[index].email!,
                    allcounselors.counselors[index].imageUrl!,
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CounselorProfile(
                                  id: allcounselors.counselors[index].id!,
                                  name: allcounselors.counselors[index].name!,
                                  email: allcounselors.counselors[index].email!,
                                  imageUrl:
                                      allcounselors.counselors[index].imageUrl!,
                                  cabin: allcounselors.counselors[index].cabin!,
                                  position:
                                      allcounselors.counselors[index].position!,
                                  language:
                                      allcounselors.counselors[index].language!,
                                ))));
              },
            );
        }
      }),
    );
  }

  Widget CounsellorTag(
      String name, String designation, String imageUrl, Function() funct) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: themeService.currentTheme.scafholdColor),
      child: InkWell(
          onTap: () => funct(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: imageProvider),
                    ),
                  );
                },
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        designation,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => funct(),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            "view",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            "Book",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          )),
    );
  }
}
