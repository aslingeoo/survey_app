import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_app_acs/dao/userDao.dart';
import 'package:survey_app_acs/modal/user.dart';
import 'package:uuid/uuid.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  String lang = "";
  void initState() {
    if (Get.arguments == "English") {
      lang = "en";
    } else {
      lang = "jp";
    }
  }

  bool isEmailValid(String email) {
    // Define a regular expression for basic email validation
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    // Check if the provided email matches the regular expression
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Replace with your authentication logic
                        String email = emailController.text.trim();
                        // Add your authentication logic here
                        print('Login with email: $email');
                        bool isValid = isEmailValid(email);
                        if (isValid) {
                          var userList = await UsersDao.instance.getAll();
                          var selectedData = userList
                              .where((ele) => ele.email == email)
                              .toList();
                          user userData;
                          if (selectedData.isNotEmpty) {
                            userData = user(
                                uid: selectedData[0].uid,
                                email: email,
                                loginTime: DateTime.now().toString(),
                                lang: lang);
                          } else {
                            userData = user(
                                uid: Uuid().v1(),
                                email: email,
                                loginTime: DateTime.now().toString(),
                                lang: lang);
                          }
                          UsersDao.instance
                              .insertOrUpdate(userData.uid!, userData);
                          Get.toNamed("/survey");
                        } else {
                          Get.snackbar(
                            "",
                            "Please Enter Valid Email",
                            snackPosition: SnackPosition.BOTTOM,
                            borderWidth: 0.5,
                            animationDuration:
                                const Duration(milliseconds: 350),
                            duration: Duration(seconds: 3),
                            margin: const EdgeInsets.fromLTRB(16, 0, 16, 92),
                            isDismissible: true,
                          );
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
