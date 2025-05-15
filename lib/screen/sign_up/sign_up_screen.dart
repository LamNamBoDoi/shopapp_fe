import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/screen/sign_in/sign_in_screen.dart';
import 'package:shopapp_v1/utils/color_resource.dart';
import 'package:shopapp_v1/utils/images.dart';
import 'package:shopapp_v1/view/custom_button.dart';
import 'package:shopapp_v1/view/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  Rx<bool> obsureText = true.obs;
  Rx<bool> obsureTextConfirm = true.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(Images.iconShop, width: 60, height: 60),
                  SizedBox(width: 5),
                  Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(children: [
                        TextSpan(
                          text: "Grocery ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Borel",
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "Store",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: ColorResources.getTextColor1(),
                              fontFamily: "Borel"),
                        ),
                      ]))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Let's Get Started",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Let's sign up to continue",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black45),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                labelText: "Name",
                hintText: "khai",
                controller: nameCtrl,
                prefixIcon: Icons.people,
              ),
              CustomTextField(
                labelText: "Phone number",
                hintText: "+84 123 456 789",
                controller: phoneNumberCtrl,
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone,
              ),
              Obx(
                () => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    controller: passwordCtrl,
                    obscureText: obsureText.value,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Password",
                      hintText: "●●●●●●",
                      suffixIcon: GestureDetector(
                        onTap: () => obsureText.value = !obsureText.value,
                        child: Icon(
                          obsureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    controller: confirmPasswordCtrl,
                    obscureText: obsureTextConfirm.value,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Confirm Password",
                      hintText: "●●●●●●",
                      suffixIcon: GestureDetector(
                        onTap: () =>
                            obsureTextConfirm.value = !obsureTextConfirm.value,
                        child: Icon(
                          obsureTextConfirm.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomButton(
                labelButton: "Sign up",
              ),
              SizedBox(
                height: 10,
              ),
              Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: "Login",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()),
                          );
                        },
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: ColorResources.getTextColor1(),
                      ),
                    ),
                  ])),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
