import 'dart:io';

class AdHelper {

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7394253111529621/7972687699";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_NATIVE_AD_UNIT_ID>";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}