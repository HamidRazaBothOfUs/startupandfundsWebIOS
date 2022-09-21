

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:startupandfunds/dashboard/DashboardScreen.dart';
import 'package:startupandfunds/fonts/ApplicationFonts.dart';
import 'package:startupandfunds/utilities/GradientText.dart';
import '../AllStrings/LocalStrings.dart';
import '../styleDrawable/styleDrawable.dart';
import '../userInfoPage/InputUserPage.dart';

class Authentication extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _Authentication();
}

class _Authentication extends State<Authentication> {

  GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "443633037277-ibf9k511eheapb6gn5mljq3octlfjcp2.apps.googleusercontent.com",
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  bool checkStatus=true;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Container(
                decoration: getSplashDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GradientText(style: getRobotoRegular().get30(),getWelcome(),gradient: getMainGradiant(),),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(30),
                            decoration: getGmailButtonStrock(),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){
                                  print('OS: ${kIsWeb}');
                                  if(!kIsWeb){
                                    _handleSignIn();
                                  }else{
                                    _signInWithGoogleWeb();
                                  }
                                },
                                child: Row(
                                  children: [
                                    Padding(padding: EdgeInsets.fromLTRB(20, 5, 10, 5),child: Image.asset("google.png",width: 24,height: 24,),),
                                    Expanded(
                                      child: Center(
                                        child: Text(ContinueWithGoogle(),style: getRobotoRegular().get15(),),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                          ),
                          Container(
                            margin: EdgeInsets.all(30),
                            decoration: getGmailButtonStrock(),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: _handleApple,
                                child: Row(
                                  children: [
                                    Padding(padding: EdgeInsets.fromLTRB(20, 5, 10, 5),child: Image.asset("apple_icon.png",width: 24,height: 24,),),
                                    Expanded(
                                      child: Center(
                                        child: Text(ContinueWithApple(),style: getRobotoRegular().get15(),),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                          ),
                          Padding(padding: EdgeInsets.all(30),child: Row(
                            children: [
                              Checkbox(value: checkStatus, onChanged: (bool){
                                setState(() {
                                  checkStatus = bool!;
                                });
                              },),
                              Expanded(child: Text(checkTerms(),style: getRobotoRegular().get12(),)),
                              Text("Terms & Conditions.",style: getRobotoRegular().get12().getLink(),)
                            ],
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              )
          )
      ),
    );
  }
  Future<void> _handleSignIn() async {
    try {
      print("0005");
     var signInResult= await _googleSignIn.signIn();
     print("0006");
      if(signInResult!=null){
        print("000");
        var authResult=await signInResult.authentication;
        print("001");
        var credential=GoogleAuthProvider.credential(
          accessToken: authResult.accessToken,
          idToken: authResult.idToken,
        );
        print("002");
        EasyLoading.show(status: 'loading...');
        await FirebaseAuth.instance.signInWithCredential(credential);
        EasyLoading.dismiss();
        getCurrentUser(signInResult.email,signInResult.displayName,signInResult.photoUrl);
      }
    } catch (error) {
      print(error);
    }
  }


  Future<void> _signInWithGoogleWeb() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({
      'login_hint': 'user@example.com'
    });

    // Once signed in, return the UserCredential
    var googleAuth= await FirebaseAuth.instance.signInWithPopup(googleProvider);

    googleAuth.user!.email;

    getCurrentUser(googleAuth.user!.email!,googleAuth.user!.displayName,googleAuth.user!.photoURL);


  }




  Future getCurrentUser(String email, String? displayName, String? photoUrl,) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .get()
          .then((value) => {
            if(value.exists){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>InPutUserInfo()))
            }else{
              EasyLoading.show(status: 'loading...'),
              value.reference.set({
                "username":displayName,
                "profileImageUrl":photoUrl,
              }).then((value) => {
              EasyLoading.dismiss(),
              Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
              builder: (context) => InPutUserInfo()),
              (route) => false)
              }).catchError((onError)=>{
              EasyLoading.dismiss(),
              EasyLoading.showError(onError.toString())
              })
            }
      })
          .catchError((onError) => {print(onError)});
    }
  }


  Future<void> _handleApple() async {
  }
}