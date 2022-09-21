
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styleDrawable/colorLocal/allColors.dart';

TextStyle getRobotoRegular(){
  return GoogleFonts.roboto(fontStyle: FontStyle.normal).copyWith(
    color: getCharcol()
  );
}

extension GetFontSize on TextStyle{
   TextStyle get30(){
     return copyWith(
       fontSize: 30
     );
   }
   TextStyle get20(){
     return copyWith(
         fontSize: 20
     );
   }

   TextStyle get15(){
     return copyWith(
         fontSize: 15
     );
   }
   TextStyle get18(){
     return copyWith(
         fontSize: 18
     );
   }
   TextStyle get12(){
     return copyWith(
         fontSize: 12
     );
   }
   TextStyle get8(){
     return copyWith(
         fontSize: 8
     );
   }
   TextStyle getWeight(){
     return copyWith(
         color: getWhiteColor()
     );
   }
   TextStyle getPrimary(){
     return copyWith(
         color: getPrimaryColor()
     );
   }
   TextStyle getLink(){
     return copyWith(
         color: getPrimaryColor(),
         decoration: TextDecoration.underline,
         fontSize: 15
     );
   }
   TextStyle getDetailsHeading(){
     return copyWith(
         color: getCharcol(),
          fontSize: 18,
          fontWeight: FontWeight.bold
     );
   }
}

