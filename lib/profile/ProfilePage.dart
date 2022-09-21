
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:startupandfunds/fonts/ApplicationFonts.dart';
import 'package:startupandfunds/styleDrawable/styleDrawable.dart';
import 'package:startupandfunds/utilities/GradientText.dart';

import '../ShopScreen/ShopScreen.dart';
import '../loginScreen/Authentication.dart';
import '../utilities/LocalCircularImage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  String userName="";
  String? userImage=null;
  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Container(
            padding: EdgeInsets.only(top: 20),
            decoration: getSplashDecoration(),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(child: Text(""),),
                    Expanded(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Expanded(child: Image.asset("profile_right.png"),),
                        Expanded(child: Image.asset("profile_left.png"),),
                      ]
                    )),
                    Text("Version 1.0.0",style: getRobotoRegular().get8()),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Padding(padding: EdgeInsets.only(left: 10),child: Icon(Icons.arrow_back),),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                            child: Center(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GradientText("${userName}",style:getRobotoRegular().get30(),gradient: getMainGradiant(),),
                                    SizedBox(width: 10,),
                                    userImage==null?Container():LocalCircularImage(imagePath: "${userImage}", size: 60),
                                  ],
                                )
                            )
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    ListTile(title: Text("Shop",style: getRobotoRegular().get15(),),onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShopScreen()));
                    },),
                    ListTile(title: Text("Share the app",style: getRobotoRegular().get15(),),subtitle: Text("tell your friends",style: getRobotoRegular().get12(),),),
                    ListTile(title: Text("Terms & Conditions",style: getRobotoRegular().getLink(),)),
                    ListTile(title: Text("Delete Account",style: getRobotoRegular().getLink(),)),
                    SizedBox(height: 10,),
                    Center(
                      child: InkWell(
                        onTap: (){
                          FirebaseAuth.instance.signOut().then((value) => {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Authentication()), (route) => false)
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Log out",style: getRobotoRegular().getLink(),),
                            Icon(Icons.login_outlined)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

  Future getCurrentUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .get()
          .then((value) => {
        setState(() {
          userName = value.data()!["username"];
          userImage= value.data()!["profileImageUrl"];
        })
      })
          .catchError((onError) => {print(onError)});
    }
  }
}
