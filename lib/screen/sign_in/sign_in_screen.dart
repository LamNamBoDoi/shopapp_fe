import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/auth_controller.dart';
import 'package:shopapp_v1/screen/dashboard/dashboard_screen.dart';
import 'package:shopapp_v1/screen/sign_up/sign_up_screen.dart';
import 'package:shopapp_v1/utils/color_resource.dart';
import 'package:shopapp_v1/utils/images.dart';
import 'package:shopapp_v1/view/custom_button.dart';
import 'package:shopapp_v1/view/custom_snackbar.dart';
import 'package:shopapp_v1/view/custom_textfield.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  Rx<bool> obsureText = true.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: Stack(
        children: [
          GetBuilder<AuthController>(builder: (ctl) {
            return Opacity(
              opacity: ctl.loading ? 0.3 : 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                    height: 30,
                  ),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Let's login to continue",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45),
                  ),
                  SizedBox(
                    height: 20,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: TextField(
                        controller: passwordCtrl,
                        obscureText: obsureText.value,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 13, horizontal: 20),
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
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      labelButton: "Login",
                      onTap: () {
                        ctl
                            .login(phoneNumberCtrl.text, passwordCtrl.text)
                            .then((value) {
                          if (value == 200) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardScreen()),
                            );
                          } else {
                            showCustomFlash("account_password_is_incorrect".tr,
                                Get.context!,
                                isError: true);
                          }
                        });
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()),
                              );
                            },
                          text: "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: ColorResources.getTextColor1(),
                          ),
                        ),
                      ]))
                ],
              ),
            );
          }),
        ],
      )),
    );
  }
}
