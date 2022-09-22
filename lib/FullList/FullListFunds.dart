import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:startupandfunds/detailsPage/DetailsPage.dart';
import 'package:startupandfunds/fonts/ApplicationFonts.dart';
import 'package:startupandfunds/utilities/CategoriesList.dart';

import '../AllStrings/LocalStrings.dart';
import '../styleDrawable/colorLocal/allColors.dart';
import '../styleDrawable/styleDrawable.dart';
import '../utilities/Extentions.dart';
import '../utilities/GradientText.dart';

class FullListFunds extends StatefulWidget {
  FullListFunds(
      {super.key,
      required this.collectionName,
      required this.orderBy,
      required this.title});
  String collectionName, orderBy, title;
  @override
  State<StatefulWidget> createState() =>
      _FullListFundScreen(collectionName, orderBy, title);
}

class _FullListFundScreen extends State<StatefulWidget> with WidgetsBindingObserver{
  String collectionName, orderBy, title;
  String selectedSubCate = "All";
  _FullListFundScreen(this.collectionName, this.orderBy, this.title);
  List<String> _countryNamesList = ["Pakistan", "Sweden"];
  List<String> _regionNamesList = ["Asia", "Africa","Europe","North America","South America","Australia","Antarctica"];
  String _selectedCountry="All";

  Key _refreshKey = UniqueKey();

  void onRefresh() => setState((){
    _refreshKey = UniqueKey();
  });
  @override
  Widget build(BuildContext context) {
    getAdminDetails();
    return Scaffold(
        body: SafeArea(child: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Container(
                decoration: getSplashDecoration(),
                child: Stack(
                  children: [
                    SizedBox(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child:Image.asset("image_back_calls.png",fit: BoxFit.cover,),
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: getSplashDecoration(),
                          child: Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: InkWell(
                                  child: Icon(Icons.arrow_back),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Expanded(
                                child: Center(
                                    child: GradientText(
                                      title,
                                      style: getRobotoRegular().get30(),gradient: getMainGradiant(),
                                    )),
                              )
                            ],
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                          decoration:getListItemBack(),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),child: Text("Currently showing for ",style: getRobotoRegular().get15(),),),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: (){
                                        print("Clicked");
                                        DialogCustom();
                                      },
                                      child:  Container(
                                        decoration: getCountryButtonStrock(),
                                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Text("${_selectedCountry}",style: getRobotoRegular().get20(),),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              getAllCategories(collectionName,orderBy),
                              Divider(height: 1,color: getWhiteColor(),)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Scrollbar(
                            key: _refreshKey,
                            child: PaginateFirestore(
                              itemBuilderType: PaginateBuilderType.listView, //Change types accordingly
                              itemBuilder: (context, documentSnapshots, index) {
                                final data = documentSnapshots[index].data() as Map?;
                                print("StreamGetterCalled1000 $selectedSubCate");
                                return Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: getListItemBack(),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(snapshot: documentSnapshots[index],oderBy: orderBy,collectionName: collectionName,)));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              data![orderBy].toString(),
                                              style: getRobotoRegular()
                                                  .get15()
                                                  .getWeight(),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              MapExtension().getSubHeading(
                                                  data, collectionName, "type"),
                                              style: getRobotoRegular()
                                                  .get12()
                                                  .getWeight(),
                                              textAlign: TextAlign.start,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  readMore(),
                                                  style: getRobotoRegular()
                                                      .get8()
                                                      .getWeight(),
                                                  textAlign: TextAlign.end,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 1,
                                      color: getWhiteColor(),
                                    )
                                  ],
                                );
                              },
                              // orderBy is compulsory to enable pagination
                              query: selectedSubCate.getCurrentStream(collectionName, orderBy),
                              itemsPerPage: 10,
                              // to fetch real-time data
                              isLive: false,
                              options: GetOptions(
                                source: Source.serverAndCache,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
            )
        ),)
    );
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {

    });
  }

  Widget getAllCategories(String collectionName, String orderBy) {
    final db = FirebaseFirestore.instance;
    return SizedBox(
      height: 40,
      child: StreamBuilder(
          stream: db.collection("adminControl").doc("filterList").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var values = snapshot.data!.data() as Map;


            return ListView(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: MapExtension().getAllFilters(values, collectionName).map((valuesMap) =>InkWell(
                onTap: () {
                  setState(() {
                    selectedSubCate = valuesMap["key"];
                    onRefresh();
                  });
                },
                child: Padding(padding: EdgeInsets.all(5),child: Container(padding:EdgeInsets.fromLTRB(5,2,5,2),decoration: valuesMap["key"].toString().checkIfThisCateSelected(selectedSubCate)? getMainBackground().getRounded10():getGmailButtonStrock().getRounded10(),child: Center(child: Text(valuesMap["name"],style: valuesMap["key"].toString().checkIfThisCateSelected(selectedSubCate)?getRobotoRegular().get15().getWeight():getRobotoRegular().get15()),),),),
              )).toList(),
            );
          }
      ),
    );
  }



  DialogCustom() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 500,
              width: 500,
              decoration: getSplashDecoration().getRounded30(),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Text("Choose from country or region",style: getRobotoRegular().get20(),),),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  DefaultTabController(length: 2, child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          Tab(child: Text("Country",style: getRobotoRegular().get15(),),),
                          Tab(child: Text("Regions",style: getRobotoRegular().get15(),),),
                        ],

                      ),
                      SizedBox(
                        height: 300,
                        width: double.maxFinite,
                        child: TabBarView(
                          children: [
                            ListView.builder(
                                itemCount: _countryNamesList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: (){
                                      setState(() {
                                        _selectedCountry=_countryNamesList[index];
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          Text(_countryNamesList[index],style: getRobotoRegular().get15(),),
                                        ]
                                      ),
                                    ),
                                  );
                                }),
                            ListView.builder(
                                itemCount: _regionNamesList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: (){
                                      setState(() {
                                        _selectedCountry=_regionNamesList[index];
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(_regionNamesList[index],style: getRobotoRegular().get15(),),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                      )
                    ],
                  )),
                ],
              ),
            ),
          );
        });
  }


  Future getAdminDetails() async {
    FirebaseFirestore.instance
        .collection("adminControl")
        .doc("countryFilter")
        .get()
        .then((value) => {
      setState(() {
        _countryNamesList = List.from(value.data()!["allCountries"]);
        _countryNamesList = _countryNamesList.getInOrder().removeDublicateString();


      })
    })
        .catchError((onError) => {
          print(onError),
          print("crashFound")
    });
  }

}


