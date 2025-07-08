import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shopapp_v1/controller/user_controller.dart';
import 'package:shopapp_v1/data/model/user.dart';
import 'package:shopapp_v1/utils/app_constants.dart';
import 'package:shopapp_v1/view/custom_snackbar.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final UserController userCtl = Get.find<UserController>();
  final User user = Get.find<UserController>().userCurrent;

  final fullnameCtl = TextEditingController();
  final phoneCtl = TextEditingController();
  final addressCtl = TextEditingController();
  final dobCtl = TextEditingController();

  File? thumbnail;

  @override
  void initState() {
    super.initState();
    fullnameCtl.text = user.fullname ?? "";
    phoneCtl.text = user.phoneNumber ?? "";
    addressCtl.text = user.address ?? "";
    try {
      dobCtl.text = user.dob != null && user.dob!.isNotEmpty
          ? DateFormat('dd/MM/yyyy').format(DateTime.parse(user.dob!))
          : "";
    } catch (e) {
      dobCtl.text = "";
    }
  }

  void changeThumbnail() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        thumbnail = File(picked.path);
      });
    }
  }

  @override
  void dispose() {
    fullnameCtl.dispose();
    phoneCtl.dispose();
    addressCtl.dispose();
    dobCtl.dispose();
    super.dispose();
  }

  void saveInfo() {
    user.fullname = fullnameCtl.text;
    user.phoneNumber = phoneCtl.text;
    user.address = addressCtl.text;
    user.dob = dobCtl.text;
    userCtl.updateUserInfo(user, thumbnail).then((value) {
      if (value == 200) {
        showCustomFlash("Cập nhật thông tin thành công", context,
            isError: false);
      } else {
        showCustomFlash("Cập nhật thông tin thất bại", context, isError: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: saveInfo,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.blue.withOpacity(0.2),
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[400],
                      backgroundImage: thumbnail != null && thumbnail != ""
                          ? FileImage(thumbnail!)
                          : (user.thumbnail != null &&
                                  user.thumbnail!.isNotEmpty
                              ? NetworkImage(
                                  "${AppConstants.BASE_URL}${AppConstants.GET_PRODUCT}/images/${user.thumbnail!}")
                              : null),
                      child: (thumbnail == null &&
                              (user.thumbnail == null ||
                                  user.thumbnail!.isEmpty))
                          ? const Icon(Icons.person,
                              size: 50, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      bottom: -5,
                      right: -5,
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.blue.shade100, width: 2),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit,
                              color: Colors.white, size: 16),
                          onPressed: changeThumbnail,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInput("Họ và tên", fullnameCtl),
                buildInput("Số điện thoại", phoneCtl,
                    keyboardType: TextInputType.phone),
                buildInput("Địa chỉ", addressCtl),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: TextFormField(
                    controller: dobCtl,
                    decoration: InputDecoration(
                      labelText: "Ngày sinh",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInput(String label, TextEditingController ctl,
      {TextInputType keyboardType = TextInputType.text}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: TextFormField(
        controller: ctl,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        ),
      ),
    );
  }
}
