import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helpers/auth.dart';

class PhoneAuthScreen extends StatelessWidget {
  PhoneAuthController controller = Get.put(PhoneAuthController());
  TextEditingController nameController = TextEditingController();
  SharedPreferences? prefs;

  saveName() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString("name", nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Phone Auth"),
          centerTitle: true,
          elevation: 0,
        ),
        body: GetBuilder<PhoneAuthController>(
          builder: (_) => Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        hintText: "Joe Mama", labelText: "Name"),

                    // lets add validation
                    validator: (String? string) {
                      if (string!.isEmpty) {
                        return "Enter Full Name";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: controller.phoneController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "(XXX) XXX-XXXX", labelText: "Phone Number"),

                    // lets add validation
                    validator: (String? number) {
                      if (number!.isEmpty) {
                        return "Enter Phone Number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: controller.isCodeSent,
                    child: TextFormField(
                      controller: controller.codeController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: const InputDecoration(
                          hintText: "123456", labelText: "Code"),

                      // lets add validation
                      validator: (String? code) {
                        if (code!.isEmpty) {
                          return "Enter Code";
                        } else if (code.length < 6) {
                          return "Code should be of length 6";
                        }

                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: !controller.isCodeSent,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              saveName();
                              if (controller.formKey.currentState!.validate()) {
                                controller.sendSMS();
                                controller.showInvisibleWidgets();
                              }
                            },
                            child: const Text('Submit'))),
                  ),
                  Visibility(
                    visible: controller.isCodeSent,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.verifyOTP(context);
                              }
                            },
                            child: const Text('Verify'))),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
