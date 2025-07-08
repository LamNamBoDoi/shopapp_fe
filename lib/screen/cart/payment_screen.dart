import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/order_controller.dart';
import 'package:shopapp_v1/controller/product_controller.dart';
import 'package:shopapp_v1/controller/user_controller.dart';
import 'package:shopapp_v1/data/model/body/order.dart';
import 'package:shopapp_v1/data/model/user.dart';
import 'package:shopapp_v1/view/custom_button.dart';
import 'package:shopapp_v1/view/custom_snackbar.dart';
import 'package:shopapp_v1/view/drop_down_ui.dart';
import 'package:shopapp_v1/view/text_field_ui.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController fullnameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController phonenNumberCtl = TextEditingController();
  TextEditingController addressCtl = TextEditingController();
  TextEditingController noteCtl = TextEditingController();
  RxString selectedShipMethod = "Thường (Normal)".obs;
  RxString selectedPaymentMethod = "Thanh toán khi nhận hàng (COD)".obs;
  User user = Get.find<UserController>().userCurrent;
  List<String> shipMethod = ["Thường (Normal)", "Nhanh (Express)"];
  List<String> paymentMethod = [
    "Thanh toán khi nhận hàng (COD)",
    "Phương thức khác"
  ];

  @override
  void initState() {
    super.initState();
    fullnameCtl.text = user.fullname ?? "";
    phonenNumberCtl.text = user.phoneNumber ?? "";
    addressCtl.text = user.address ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Điền thông tin"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFieldUI(
                controller: fullnameCtl,
                icon: Icon(Icons.person_2_outlined),
                title: "Fullname",
                hint: "Nguyễn Văn A",
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldUI(
                controller: emailCtl,
                icon: Icon(Icons.email_outlined),
                title: "Email",
                hint: "abc@gmail.com",
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldUI(
                controller: phonenNumberCtl,
                icon: Icon(Icons.phone_android_outlined),
                title: "Phonenumber",
                hint: "123456789",
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldUI(
                controller: addressCtl,
                icon: Icon(Icons.location_on),
                title: "Address",
                hint: "Hà Nội",
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldUI(
                controller: noteCtl,
                icon: Icon(Icons.note_add_outlined),
                title: "Note",
                hint: "Hàng dễ vỡ",
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() => DropDownUi(
                    title: "Phương thức vận chuyển",
                    items: shipMethod,
                    selectedValue: selectedShipMethod.value,
                    onChanged: (value) {
                      selectedShipMethod.value = value ?? "";
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              Obx(() => DropDownUi(
                    title: "Phương thức thanh toán",
                    items: paymentMethod,
                    selectedValue: selectedPaymentMethod.value,
                    onChanged: (value) {
                      selectedPaymentMethod.value = value ?? "";
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                labelButton: "Đặt hàng",
                onTap: () {
                  Get.find<OrderController>()
                      .createOrder(Order(
                          userId: user.id,
                          fullname: fullnameCtl.text,
                          email: emailCtl.text,
                          phoneNumber: phonenNumberCtl.text,
                          address: addressCtl.text,
                          note: noteCtl.text,
                          shippingMethod: selectedShipMethod.value,
                          paymentMethod: selectedPaymentMethod.value,
                          active: true,
                          totalMoney:
                              Get.find<ProductController>().totalMoney.value,
                          listCartItem:
                              Get.find<ProductController>().listCartItem))
                      .then((value) {
                    if (value == 200) {
                      showCustomFlash("Đặt hàng thành công", Get.context!,
                          isError: false);
                      Get.find<ProductController>().clearCart();
                    } else {
                      showCustomFlash("Đặt hàng thất bại", Get.context!,
                          isError: false);
                    }
                    Get.back();
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
