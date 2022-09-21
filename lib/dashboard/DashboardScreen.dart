
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupandfunds/FullList/FullListFunds.dart';
import 'package:startupandfunds/fonts/ApplicationFonts.dart';

import '../AllStrings/LocalStrings.dart';
import '../detailsPage/DetailsPage.dart';
import '../profile/ProfilePage.dart';
import '../styleDrawable/colorLocal/allColors.dart';
import '../styleDrawable/styleDrawable.dart';
import '../utilities/GradientText.dart';
import '../utilities/LocalCircularImage.dart';

class DashboardScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_DashboardScreen();

}
class _DashboardScreen extends State<StatefulWidget>{
  String _selectedCountry="All";
  String userName="Hamid Raza";
  String? userImage=null;

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
     return Scaffold(
       body: SafeArea(child: SizedBox(
         height: double.maxFinite,
         width: double.maxFinite,
         child: Container(
             decoration: getSplashDecoration(),
             child: Padding(
                 padding: EdgeInsets.all(10),
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                       Row(
                         children: [
                           Expanded(child: GradientText("${userName} Dashboard",style: getRobotoRegular().get30(),gradient: getMainGradiant(),)),
                           Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),child: InkWell(
                             child: userImage!=null?LocalCircularImage(imagePath: "${userImage}", size: 40):Container(),
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                             },
                           ),)
                         ],
                       ),
                        SizedBox(height: 20,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                            Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),child: Text("Currently showing for ",style: getRobotoRegular().get15(),),),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){
                                  print("Clicked");
                                  DialogCustom();
                                },
                                child:  Container(
                                  decoration: getCountryButtonStrock(),
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Text("${_selectedCountry}",style: getRobotoRegular().get20(),),
                                  ),
                                ),
                              ),
                            )
                          ],
                       ),



                       Padding(padding: EdgeInsets.only(top: 20),child: InkWell(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => FullListFunds(collectionName: "Funds", orderBy: "name",title: Investors(),)));
                         },
                         child: Row(
                           children: [
                             Expanded(child: Row(children: [
                               Text(Investors(),style: getRobotoRegular().get15(),),
                               Icon(Icons.navigate_next)
                             ],)),
                             Row(
                               children: [
                                 Text(seeAll(),style: getRobotoRegular().get15(),),
                                 Icon(Icons.navigate_next)
                               ],
                             )
                           ],
                         ),
                       ),),
                       UpdatesInvestor(collectionName: "Funds", orderBy: "name"),

                       Padding(padding: EdgeInsets.only(top: 20),child: InkWell(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => FullListFunds(collectionName: "Calls", orderBy: "name",title: GrantsFunds(),)));
                         },
                         child: Row(
                           children: [
                             Expanded(child: Row(children: [
                               Text(GrantsFunds(),style: getRobotoRegular().get15(),),
                               Icon(Icons.navigate_next)
                             ],)),
                             Row(
                               children: [
                                 Text(seeAll(),style: getRobotoRegular().get15(),),
                                 Icon(Icons.navigate_next)
                               ],
                             )
                           ],
                         ),
                       ),),
                       UpdatesInvestor(collectionName: "Calls", orderBy: "name"),


                       Padding(padding: EdgeInsets.only(top: 20),child: InkWell(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => FullListFunds(collectionName: "CoWorkingPlaces", orderBy: "name",title: CoWorkingSpaces(),)));
                         },
                         child: Row(
                           children: [
                             Expanded(child: Row(children: [
                               Text(CoWorkingSpaces(),style: getRobotoRegular().get15(),),
                               Icon(Icons.navigate_next)
                             ],)),
                             Row(
                               children: [
                                 Text(seeAll(),style: getRobotoRegular().get15(),),
                                 Icon(Icons.navigate_next)
                               ],
                             )
                           ],
                         ),
                       ),),
                       UpdatesInvestor(collectionName: "CoWorkingPlaces", orderBy: "name"),


                       Padding(padding: EdgeInsets.only(top: 20),child: InkWell(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => FullListFunds(collectionName: "tools", orderBy: "heading",title: tools(),)));
                         },
                         child: Row(
                           children: [
                             Expanded(child: Row(children: [
                               Text(tools(),style: getRobotoRegular().get15(),),
                               Icon(Icons.navigate_next)
                             ],)),
                             Row(
                               children: [
                                 Text(seeAll(),style: getRobotoRegular().get15(),),
                                 Icon(Icons.navigate_next)
                               ],
                             )
                           ],
                         ),
                       ),),
                       UpdatesInvestor(collectionName: "tools", orderBy: "heading"),


                       Padding(padding: EdgeInsets.only(top: 20),child: InkWell(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => FullListFunds(collectionName: "partners", orderBy: "heading",title: patners(),)));
                         },
                         child: Row(
                           children: [
                             Expanded(child: Row(children: [
                               Text(patners(),style: getRobotoRegular().get15(),),
                               Icon(Icons.navigate_next)
                             ],)),
                             Row(
                               children: [
                                 Text(seeAll(),style: getRobotoRegular().get15(),),
                                 Icon(Icons.navigate_next)
                               ],
                             )
                           ],
                         ),
                       ),),
                       UpdatesInvestor(collectionName: "partners", orderBy: "heading"),
                     ],
                   ),
                 )
             )
         ),
       ),),
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



   DialogCustom() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 500,
              decoration: getSplashDecoration().getRounded30(),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Text("Choose from country or region",style: getRobotoRegular().get20(),),),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close),
                      )
                    ],
                  ),
                  DefaultTabController(length: 2, child: Column(
                    children: [
                      TabBar(
                        indicator: BoxDecoration(
                          color:getTangerine(),
                          shape: BoxShape.values[0],
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        tabs: [
                          Tab(child: Text("Country",style: getRobotoRegular().get15(),),),
                          Tab(child: Text("Regions",style: getRobotoRegular().get15(),),),
                        ],

                      )
                    ],
                  )),
                ],
              ),
            ),
          );
        });
  }


}



class UpdatesInvestor extends StatefulWidget{
  UpdatesInvestor({super.key, required this.collectionName,required this.orderBy});
  String collectionName,orderBy;
  @override
  State<StatefulWidget> createState() => _UpdatesInvestor(collectionName,orderBy);
}
class _UpdatesInvestor extends State<UpdatesInvestor>{
  String collectionName,orderBy;
  _UpdatesInvestor(this.collectionName,this.orderBy);
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
      return SizedBox(
        height: 80,
        child: StreamBuilder(
            stream: db.collection(collectionName).orderBy(orderBy).limit(10).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: snapshot.data!.docs.map(AllPatternsList).toList(),
              );
            }
        ),
      );
  }
  Widget AllPatternsList(DocumentSnapshot documentSnapshot){
    return SizedBox(
        width: 150,
        child: Container(
            margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
            decoration: getMainBackground().getRounded30(),
            child: Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(snapshot: documentSnapshot,oderBy: orderBy,collectionName: collectionName,)));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(maxLines: 1,
                        overflow: TextOverflow.ellipsis,documentSnapshot[orderBy].toString(),style: getRobotoRegular().get15().getWeight(),textAlign: TextAlign.start,)),
                      Text(maxLines: 1,
                        overflow: TextOverflow.ellipsis,documentSnapshot.getValueString("type",collectionName),style: getRobotoRegular().get12().getWeight(),textAlign: TextAlign.start,),
                      Expanded(child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(readMore(),style: getRobotoRegular().get8().getWeight(),textAlign: TextAlign.end,)
                        ],
                      ))
                    ],
                  ),
                )
            )
        )
    );
  }
}
