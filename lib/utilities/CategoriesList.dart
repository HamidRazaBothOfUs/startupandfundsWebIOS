
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupandfunds/fonts/ApplicationFonts.dart';
import 'package:startupandfunds/utilities/Extentions.dart';

import '../styleDrawable/styleDrawable.dart';

class CategoriesList extends StatefulWidget {
  CategoriesList({required this.valuesMap, required this.selectedSubCate});
  Map<String,dynamic> valuesMap;
  String selectedSubCate;
  @override
  State<StatefulWidget> createState() => _CategoriesList(valuesMap: valuesMap,selectedSubCate:selectedSubCate);
}
class _CategoriesList extends State<CategoriesList> {
  _CategoriesList({required this.valuesMap, required this.selectedSubCate});
  Map<String,dynamic> valuesMap;
  String selectedSubCate;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedSubCate = valuesMap["key"];
        });
      },
      child: Padding(padding: EdgeInsets.all(5),child: Container(padding:EdgeInsets.fromLTRB(5,2,5,2),decoration: valuesMap["key"].toString().checkIfThisCateSelected(selectedSubCate)? getMainBackground().getRounded10():getGmailButtonStrock().getRounded10(),child: Center(child: Text(valuesMap["name"],style: valuesMap["key"].toString().checkIfThisCateSelected(selectedSubCate)?getRobotoRegular().get15().getWeight():getRobotoRegular().get15()),),),),
    );
  }
}