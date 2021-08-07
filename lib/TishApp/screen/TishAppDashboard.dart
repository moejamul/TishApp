import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:TishApp/TishApp/Components/SideMenu.dart';
import 'package:TishApp/TishApp/model/FoodModel.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:TishApp/TishApp/utils/TishAppDataGenerator.dart';
import 'package:TishApp/TishApp/utils/TishAppImages.dart';
import 'package:TishApp/TishApp/utils/TishAppString.dart';
import 'package:TishApp/TishApp/utils/TishAppWidget.dart';
import 'package:TishApp/TishApp/viewmodel/PlaceViewModel.dart';
import 'package:provider/provider.dart';

import 'FoodBookCart.dart';
import 'FoodDescription.dart';
import 'FoodViewRestaurants.dart';

class Collection extends StatelessWidget {
  late DashboardCollections model;

  Collection(DashboardCollections model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        TishAppViewRestaurants().launch(context);
      },
      child: Container(
        margin: EdgeInsets.only(left: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: model.image,
                width: width * 0.5,
                height: 250,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(model.name,
                      style: primaryTextStyle(
                          size: 20, fontFamily: 'Andina', color: white)),
                  SizedBox(height: 4),
                  Text(model.info,
                      style: primaryTextStyle(size: 14, color: TishApp_white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TishAppDashboard extends StatefulWidget {
  static String tag = '/TishAppDashboard';

  @override
  TishAppDashboardState createState() => TishAppDashboardState();
}

// ignore: must_be_immutable
class TishAppDashboardState extends State<TishAppDashboard> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late List<DashboardCollections> mCollectionList;
  List<Place> mBakeryList = [];
  late List<Restaurants> mDeliveryList;
  late List<Restaurants> mDineOutList;
  late List<DashboardCollections> mExperienceList;
  late List<Restaurants> mCafeList;

  @override
  Widget build(BuildContext context) {
    Widget topGradient(var gradientColor1, var gradientColor2, var icon,
        var heading, var subHeading,
        {required String redirectTo}) {
      var width = MediaQuery.of(context).size.width;
      return Expanded(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, redirectTo);
          },
          child: Container(
            decoration: gradientBoxDecoration(
                showShadow: true,
                gradientColor1: gradientColor1,
                gradientColor2: gradientColor2),
            padding: EdgeInsets.all(10),
            child: (Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(icon,
                    color: TishApp_white,
                    width: double.parse((width * 0.06).toString()),
                    height: double.parse((width * 0.06).toString())),
                Text(heading, style: primaryTextStyle(color: TishApp_white)),
                Text(
                  subHeading,
                  style: primaryTextStyle(color: TishApp_white, size: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
          ),
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: TishAppSideMenu(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: Center(
            child: Text(TishApp_app_name,
                style: boldTextStyle(size: 18, color: Colors.white))),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              TishAppBookCart().launch(context);
            },
          ),
        ],
      ),
      backgroundColor: TishApp_app_background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  color: TishApp_white,
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: defaultBoxShadow(), color: white),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: <Widget>[
                                mAddress(context),
                                SizedBox(height: 16),
                                // search(context),
                                // SizedBox(height: 16),
                                Row(
                                  children: <Widget>[
                                    topGradient(
                                        TishApp_color_blue_gradient1,
                                        TishApp_color_blue_gradient2,
                                        TishApp_cloche,
                                        'View Restaurants',
                                        'Search for your favorite restaurant',
                                        redirectTo: '/TishAppCart'),
                                    SizedBox(width: 10),
                                    topGradient(
                                        TishApp_color_orange_gradient1,
                                        TishApp_color_orange_gradient2,
                                        TishApp_ic_table,
                                        TishApp_book_a_table,
                                        TishApp_may_take_upto_3_mins,
                                        redirectTo: '/viewRestaurants'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: defaultBoxShadow(), color: white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                heading(TishApp_get_inspired_by_collections),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                              0.4 >
                                          265
                                      ? MediaQuery.of(context).size.width * 0.4
                                      : 265,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: mBakeryList.length,
                                    padding: EdgeInsets.only(right: 16),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Item(mBakeryList[index]);
                                    },
                                  ),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: defaultBoxShadow(), color: white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                heading(TishApp_cake_ice_cream_and_bakery),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                                0.4 >
                                            265
                                        ? MediaQuery.of(context).size.width *
                                            0.4
                                        : 265,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      padding:
                                          EdgeInsets.only(bottom: 4, right: 16),
                                      shrinkWrap: true,
                                      itemCount: mBakeryList.length,
                                      itemBuilder: (context, index) {
                                        Place p = mBakeryList[index];
                                        return Item(p);
                                      },
                                    )),
                                mViewAll(context, 'View All Bakeries',
                                    onTap: () {
                                  TishAppViewRestaurants().launch(context);
                                }),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: defaultBoxShadow(), color: white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                heading(TishApp_delivery_restaurants),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                              0.4 >
                                          265
                                      ? MediaQuery.of(context).size.width * 0.4
                                      : 265,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding:
                                        EdgeInsets.only(bottom: 4, right: 16),
                                    itemCount: mBakeryList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Item(mBakeryList[index]);
                                    },
                                  ),
                                ),
                                mViewAll(context, TishApp_view_all_restaurants,
                                    onTap: () {
                                  TishAppViewRestaurants().launch(context);
                                }),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: defaultBoxShadow(), color: white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                heading(TishApp_dine_out_restaurants),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                              0.4 >
                                          265
                                      ? MediaQuery.of(context).size.width * 0.4
                                      : 265,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: mBakeryList.length,
                                    padding:
                                        EdgeInsets.only(bottom: 4, right: 16),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Item(mBakeryList[index]);
                                    },
                                  ),
                                ),
                                mViewAll(context, TishApp_view_all_restaurants,
                                    onTap: () {
                                  TishAppViewRestaurants().launch(context);
                                }),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: defaultBoxShadow(), color: white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                heading(
                                    TishApp_experience_your_favourite_cuisine),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                              0.4 >
                                          265
                                      ? MediaQuery.of(context).size.width * 0.4
                                      : 265,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.only(right: 16),
                                    itemCount: mExperienceList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Collection(
                                          mExperienceList[index], index);
                                    },
                                  ),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: defaultBoxShadow(), color: white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                heading(TishApp_cafe),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                              0.4 >
                                          265
                                      ? MediaQuery.of(context).size.width * 0.4
                                      : 265,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding:
                                        EdgeInsets.only(bottom: 4, right: 16),
                                    itemCount: mBakeryList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Item(mBakeryList[index]);
                                    },
                                  ),
                                ),
                                mViewAll(context, TishApp_view_all_restaurants,
                                    onTap: () {
                                  TishAppViewRestaurants().launch(context);
                                }),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getPlace() async {
    await Provider.of<PlaceViewModel>(context, listen: false)
        .fetchPlaceData('4');
    var _place = Provider.of<PlaceViewModel>(context, listen: false).place;
    for (int i = 0; i < 5; i++) {
      mBakeryList.add(_place);
    }
    setState(() {
      mBakeryList = mBakeryList;
    });
  }

  @override
  void initState() {
    super.initState();
    getPlace();
    mCollectionList = addCollectionData();

    mDeliveryList = addDeliveryRestaurantsData();
    mDineOutList = addDineOutRestaurantsData();
    mExperienceList = addCuisineData();
    mCafeList = addCafeData();
  }
}

// ignore: must_be_immutable
class Item extends StatelessWidget {
  late Place model;

  Item(Place model) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        TishAppDescription().launch(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4 > 265
            ? MediaQuery.of(context).size.width * 0.4
            : 265,
        margin: EdgeInsets.only(left: 16),
        decoration: BoxDecoration(boxShadow: defaultBoxShadow(), color: white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              child: Stack(
                children: <Widget>[
                  // CachedNetworkImage(
                  //   imageUrl:
                  //       'data:image/webp;base64,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',
                  //   height: MediaQuery.of(context).size.width * 0.3 > 198.3
                  //       ? MediaQuery.of(context).size.width * 0.3
                  //       : 198.3,
                  //   width: MediaQuery.of(context).size.width * 0.4 > 265
                  //       ? MediaQuery.of(context).size.width * 0.4
                  //       : 265,
                  //   fit: BoxFit.cover,
                  // ),
                  Container(
                      height: MediaQuery.of(context).size.width * 0.3 > 198.3
                          ? MediaQuery.of(context).size.width * 0.3
                          : 198.3,
                      width: MediaQuery.of(context).size.width * 0.4 > 265
                          ? MediaQuery.of(context).size.width * 0.4
                          : 265,
                      child: Placeholder()),
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.favorite_border,
                        color: TishApp_white, size: 18),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(model.title.toString(),
                      style: primaryTextStyle(), maxLines: 2),
                  Row(
                    children: <Widget>[
                      mRating(model.id.toString()),
                      Text(
                        model.userId.toString(),
                        style: primaryTextStyle(
                            color: TishApp_textColorSecondary, size: 14),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
