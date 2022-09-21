import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:startupandfunds/loginScreen/Authentication.dart';
import 'package:startupandfunds/userInfoPage/InputUserPage.dart';
import 'dashboard/DashboardScreen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: SafeArea(child: FirebaseAuth.instance.currentUser == null ? Authentication() : InPutUserInfo(),),
    builder: EasyLoading.init(),
  ));

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }
}




