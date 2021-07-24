import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/TishApp/model/FoodModel.dart';
import 'package:prokit_flutter/TishApp/model/TishAppModel.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppColors.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppDataGenerator.dart';

import 'package:prokit_flutter/TishApp/utils/TishAppString.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppWidget.dart';
import 'package:prokit_flutter/TishApp/utils/dotted_border.dart';

class TishAppCoupon extends StatefulWidget {
  static String tag = '/TishAppCoupon';

  @override
  TishAppCouponState createState() => TishAppCouponState();
}

class TishAppCouponState extends State<TishAppCoupon> {
  late List<Coupons> mList;

  @override
  void initState() {
    super.initState();
    mList = addCouponsData();
  }

  @override
  Widget build(BuildContext context) {
    //changeStatusColor(TishApp_app_background);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: TishApp_app_background,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            onPressed: () {
              finish(context);
            },
            icon: Icon(Icons.arrow_back, color: TishApp_textColorPrimary),
          ),
          Expanded(
            child: SingleChildScrollView(
                child: Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(TishApp_apply_coupons, style: boldTextStyle(size: 24)),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                        color: TishApp_colorPrimary,
                        boxShadow: defaultBoxShadow(),
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14.0),
                              isDense: true,
                              hintText: TishApp_enter_apply_code,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(12.0),
                                decoration: gradientBoxDecoration(
                                    radius: 50,
                                    gradientColor1:
                                        TishApp_color_blue_gradient1,
                                    gradientColor2:
                                        TishApp_color_blue_gradient2),
                                child: Icon(Icons.arrow_forward,
                                    color: TishApp_white),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 0.6,
                        color: TishApp_view_color,
                        width: width * 0.1,
                        margin: EdgeInsets.only(right: 8),
                      ),
                      Text(TishApp_or_use_your_mobile_email.toUpperCase(),
                              style: primaryTextStyle(
                                  size: 14, color: TishApp_textColorSecondary))
                          .center(),
                      Container(
                        height: 0.6,
                        color: TishApp_view_color,
                        width: width * 0.1,
                        margin: EdgeInsets.only(left: 8),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: mList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Coupon(mList[index], index);
                      }),
                ],
              ),
            )),
          )
        ],
      )),
    );
  }
}

// ignore: must_be_immutable
class Coupon extends StatelessWidget {
  late Coupons model;

  Coupon(Coupons model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DottedBorder(
            color: TishApp_colorAccent,
            strokeWidth: 1,
            padding: EdgeInsets.all(2),
            radius: Radius.circular(20),
            child: ClipRRect(
              //borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: width * 0.3,
                color: TishApp_color_light_primary,
                child: Text(model.offer,
                        style: primaryTextStyle(color: TishApp_colorAccent))
                    .center(),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(model.couponsName, style: primaryTextStyle(size: 18)),
          Text(model.info,
                  style: primaryTextStyle(color: TishApp_textColorSecondary))
              .center(),
          Container(
            height: 0.5,
            color: TishApp_view_color,
            width: width,
            margin: EdgeInsets.only(top: 16, bottom: 16),
          )
        ],
      ),
    );
  }
}
