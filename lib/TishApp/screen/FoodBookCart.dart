import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:TishApp/TishApp/model/FoodModel.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:TishApp/TishApp/utils/TishAppDataGenerator.dart';
import 'package:TishApp/TishApp/utils/TishAppString.dart';
import 'package:TishApp/TishApp/utils/TishAppWidget.dart';
import 'package:TishApp/TishApp/utils/dotted_border.dart';

import '../utils/TishAppColors.dart';
import 'FoodAddressConfirmation.dart';
import 'FoodCoupon.dart';
import 'FoodPayment.dart';

class TishAppBookCart extends StatefulWidget {
  static String tag = '/BookCart';

  @override
  TishAppBookCartState createState() => TishAppBookCartState();
}

class TishAppBookCartState extends State<TishAppBookCart> {
  late List<TishAppDish> mList2;

  @override
  void initState() {
    super.initState();
    mList2 = orderData();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: TishApp_white,
      bottomNavigationBar: Container(
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: TishApp_app_background,
              padding: EdgeInsets.all(14),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(Icons.location_on, size: 30),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(TishApp_Sweet_home, style: primaryTextStyle()),
                            GestureDetector(
                              onTap: () {
                                TishAppAddressConfirmation().launch(context);
                              },
                              child: Text(TishApp_change,
                                  style: primaryTextStyle(
                                      color: TishApp_colorPrimary)),
                            ),
                          ],
                        ),
                        Text(TishApp_address_dashboard,
                            style: primaryTextStyle()),
                        Text(TishApp_delivery_time_36_min,
                            style: primaryTextStyle(
                                size: 14, color: TishApp_textColorSecondary)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            bottomBillDetail(context, TishApp_color_blue_gradient1,
                TishApp_color_blue_gradient2, TishApp_make_payment, onTap: () {
              TishAppPayment().launch(context);
            })
          ],
        ),
      ),
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
                margin: EdgeInsets.only(left: 16, right: 16, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(TishApp_your_cart, style: boldTextStyle(size: 24)),
                    SizedBox(height: 16),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: mList2.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Cart(mList2[index], index);
                        }),
                    Divider(color: TishApp_view_color, height: 0.5),
                    SizedBox(height: 8),
                    Text(TishApp_restaurants_bill.toUpperCase(),
                        style: boldTextStyle()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(TishApp_sub_total, style: primaryTextStyle()),
                        Text(TishApp_1799, style: primaryTextStyle()),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(TishApp_coupon_discount,
                            style: primaryTextStyle()),
                        Text(TishApp_70,
                            style:
                                primaryTextStyle(color: TishApp_colorAccent)),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(TishApp_gst, style: primaryTextStyle()),
                        Text(TishApp_70, style: primaryTextStyle()),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DottedBorder(
                      color: TishApp_colorAccent,
                      strokeWidth: 1,
                      padding: EdgeInsets.all(16),
                      radius: Radius.circular(16),
                      child: ClipRRect(
                        child: Container(
                            width: width,
                            padding: EdgeInsets.all(4),
                            color: TishApp_color_light_primary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                          TishApp_you_have_saved_30_on_the_bill,
                                          style: primaryTextStyle())
                                      .center(),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        TishAppCoupon().launch(context);
                                      },
                                      child: Text(TishApp_edit,
                                              style: primaryTextStyle())
                                          .center(),
                                    ))
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

// ignore: must_be_immutable
class Cart extends StatelessWidget {
  late TishAppDish model;

  Cart(TishAppDish model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 30,
                  backgroundImage: CachedNetworkImageProvider(
                    model.image,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(model.name, style: primaryTextStyle()),
                      Text(model.price, style: primaryTextStyle()),
                      //text("sd",textColor: TishApp_textColorSecondary),
                    ],
                  ),
                )
              ],
            ),
          ),
          Quantitybtn()
        ],
      ),
    );
  }
}
