

import 'package:flutter/material.dart';

import '../fonts/ApplicationFonts.dart';

class ShowDetailsBoldHeading extends StatelessWidget{
  ShowDetailsBoldHeading({super.key, required this.heaing,required this.value});

  String heaing;
  String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(value!=null)Padding(padding: EdgeInsets.all(5),child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(heaing+" :",style: getRobotoRegular().getDetailsHeading(),),
        Padding(
            padding:EdgeInsets.all(5)
        ),
        Text(value!,style: getRobotoRegular().get15(),),
        Padding(
            padding:EdgeInsets.all(5)
        ),
      ],
    ),)
      ],
    );
  }

}