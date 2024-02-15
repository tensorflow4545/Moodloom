import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:HappyLink/User_View/views/SignupLogin/login.dart';
import 'package:HappyLink/User_View/views/SignupLogin/signup.dart';

class Spscreen extends StatefulWidget {
  const Spscreen({super.key});

  @override
  State<Spscreen> createState() => _SpscreenState();
}

class _SpscreenState extends State<Spscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2e8ff),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Lottie.asset("assets/PNGFiles/web-content-design.json",
              reverse: true, fit: BoxFit.cover),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(40),
            child: Text("We are here",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 40),
            child: Text(
                "Welcome to Ecsthetic, our app is here to support you on your journey towards better mental health and emotional balance.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                )),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => Login());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 147,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff343a48)),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => Signup()),
                  child: Container(
                      width: 147,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.2),
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0x0c000000)),
                      child: Text(
                        "SignUp",
                        style: TextStyle(color: Colors.black),
                      )),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
