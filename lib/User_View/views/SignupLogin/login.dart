import 'package:HappyLink/User_View/views/SignupLogin/signup.dart';
import 'package:HappyLink/controller/FireBase_controller/LoginController.dart';
import 'package:HappyLink/controller/LoginSignup_controller.dart';
import 'package:HappyLink/repository/FireBase_Repo/testRepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isDoctor = false;
  final loginRepo = Get.put(SignupLoginController());
  final control = TestRepo();

  void handleLogin() async {
    LoginControllerFireBase.instance
        .createUser(emailController.text, passwordController.text);

    // var data = {
    //   "email": emailController.text,
    //   "password": passwordController.text,
    //   "userType": isDoctor ? 'doctor' : 'user',
    // };

    // await loginRepo.postLogin(data);

    // if (loginRepo.status == Status.LOADING) {
    //   // You can show a loading indicator here if needed.
    //   return;
    // }

    // if (loginRepo.status == Status.COMPLETED) {
    // Get.defaultDialog(
    //   title: "Login Successful",
    //   middleText: "Logged in Successfully",
    //   onConfirm: () {
    //     if (isDoctor) {
    //       storeBoolCredentials('userType', true);
    //       Get.offAll(() => DoctorNavigationPage());
    //     } else {
    //       storeBoolCredentials('userType', false);
    //       Get.offAll(() => NavigationPage());
    //     }
    //   },
    //   content: Container(
    //     height: 200,
    //     width: 400,
    //     child: Lottie.asset("assets/PNGFiles/Login_done.json"),
    //   ),
    // );
    // } else {
    //   showToast("Login failed");
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(LoginControllerFireBase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                    color: Colors.orange,
                  ),
                ),
              ),
              Container(
                height: 200,
                child: Lottie.asset(
                  "assets/PNGFiles/Login_page.json",
                ),
              ),
              TextField(
                controller: emailController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.grey,
                    size: 20,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.grey,
                    size: 20,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isDoctor,
                    onChanged: (value) {
                      setState(() {
                        isDoctor = value ?? false;
                      });
                    },
                  ),
                  Text("Doctor"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.orange,
                ),
                child: TextButton(
                  onPressed: handleLogin,
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?"),
            TextButton(
              onPressed: () {
                Get.to(() => Signup());
              },
              child: Text(
                "SIGNUP",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
