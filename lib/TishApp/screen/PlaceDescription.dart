import 'package:TishApp/TishApp/Components/Widgets.dart';
import 'package:TishApp/TishApp/utils/TishAppWidget.dart';
import 'package:TishApp/TishApp/viewmodel/PlaceViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:TishApp/TishApp/model/FoodModel.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:TishApp/TishApp/utils/TishAppDataGenerator.dart';
import 'package:TishApp/TishApp/utils/TishAppImages.dart';
import 'package:TishApp/TishApp/utils/TishAppString.dart';
import 'package:provider/provider.dart';

import 'FoodBookCart.dart';

class TishAppDescription extends StatefulWidget {
  Place place;
  static String tag = '/TishAppDescription';

  TishAppDescription({required this.place}) {}

  @override
  TishAppDescriptionState createState() => TishAppDescriptionState();
}

class TishAppDescriptionState extends State<TishAppDescription> {
  double rating = 0;
  @override
  void initState() {
    super.initState();

    for (var item in this.widget.place.reviews) {
      rating += double.parse(item.Rating.toString());
    }
    if (rating != 0) rating /= this.widget.place.reviews.length;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double expandHeight = MediaQuery.of(context).size.height * 0.33;
    var width = MediaQuery.of(context).size.width;

    Widget mHeading(var value) {
      return Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text(
            value.toString().toUpperCase(),
            style: primaryTextStyle(),
          ));
    }

    Widget BadgeWidget(var value, var iconColor, var imagePath) {
      return Row(
        children: <Widget>[
          // Image.asset('images/imageTest.jpeg', width: 18, height: 18),
          Image.network(imagePath, width: 18, height: 18),
          SizedBox(width: 8),
          Text(value, style: primaryTextStyle()),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: TishApp_app_background,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: expandHeight,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                pinned: true,
                centerTitle: true,
                titleSpacing: 0,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: white),
                    onPressed: () {
                      finish(context);
                    }),
                // backgroundColor:
                //     innerBoxIsScrolled ? TishApp_white : TishApp_colorPrimary,
                actionsIconTheme: IconThemeData(opacity: 0.0),
                title: Container(
                  height: 60,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(this.widget.place.Name),
                        IconButton(
                            onPressed: () {
                              print("Pressed");
                            },
                            icon: Icon(Icons.star_border))
                      ],
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    height: expandHeight,
                    child: Image.asset(
                      'images/imageTest.jpeg',
                      height: expandHeight,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: width,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          boxShadow: defaultBoxShadow(), color: white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(this.widget.place.Name,
                                  style: primaryTextStyle(size: 18)),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: this.widget.place.averageReviews == 0
                                      ? Colors.grey
                                      : Colors.green[700],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                      top: 2.0,
                                      bottom: 2.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '${this.widget.place.averageReviews == 0 ? '-' : this.widget.place.averageReviews}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          totalRatting(this.widget.place.averageReviews),
                          SizedBox(height: 8),
                          Divider(height: 0.5, color: TishApp_view_color),
                          SizedBox(height: 8),
                          SizedBox(
                            height: 20,
                            child: this.widget.place.earnedBadges.length != 0
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        this.widget.place.earnedBadges.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0, right: 12.0),
                                        child: BadgeWidget(
                                            this
                                                .widget
                                                .place
                                                .earnedBadges
                                                .elementAt(index)
                                                .title
                                                .toString(),
                                            TishApp_view_color,
                                            this
                                                .widget
                                                .place
                                                .earnedBadges
                                                .elementAt(index)
                                                .path
                                                .toString()),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text('No Badges Earned Yet'),
                                  ),
                            // child: FutureBuilder(
                            //   future: ,
                            //   builder: (context, snapshot) {
                            //     return ListView.builder(
                            //       scrollDirection: Axis.horizontal,
                            //       itemCount: 4,
                            //       itemBuilder: (context, index) {
                            //         return Padding(
                            //           padding: const EdgeInsets.only(
                            //               left: 12.0, right: 12.0),
                            //           child: BadgeWidget(
                            //               "Badge $index", TishApp_view_color),
                            //         );
                            //       },
                            //     );
                            //   },
                            // ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: this.widget.place.medias.length != 0
                          ? ListView.builder(
                              itemCount: this.widget.place.medias.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedNetworkImage(
                                        imageUrl: this
                                            .widget
                                            .place
                                            .medias[index]
                                            .toString(),
                                        placeholder: placeholderWidgetFn()));
                              })
                          : Center(child: Text("No images available")),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            boxShadow: defaultBoxShadow(), color: white),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      TishApp_delivery_by_yumTishApp_with_online_tracking,
                                      style: boldTextStyle()),
                                  Text(TishApp_est_TishApp_delivery_time,
                                      style: primaryTextStyle()),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                          boxShadow: defaultBoxShadow(), color: white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          mHeading("Comments"),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 12.0, left: 12.0, right: 12.0),
                            child: Row(
                              children: [
                                CircleAvatar(),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextField(
                                    maxLines: null,
                                    maxLength: 255,
                                    decoration:
                                        InputDecoration(hintText: 'Comment'),
                                  ),
                                ))
                              ],
                            ),
                          ),
                          this.widget.place.reviews.length != 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: this.widget.place.reviews.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12.0),
                                                      child: Text(
                                                        this
                                                            .widget
                                                            .place
                                                            .reviews
                                                            .elementAt(index)
                                                            .user
                                                            .Username,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Row(
                                                    children: [
                                                      totalRatting(this
                                                          .widget
                                                          .place
                                                          .reviews
                                                          .elementAt(index)
                                                          .Rating),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Text(this
                                                            .widget
                                                            .place
                                                            .reviews
                                                            .elementAt(index)
                                                            .Updated_At
                                                            .toString()
                                                            .split("T")[0]),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12.0),
                                                  child: Container(
                                                    width: width - 24,
                                                    child: Text(
                                                      this
                                                          .widget
                                                          .place
                                                          .reviews
                                                          .elementAt(index)
                                                          .Message
                                                          .toString()
                                                          .trim(),
                                                      maxLines: 5,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                              : Center(child: Text("No Reviews Available"))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   right: 0,
              //   left: 0,
              //   child: Container(
              //     alignment: Alignment.bottomCenter,
              //     //height: width * 0.38,
              //     child: Column(
              //       children: <Widget>[
              //         GestureDetector(
              //           onTap: () {
              //             showDialog(
              //               context: context,
              //               builder: (BuildContext context) => CustomDialog(),
              //             );
              //           },
              //           child: Container(
              //             margin: EdgeInsets.only(bottom: 10),
              //             padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              //             decoration: gradientBoxDecoration(
              //                 gradientColor1: TishApp_color_blue_gradient1,
              //                 gradientColor2: TishApp_color_blue_gradient2,
              //                 radius: 40),
              //             child: Text(TishApp_view_menu,
              //                 style: primaryTextStyle(color: white)),
              //           ),
              //         ),
              //         bottomBillDetail(
              //             context,
              //             TishApp_color_green_gradient1,
              //             TishApp_color_green_gradient2,
              //             TishApp_order_now, onTap: () {
              //           TishAppBookCart().launch(context);
              //         }),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemList extends StatelessWidget {
  late TishAppDish model;

  ItemList(TishAppDish model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(right: 16, left: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Image.asset(
              'images/imageTest.jpeg',
              width: width * 0.2,
              height: width * 0.2,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                          child: Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Image.asset('images/imageTest.jpeg',
                                  color: TishApp_colorAccent,
                                  width: 16,
                                  height: 16))),
                      TextSpan(
                          text: model.name,
                          style: primaryTextStyle(
                              size: 16, color: TishApp_textColorPrimary)),
                    ],
                  ),
                ),
                Text(model.price, style: primaryTextStyle()),
              ],
            ),
          ),
          Quantitybtn()
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemGrid extends StatelessWidget {
  late TishAppDish model;

  ItemGrid(TishAppDish model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(boxShadow: defaultBoxShadow(), color: white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            child: Image.asset(
              'images/imageTest.jpeg',
              width: width,
              height: width * 0.3,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model.name, style: primaryTextStyle(), maxLines: 1),
                Text(model.type,
                    style: primaryTextStyle(
                        color: TishApp_textColorSecondary, size: 14)),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(model.price, style: primaryTextStyle()),
                    Quantitybtn(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

dialogContent(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          )
        ],
      ),
      padding: EdgeInsets.all(24),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Snakes", style: primaryTextStyle()),
                Text("10/-", style: primaryTextStyle()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Pizza & Pasta", style: primaryTextStyle()),
                Text("40/-", style: primaryTextStyle()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Burger/-", style: primaryTextStyle()),
                Text("20/-", style: primaryTextStyle()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Fast TishApp", style: primaryTextStyle()),
                Text("12/-", style: primaryTextStyle()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Italian", style: primaryTextStyle()),
                Text("60/-", style: primaryTextStyle()),
              ],
            )
          ],
        ),
      ));
}
