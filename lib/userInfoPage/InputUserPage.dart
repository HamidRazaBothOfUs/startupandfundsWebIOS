import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:startupandfunds/dashboard/DashboardScreen.dart';
import 'package:startupandfunds/fonts/ApplicationFonts.dart';
import 'package:startupandfunds/styleDrawable/styleDrawable.dart';
import 'package:startupandfunds/utilities/GradientText.dart';

class InPutUserInfo extends StatefulWidget {
  @override
  _InPutUserInfoState createState() => _InPutUserInfoState();
}

class _InPutUserInfoState extends State<InPutUserInfo> {
  String? _verticalGroupValue = "Yes";
  List<String> _status = ["Yes", "No"];
  List<String> intrustList = <String>[
    'Grants & Funds',
    'Calls',
    'Partners',
    'Tools',
    'All of above'
  ];

  String selectedIntrust = "Grants & Funds";

  List<String> sector_list = <String>[
    'Administrative Services ',
    'Advertising',
    'Aerospace'
  ];

  String selectedSector = "Administrative Services ";
  String userName = "";

  String? website;
  String? companyName;
  GlobalKey? formKey ;

  @override
  void initState() {
   formKey = GlobalKey<FormState>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    getAdminDetails();
    getCurrentUser();
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: getSplashDecoration(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child:SizedBox(
                      width: 400,
                      child: Column(
                        children: [
                          Text(
                            "Welcome ${userName}!",
                            style: getRobotoRegular().get20(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "To provide tailored information we need,",
                            style: getRobotoRegular().get20(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child:SizedBox(
                                  width: 400,
                                  child:     Container(
                                    decoration: getMainBackground().getRounded10(),
                                    child: Container(
                                      decoration: getWeight().getRounded10(),
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      child: createInPutForm(),
                                    ),
                                  ),
                                )
                                ,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DashboardScreen()));
                                  },
                                  child: Text(
                                    "Skip",
                                    style: getRobotoRegular().get12().getPrimary(),
                                  ),
                                )
                              ])
                        ],
                      ),
                    )
                    ,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget createInPutForm() {


    return SizedBox(
      width: 400,
      child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Company name:",
                style: getRobotoRegular().get12(),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: getInputDecoration(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  companyName= value;
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Do you have a website?",
                      style: getRobotoRegular().get12(),
                    ),
                  ),
                  RadioGroup.builder(
                    direction: Axis.horizontal,
                    groupValue: _verticalGroupValue,
                    onChanged: (value) => setState(() {
                      _verticalGroupValue = value;
                    }),
                    items: _status,
                    itemBuilder: (item) => RadioButtonBuilder(item!,
                        textPosition: RadioButtonTextPosition.right),
                  ),
                ],
              ),
              Visibility(
                visible: _verticalGroupValue == "Yes",
                child: TextFormField(
                  decoration: getInputDecoration(),
                  validator: (value) {
                    if (_verticalGroupValue == "Yes") {
                      if (value == null || value.isEmpty) {
                        return 'Please enter website';
                      }
                    }
                    website = value;
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Sector:",
                style: getRobotoRegular().get12(),
              ),
              DropdownButton(
                isExpanded: true,
                style: getRobotoRegular().get12(),
                items: sector_list
                    .map((e) => DropdownMenuItem(
                  child: Text(e, style: getRobotoRegular().get12()),
                  value: e,
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    print(value.toString() + "01");
                    selectedSector = value.toString();
                  });
                },
                value: selectedSector,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "What are you interested about?(So we can provide you with latest updates).",
                style: getRobotoRegular().get12(),
              ),
              DropdownButton<String>(
                style: getRobotoRegular().get12(),
                isExpanded: true,
                items: intrustList
                    .map((e) => DropdownMenuItem(
                  child: Text(e, style: getRobotoRegular().get12()),
                  value: e,
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    print(value.toString() + "02");
                    selectedIntrust = value!;
                  });
                },
                value: selectedIntrust,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      updateAdminDetails();
                    },
                    child: Container(
                      decoration: getMainBackground().getRounded10(),
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: getRobotoRegular().get12().getWeight(),
                        ),
                      ),
                    ),
                  ),

                ],
              )
            ],
          )),
    );
  }

  Future getAdminDetails() async {
    FirebaseFirestore.instance
        .collection("adminControl")
        .doc("userDetails")
        .get()
        .then((value) => {
              setState(() {
                intrustList = List.from(value.data()!["interest"]);
                sector_list = List.from(value.data()!["subjects"]);
              })
            })
        .catchError((onError) => {});
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
                  if (value.data()!["companyDetails"] != null) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen()),
                        (route) => false);
                  }
                })
              })
          .catchError((onError) => {print(onError)});
    }
  }

  Future updateAdminDetails() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      EasyLoading.show(status: 'loading...');
      FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .update({
            "companyDetails": {
              "companyName": companyName,
              "website": website,
              "section": selectedSector,
              "interest": selectedIntrust
            }
          })
          .then((value) => {
                EasyLoading.dismiss(),
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                    (route) => false)
              })
          .catchError((onError) => {print(onError), EasyLoading.dismiss()});
    }
  }
}
