
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupandfunds/styleDrawable/colorLocal/allColors.dart';
import 'package:startupandfunds/styleDrawable/styleDrawable.dart';

import '../fonts/ApplicationFonts.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}
class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Container(
                 decoration: getSplashDecoration().getRounded30Bottom(),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Stack(
                       children: [
                         Row(
                             children:[
                               InkWell(
                                 onTap: (){
                                   Navigator.pop(context);
                                 },
                                 child: Container(
                                   margin: EdgeInsets.all(10),
                                   child: Icon(Icons.arrow_back,color: getCharcol(),),
                                 ),
                               ),
                             ]
                         ),
                         Row(
                             children:[
                               Expanded(child: Center(child: Text("Store",style: getRobotoRegular().get30(),),),)
                             ]
                         ),
                       ],
                     ),
                     Expanded(child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children:[
                           Expanded(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 SizedBox(width: 100,height: 100,child: Image.asset("smile_shop.png"),),
                                 Text("26",style: getRobotoRegular().get30(),),
                               ],
                             ),
                           )
                         ]
                     ),),
                     DefaultTabController(length: 2, child: TabBar(
                       indicator: BoxDecoration(
                         color:getTangerine(),
                         shape: BoxShape.values[0],
                         borderRadius: BorderRadius.all(Radius.circular(30.0)),
                       ),
                       tabs: [
                       Tab(child: Text("Redeem",style: getRobotoRegular().get15(),),),
                       Tab(child: Text("Get more",style: getRobotoRegular().get15(),),),
                     ],),)
                   ],
                 ),
              ),
            )),
            Expanded(child: SizedBox(
              width: double.infinity,
              height: double.infinity,
            )),
          ],
        ),
      ),
    );
  }
}