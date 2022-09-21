import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:startupandfunds/fonts/ApplicationFonts.dart';

import '../AllStrings/LocalStrings.dart';
import '../styleDrawable/colorLocal/allColors.dart';
import '../styleDrawable/styleDrawable.dart';
import '../utilities/Extentions.dart';
import '../utilities/GradientText.dart';

class ContactDetails extends StatefulWidget {

  ContactDetails({super.key, required this.snapshot,required this.oderBy,required this.collectionName});
  DocumentSnapshot snapshot;
  String oderBy,collectionName;
  @override
  State<StatefulWidget> createState() => _ContactDetails(snapshot,oderBy,collectionName);
}

class _ContactDetails extends State<StatefulWidget> {
  DocumentSnapshot snapshot;
  String oderBy,collectionName;
  _ContactDetails(this.snapshot,this.oderBy,this.collectionName);
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        if(MapExtension().getCountry(snapshot)!=null)Text(MapExtension().getCountry(snapshot)!,style: getRobotoRegular().get12(),),
      ],
    );
  }
}



