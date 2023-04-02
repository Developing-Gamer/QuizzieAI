import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:video_to_quiz/Screens/linkProvider.dart';
import 'package:video_to_quiz/main.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

void signOut(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const LandingPage(),
    ),
  );
}

class PhoneAuthController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  SharedPreferences? prefs;
  final formKey = GlobalKey<FormState>();
  bool isCodeSent = false;

  late TwilioFlutter twilioFlutter;

  var sentOTP;

  savePhone() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString("phone", phoneController.text);
  }

  showInvisibleWidgets() {
    isCodeSent = true;
    update();
  }

  sendSMS() {
    twilioFlutter = TwilioFlutter(
      accountSid: 'AC6712bbd97c840fa9a3aa80634ab810bf',
      authToken: '954b4f53b46472b1d224d4685c9c9a75',
      twilioNumber: '(276) 400-0064',
    );

    var rnd = new Random();

    var digits = rnd.nextInt(900000) + 100000;
    //var digits = 000000;

    sentOTP = digits;

    twilioFlutter.sendSMS(
        toNumber: phoneController.text,
        messageBody:
            //'Hi Ishaan!, This is the 6 digit otp code to verify your phone $digits (This is also How many Friends you got bitch!)');
            'This is the 6 digit otp code to verify your phone $digits');
  }

  verifyOTP(BuildContext context) async {
    if (sentOTP.toString() == codeController.text) {
      GFToast.showToast(
        "OTP Verified SuccessFully!",
        context,
        toastPosition: GFToastPosition.BOTTOM,
      );

      savePhone();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      //Hint: Save data to MongoDB

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LinkProviderScreen(),
        ),
      );
    } else {
      GFToast.showToast(
        'OTP Not Verified!',
        context,
        toastPosition: GFToastPosition.BOTTOM,
      );
    }
  }
}

class HelperFunctions {
  static String sharedPreferenceUserThemeKey = "ISTHEME",
      sharedPreferenceUserNameKey = "USERNAMEKEY",
      sharedPreferenceUserPhoneKey = "USERPhoneKEY",
      sharedPreferenceUserEmailKey = "USEREMAILKEY",
      sharedPreferenceUserImageKey = "USERIMAGEKEY";

  /// saving data to sharedpreference

  static Future<bool> saveUserNameSharedPreference(String? userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, userName!);
  }

  static Future<bool> saveUserPhoneSharedPreference(int? userPhone) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(sharedPreferenceUserPhoneKey, userPhone!);
  }

  static Future<bool> saveUserEmailSharedPreference(String? userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        sharedPreferenceUserEmailKey, userEmail!);
  }

  static Future<bool> saveUserImageSharedPreference(String? userImage) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        sharedPreferenceUserImageKey, userImage!);
  }

  /// fetching data from sharedpreference

  static Future<String?> getUserNameSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserNameKey);
  }

  static Future<int?> getUserPhoneSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(sharedPreferenceUserPhoneKey);
  }

  static Future<String?> getUserEmailSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserEmailKey);
  }

  static Future<String?> getUserImageSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserImageKey);
  }
}
