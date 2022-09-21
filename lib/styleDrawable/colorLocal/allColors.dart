
import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


Color getPrimaryColor(){
  return HexColor("#2C019C");
}
Color getColorPrimaryDark(){
  return HexColor("#FF6011");
}
Color getWhiteColor(){
  return HexColor("#ffffff");
}

Color getWhiteLightColor(){
  return HexColor("#1AFF6011");
}

Color getWhiteLight2Color(){
  return HexColor("#1A2C019C");
}

Color getSplashColorTop(){
  return HexColor("#FDEEE8");
}
Color getSplashColorBottom(){
  return HexColor("#EBE6F4");
}

Color getCharcol(){
  return HexColor("#121515");
}

Color getTangerine(){
  return HexColor("#ED841B");
}

Color getListItemBackTop(){
  return HexColor("#ff6011");
}

Color getListItemBackBottom(){
  return HexColor("#332c019c");
}