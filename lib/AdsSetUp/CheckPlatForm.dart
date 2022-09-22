import 'dart:io';

class CheckPlatForm {

  static bool get checkForIOS {
    try{
      if (Platform.isAndroid) {
        return false;
      } else if (Platform.isIOS) {
        return true;
      } else {
        return false;
      }
    }catch(e){
      return false;
    }
  }
}