import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppColors.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppImages.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppString.dart';

import '../utils/TishAppColors.dart';

class TishAppBookDetail extends StatefulWidget {
  static String tag = '/TishAppBookDetail';

  @override
  TishAppBookDetailState createState() => TishAppBookDetailState();
}

class TishAppBookDetailState extends State<TishAppBookDetail> {
  var mPeople = 0;
  var mTime = 0;
  var mTishApp = 0;
  var mPeopleList, mTimeList, mTishAppList;
  var now = new DateTime.now();
  var count = 1;
  var formatter = new DateFormat('dd  MMM');
  late String formatted;

  @override
  void initState() {
    super.initState();
    mPeopleList = ["1", "2", "3", "4", "5+"];
    mTishAppList = ["Veg", "Non Veg"];
    mTimeList = [
      "07:00",
      "07:30",
      "08:00",
      "08:30",
      "09:00",
      "09:15",
      "09:30",
      "10:00",
      "10:30",
      "11:00"
    ];
    formatted = formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    //changeStatusColor(TishApp_app_background);
    var width = MediaQuery.of(context).size.width;

    final mPeopleInfo = Container(
      height: width * 0.1,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: mPeopleList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                mPeople = index;
              });
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 16, top: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: mPeople == index
                      ? TishApp_colorPrimary
                      : TishApp_colorPrimary_light),
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text(mPeopleList[index],
                      style: primaryTextStyle(
                          color: mPeople == index
                              ? TishApp_white
                              : TishApp_textColorPrimary))
                  .center(),
            ),
          );
        },
      ),
    );

    final mTimeInfo = GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: mTimeList.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              mTime = index;
            });
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: mTime == index
                    ? TishApp_colorPrimary
                    : TishApp_colorPrimary_light),
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(mTimeList[index],
                    style: primaryTextStyle(
                        color: mTime == index
                            ? TishApp_white
                            : TishApp_textColorPrimary))
                .center(),
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 2.0),
    );

    final mTishAppInfo = Container(
      height: width * 0.1,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: mTishAppList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                mTishApp = index;
              });
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 16, top: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: mTishApp == index
                      ? TishApp_colorPrimary
                      : TishApp_colorPrimary_light),
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text(mTishAppList[index],
                      style: primaryTextStyle(
                          color: mTishApp == index
                              ? TishApp_white
                              : TishApp_textColorPrimary))
                  .center(),
            ),
          );
        },
      ),
    );

    return Scaffold(
      backgroundColor: TishApp_app_background,
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(TishApp_dinner_table,
                            height: width * 0.4, width: width * 0.4),
                      ),
                      SizedBox(height: 16),
                      Text(TishApp_how_many_people, style: boldTextStyle()),
                      SizedBox(height: 4),
                      mPeopleInfo,
                      SizedBox(height: 16),
                      Text(TishApp_reservation_date, style: boldTextStyle()),
                      SizedBox(height: 4),
                      Text(formatted, style: primaryTextStyle()),
                      SizedBox(height: 16),
                      Text(TishApp_set_your_time, style: boldTextStyle()),
                      SizedBox(height: 4),
                      mTimeInfo,
                      SizedBox(height: 16),
                      Text(TishApp_any_TishApp_preference,
                          style: boldTextStyle()),
                      SizedBox(height: 4),
                      mTishAppInfo,
                      SizedBox(height: 24),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: TishApp_colorPrimary,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: defaultBoxShadow()),
                        child: Text(TishApp_book_table,
                                style: primaryTextStyle(color: white))
                            .center(),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
