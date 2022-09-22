
import 'package:cloud_firestore/cloud_firestore.dart';

class MapExtension{


  String  getSubHeading(Map<dynamic,dynamic> values,String collectionName,String defaultKey){
    if(collectionName=="tools" || collectionName=="partners"){
      return values["subHeading"];
    }
    if(collectionName=="CoWorkingPlaces"){
      return "";
    }
    return values[defaultKey].toString();
  }


  String?  getCountry(DocumentSnapshot snapshot){
    return getKeyValue(snapshot, "country");
  }

  String?  getCity(DocumentSnapshot snapshot){
    return getKeyValue(snapshot, "city");
  }

  String?  getRegion(DocumentSnapshot snapshot){
    return getKeyValue(snapshot, "region");
  }

  String?  getFunding(DocumentSnapshot snapshot){
    var value=getKeyValue(snapshot, "funding");
    if(value!=null){
      return value;
    }
    return getKeyValue(snapshot, "fundDetails");
  }

  String?  getPrice(DocumentSnapshot snapshot){
    return getKeyValue(snapshot, "price");
  }
  String?  getFocusArea(DocumentSnapshot snapshot){
    return getKeyValue(snapshot, "focusArea");
  }

  String?  getSubHeadingValue(DocumentSnapshot snapshot){
    return getKeyValue(snapshot, "subHeading");
  }
  String?  getDescription(DocumentSnapshot snapshot){
    return getKeyValue(snapshot, "description");
  }

  List<Map<String,dynamic>>  getAllFilters(Map values,String collectionName){
    List<Map<String,dynamic>> filters=[];
    if(collectionName.contains("Call")){
        filters=getAllFiltersList(values["allCalls"]);
    }
    if(collectionName.contains("Funds")){
      filters=getAllFiltersList(values["allFilters"]);
    }
    if(collectionName.contains("partners")){
      filters=getAllFiltersList(values["allPartners"]);
    }
    if(collectionName.contains("tools")){
      filters=getAllFiltersList(values["allTools"]);
    }

    if(filters.isEmpty){
      return List<Map<String,dynamic>>.empty();
    }
    return filters;
  }
  List<Map<String,dynamic>>  getAllFiltersList(dynamic values){
    List<Map<String,dynamic>> filters=[];
    if(values!=null){
      values.forEach((element) {
        filters.add(element);
      });
    }
    if(filters.isEmpty){
      return List<Map<String,dynamic>>.empty();
    }
    return filters.orderBy("position").moveAValueToFirst("key", "All");
  }

  List<Map<String,dynamic>>  getContactList(DocumentSnapshot snapshot){
    var values = snapshot.data() as Map;
    var key="contactDetails";
    if(!values.containsKey(key)){
      return List<Map<String,dynamic>>.empty();
    }
    List<dynamic> contactList=values[key];
    List<Map<String,dynamic>> filteredList=[];

    for(var contact in contactList){
      if(contact["value"]!=null && contact["value"]!=""){
        var Map={"type":contact["type"],"value":contact["value"]};
        filteredList.add(Map);
      }
    }
    if(filteredList.isEmpty){
      return List<Map<String,dynamic>>.empty();
    }
    return filteredList;
  }



  String?  getKeyValue(DocumentSnapshot snapshot,String key){
    var values = snapshot.data() as Map;
    if(values==null){
      return null;
    }
    if(!values.containsKey(key)){
      return null;
    }
    if(values[key]==null){
      return null;
    }
    if(values[key].toString().isEmpty){
      return null;
    }
    return values[key].toString();
  }


  Query<Map<String,dynamic>> getCurrentStream(String selectedCategory,String collection,String orderBy){
    print("StreamGetterCalled  $selectedCategory  $collection  $orderBy");
    if(collection=="Funds" || collection=="Calls" || collection=="CoWorkingPlaces"){
      if(selectedCategory=="All" || selectedCategory==""){
        print("StreamGetterCalled01");
        return FirebaseFirestore.instance.collection(collection).orderBy(orderBy);
      }else{
        print("StreamGetterCalled02");
        return FirebaseFirestore.instance.collection(collection).where("type",isEqualTo: selectedCategory).orderBy(orderBy);
      }
    }
    print("StreamGetterCalled03");
    if(collection=="tools" || collection=="partners"){
      print("StreamGetterCalled04");
      if(selectedCategory=="All" || selectedCategory==""){
        print("StreamGetterCalled05");
        return FirebaseFirestore.instance.collection(collection).orderBy(orderBy);
      }else{
        print("StreamGetterCalled06");
        return FirebaseFirestore.instance.collection(collection).where("Category",isEqualTo: selectedCategory).orderBy(orderBy);
      }
    }
    print("StreamGetterCalled07");
    return FirebaseFirestore.instance.collection(collection).orderBy(orderBy);
  }

}



extension  conpareExtentions on String{
  bool checkIfThisCateSelected(String selectedValue){
    if(selectedValue==""){
      return this=="All";
    }
    return this==selectedValue;
  }
  Query<Map<String,dynamic>> getCurrentStream(String collection,String orderBy){
    return MapExtension().getCurrentStream(this, collection, orderBy);
  }
}

extension MapListOrderBy on List<Map<String,dynamic>>{
  List<Map<String,dynamic>> orderBy(String key){
    List<Map<String,dynamic>> list=this;
    list.sort((a,b){
      var aVal=a[key];
      var bVal=b[key];
      if(aVal==null){
        return 1;
      }
      if(bVal==null){
        return -1;
      }
      return aVal.compareTo(bVal);
    });
    return list;
  }
  List<Map<String,dynamic>> moveAValueToFirst(String key,String value){
    List<Map<String,dynamic>> list=this;
    var index=list.indexWhere((element) => element[key]==value);
    if(index==-1){
      return list;
    }
    var first=list.first;
    list[0]=list[index];
    list[index]=first;
    return list;
  }
}

extension getCountriesList on List<String>{
  List<String> getInOrder(){
    List<String> list=this;
    list.sort((a,b){
      return a.compareTo(b);
    });
    return list;
  }
  List<String> removeDublicateString(){
    List<String> list=this;
    List<String> newList=[];
    newList.add("All");
    for(var item in list){
      if(!newList.contains(item)){
        newList.add(item);
      }
    }
    return newList;
  }


}

extension getRegionsList on Map<String,dynamic>{
  List<String> getValueForKey(){
    List<String> list=[];
    this.forEach((key, value) {
      if(key=="key"){
        list.add(value);
      }
    });
    return list;
  }

}