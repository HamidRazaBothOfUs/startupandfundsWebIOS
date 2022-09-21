
import 'package:cloud_firestore/cloud_firestore.dart';

String getWelcome(){
  return "Welcome";
}
String ContinueWithGoogle(){
  return "Continue with Google";
}
String ContinueWithApple(){
  return "Continue with Apple";
}
String checkTerms(){
  return "I read and agree with the ";
}
String Investors(){
  return "Investors";
}
String seeAll(){
  return "See all";
}
String readMore(){
  return "Read more";
}
String GrantsFunds(){
  return "Grants & Funds";
}

String CoWorkingSpaces(){
  return "Co-working spaces";
}
String tools(){
  return "Tools";
}
String patners(){
  return "Partners";
}


extension getValueOrEmpty on DocumentSnapshot{
  String getValueString(String string,String collectionName){
    if(collectionName=="tools" || collectionName=="partners"){
      return this["subHeading"];
    }
    if(collectionName=="CoWorkingPlaces"){
      return "";
    }
    return this[string].toString();
  }
}


