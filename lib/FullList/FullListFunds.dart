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

  Key _refreshKey = UniqueKey();

  void onRefresh() => setState((){
    _refreshKey = UniqueKey();
  });
  @override
  Widget build(BuildContext context) {
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
                        getAllCategories(collectionName,orderBy),
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
}


