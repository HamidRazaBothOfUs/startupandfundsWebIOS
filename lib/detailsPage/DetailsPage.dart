import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:startupandfunds/fonts/ApplicationFonts.dart';
import 'package:startupandfunds/utilities/ContactDetailsWithImage.dart';
import 'package:startupandfunds/utilities/ShowDetailsBoldHeading.dart';

import '../AllStrings/LocalStrings.dart';
import '../styleDrawable/colorLocal/allColors.dart';
import '../styleDrawable/styleDrawable.dart';
import '../utilities/Extentions.dart';
import '../utilities/GradientText.dart';
import 'ContactDetails.dart';

class DetailsPage extends StatefulWidget {

  DetailsPage({super.key, required this.snapshot,required this.oderBy,required this.collectionName});
  DocumentSnapshot snapshot;
  String oderBy,collectionName;
  @override
  State<StatefulWidget> createState() => _DetailsPage(snapshot,oderBy,collectionName);
}

class _DetailsPage extends State<StatefulWidget> {
  DocumentSnapshot snapshot;
  String oderBy,collectionName;
  _DetailsPage(this.snapshot,this.oderBy,this.collectionName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: getMainBackground().getRounded30Bottom(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Icon(Icons.arrow_back,color: getWhiteColor(),),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    Padding(
                        padding:EdgeInsets.all(5)
                    ),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      snapshot[oderBy].toString(),
                      style: getRobotoRegular()
                          .get20()
                          .getWeight(),
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                        padding:EdgeInsets.all(5)
                    ),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis," "+snapshot.getValueString("type",collectionName),
                      style: getRobotoRegular()
                          .get18()
                          .getWeight(),
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                        padding:EdgeInsets.all(5)
                    ),
                    Padding(
                        padding:EdgeInsets.all(5)
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding:EdgeInsets.all(5)
            ),
            SingleChildScrollView(
              child: Padding(padding: EdgeInsets.fromLTRB(20,0,20,0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShowDetailsBoldHeading(heaing: "Country      ", value: MapExtension().getCountry(snapshot),),
                    ShowDetailsBoldHeading(heaing: "City             ", value: MapExtension().getCity(snapshot),),
                    ShowDetailsBoldHeading(heaing: "Price          ", value: MapExtension().getPrice(snapshot),),
                    ShowDetailsBoldHeading(heaing: "Funding      ", value: MapExtension().getFunding(snapshot),),
                    ShowDetailsBoldHeading(heaing: "Focus Area", value: MapExtension().getFocusArea(snapshot),),
                    if(MapExtension().getDescription(snapshot)!=null)Padding(padding: EdgeInsets.all(5),child: Text(MapExtension().getDescription(snapshot)!,style: getRobotoRegular().get12(),),),
                    if(MapExtension().getSubHeadingValue(snapshot)!=null)Padding(padding: EdgeInsets.all(5),child: Text(MapExtension().getSubHeadingValue(snapshot)!,style: getRobotoRegular().get12(),),),
                    if(MapExtension().getContactList(snapshot).isNotEmpty)ShowDetailsBoldHeading(heaing: "Contact Details", value: ""),
                    Column(
                      children: MapExtension().getContactList(snapshot).map((e) => ContactDetailsWithImage(type: e["type"], value: e["value"])).toList(),
                    )
                  ],
                ),),
            )
          ],
        ),)
    );
  }


}
