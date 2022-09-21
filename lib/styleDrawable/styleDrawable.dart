


import 'package:flutter/material.dart';

import '../fonts/ApplicationFonts.dart';
import 'colorLocal/allColors.dart';

BoxDecoration getMainBackground(){
  return BoxDecoration(
      gradient: getMainGradiant());
}

LinearGradient getMainGradiant(){
  return  LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      getPrimaryColor(),
      getColorPrimaryDark(),
    ],
  );
}



Container getWeightLayer(){
  return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              getWhiteLightColor().withAlpha(250),
              getWhiteLight2Color().withAlpha(250),
            ],
          )));
}

BoxDecoration getSplashDecoration(){
  return BoxDecoration(
    gradient: LinearGradient(colors: [
           getSplashColorTop(),
           getSplashColorBottom()
    ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    )
  );
}

BoxDecoration getWeight(){
  return BoxDecoration(
      gradient: LinearGradient(colors: [
        getWhiteColor(),
        getWhiteColor()
      ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      )
  );
}

InputDecoration getInputDecoration(){
  return InputDecoration(
    hintStyle: getRobotoRegular().get12(),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
  );
}

BoxDecoration getGmailButtonStrock(){
  return BoxDecoration(
    border: Border.all(color: Colors.grey,width: 1),
    borderRadius: BorderRadius.circular(10.0),
    color: Colors.transparent,
  );
}
BoxDecoration getCountryButtonStrock(){
  return BoxDecoration(
      border: Border.all(color: getPrimaryColor(),width: 1),
      borderRadius: BorderRadius.circular(10.0)
  );
}

extension MakeRound on BoxDecoration{
  BoxDecoration getRounded30(){
    return copyWith(
       borderRadius: BorderRadius.circular(30.0)
    );
  }
  BoxDecoration getRounded10(){
    return copyWith(
        borderRadius: BorderRadius.circular(10.0)
    );
  }
  BoxDecoration getRounded10Bottom(){
    return copyWith(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0))
    );
  }
  BoxDecoration getRounded30Bottom(){
    return copyWith(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0))
    );
  }
}


BoxDecoration getListItemBack(){
  return BoxDecoration(
      gradient: LinearGradient(colors: [
        getListItemBackTop(),
        getListItemBackBottom()
      ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      )
  );
}

