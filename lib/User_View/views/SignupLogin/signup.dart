import 'package:HappyLink/Models/All_Doctors_Model.dart';
import 'package:HappyLink/Models/UserModels.dart';
import 'package:HappyLink/User_View/views/common/Flutter_toast.dart';
import 'package:HappyLink/controller/FireBase_controller/SignupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cnfPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  bool isDoctor = false;

  void handleSignup() async {
    if (passwordController.text != cnfPasswordController.text) {
      showToast("Passwords do not match");
      return;
    }

    User user = User(
      email: emailController.text,
      password: passwordController.text,
      userDetails: UserDetails(
        userId: userIdController.text,
        name: nameController.text,
        age: ageController.text,
        phoneno: phoneNoController.text,
      ),
    );

    SignUpControlller.instance.signUpAndCreateUserData(user);
  }

  void handledoctorSignup() async {
    if (passwordController.text != cnfPasswordController.text) {
      showToast("Passwords do not match");
      return;
    }

    Doctor users = Doctor(
      email: emailController.text,
      doctorDetails: DoctorDetails(
        userId: userIdController.text,
        name: nameController.text,
        age: ageController.text,
        phoneno: phoneNoController.text,
      ),
    );
    SignUpControlller.instance
        .signUpAndCreateDoctorData(users, passwordController.text);
  }

  // Other code remains unchanged

  final OutlineInputBorder _blackOutline = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  );

  final TextStyle _greyTextStyle = TextStyle(color: Colors.white);
  final TextStyle _blackTextStyle = TextStyle(color: Colors.white);

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => SignUpControlller());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cnfPasswordController.dispose();
    nameController.dispose();
    ageController.dispose();
    phoneNoController.dispose();
    userIdController.dispose();

    super.dispose();
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      height: 40,
      child: TextField(
        controller: controller,
        style: _blackTextStyle,
        decoration: InputDecoration(
          enabledBorder: _blackOutline,
          focusedBorder: _blackOutline,
          label: Text(label, style: _greyTextStyle),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 139, 140, 236),
            Colors.blue,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    _buildTextField("Name", nameController),
                    _buildTextField("userId", userIdController),
                    _buildTextField("Email", emailController),
                    Row(
                      children: [
                        Expanded(child: _buildTextField("Age", ageController)),
                        Expanded(
                            child:
                                _buildTextField("Phone No", phoneNoController)),
                      ],
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
                    _buildTextField("Password", passwordController),
                    _buildTextField("Confirm Password", cnfPasswordController),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.orange,
                      ),
                      child: TextButton(
                        onPressed: () =>
                            (isDoctor) ? handledoctorSignup() : handleSignup(),
                        child: Text("Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
