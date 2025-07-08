import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/auth_controller.dart';
import 'package:shopapp_v1/data/model/user.dart';
import 'package:shopapp_v1/helper/date_covert.dart';
import 'package:shopapp_v1/screen/sign_in/sign_in_screen.dart';
import 'package:shopapp_v1/utils/color_resource.dart';
import 'package:shopapp_v1/utils/images.dart';
import 'package:shopapp_v1/view/custom_button.dart';
import 'package:shopapp_v1/view/custom_snackbar.dart';
import 'package:shopapp_v1/view/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController dobCtrl = TextEditingController();
  TextEditingController addressCtl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  Rx<bool> obsureText = true.obs;
  Rx<bool> obsureTextConfirm = true.obs;
  FocusNode dobFocusNode = FocusNode();

  @override
  void dispose() {
    dobCtrl.dispose();
    dobFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child: GetBuilder<AuthController>(builder: (ctl) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                          onTap: () => obsureTextConfirm.value =
                              !obsureTextConfirm.value,
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
                CustomTextField(
                  labelText: "Address",
                  hintText: "Seul, Hà Nội",
                  controller: addressCtl,
                  prefixIcon: Icons.location_city,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    focusNode: dobFocusNode,
                    controller: dobCtrl,
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                      labelText: "Ngày sinh".tr,
                      prefixIcon: Icon(Icons.calendar_today),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search_outlined),
                        onPressed: () async {
                          dobFocusNode.requestFocus();
                          final DateTime? dateTime =
                              await showRoundedDatePicker(
                            context: context,
                            fontFamily: 'NotoSerif',
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2026),
                            locale: const Locale('en', 'US'),
                            borderRadius: 16,
                            height: 250,
                            imageHeader: const AssetImage(Images.bgCalendar),
                            styleDatePicker: MaterialRoundedDatePickerStyle(
                              decorationDateSelected: BoxDecoration(
                                color: Colors.green.withOpacity(0.6),
                                shape: BoxShape.circle,
                              ),
                              textStyleCurrentDayOnCalendar:
                                  TextStyle(color: Colors.blue),
                              textStyleDayButton: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                              textStyleYearButton: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                              textStyleButtonPositive: TextStyle(
                                color: Colors.green.withOpacity(0.9),
                              ),
                              textStyleButtonNegative: TextStyle(
                                color: Colors.green.withOpacity(0.9),
                              ),
                              textStyleDayHeader:
                                  const TextStyle(color: Colors.blue),
                            ),
                            initialDate: DateTime.now(),
                          );
                          if (dateTime != null) {
                            dobCtrl.text = DateCovert.dateTimeStringToDateOnly(
                                dateTime.toString());
                            dobFocusNode.unfocus();
                          }
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'please_enter_birth_day'.tr
                        : null,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  labelButton: "Sign up",
                  onTap: () {
                    ctl
                        .signUp(User(
                      phoneNumber: phoneNumberCtrl.text,
                      fullname: nameCtrl.text,
                      password: passwordCtrl.text,
                      retypePassword: passwordCtrl.text,
                      address: addressCtl.text,
                      dob: dobCtrl.text,
                      faceAccId: 0,
                      ggAccId: 0,
                      roleId: 1,
                      isActive: true,
                    ))
                        .then((response) {
                      if (response == 200 || response == 201) {
                        showCustomFlash("Đăng ký thành công".tr, Get.context!,
                            isError: false);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                        );
                      } else if (response == 400) {
                        showCustomFlash("Đăng ký thất bại".tr, Get.context!,
                            isError: true);
                        // ApiChecker.checkApi(response);
                      } else {
                        showCustomFlash("Hãy thử lại".tr, Get.context!,
                            isError: true);
                        // ApiChecker.checkApi(response);
                      }
                    });
                  },
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
                SizedBox(
                  height: 10,
                ),
              ],
            );
          })),
        ),
      ),
    );
  }
}
