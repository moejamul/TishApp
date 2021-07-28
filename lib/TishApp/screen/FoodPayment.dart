import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:TishApp/TishApp/utils/TishAppImages.dart';
import 'package:TishApp/TishApp/utils/TishAppString.dart';
import 'package:TishApp/TishApp/utils/TishAppWidget.dart';

import 'FoodDeliveryInfo.dart';

class TishAppPayment extends StatefulWidget {
  static String tag = '/TishAppPayment';

  @override
  TishAppPaymentState createState() => TishAppPaymentState();
}

class TishAppPaymentState extends State<TishAppPayment> {
  @override
  Widget build(BuildContext context) {
    //changeStatusColor(TishApp_app_background);
    var width = MediaQuery.of(context).size.width;

    Widget mPaymentOption(var icon, var heading, var value, var valueColor) {
      return Container(
        decoration: BoxDecoration(boxShadow: defaultBoxShadow(), color: white),
        padding: EdgeInsets.all(4),
        child: Column(
          children: <Widget>[
            SizedBox(height: 8),
            SvgPicture.asset(icon, width: width * 0.1, height: width * 0.1),
            SizedBox(height: 8),
            Text(heading, style: primaryTextStyle()),
            Text(value, style: primaryTextStyle(color: valueColor)),
          ],
        ),
      );
    }

    Widget mNetBankingOption(var icon, var value) {
      return Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(TishApp_ic_fab_back, width: width * 0.17),
              Container(
                child: CachedNetworkImage(
                    imageUrl: icon, width: width * 0.08, fit: BoxFit.contain),
              )
            ],
          ),
          SizedBox(height: 4),
          Text(value, style: primaryTextStyle())
        ],
      );
    }

    return Scaffold(
      backgroundColor: TishApp_app_background,
      bottomNavigationBar: bottomBillDetail(
          context,
          TishApp_color_blue_gradient1,
          TishApp_color_blue_gradient2,
          TishApp_delivery_info, onTap: () {
        TishAppDeliveryInfo().launch(context);
      }),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: width,
              alignment: Alignment.topLeft,
              color: TishApp_white,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  finish(context);
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          boxShadow: defaultBoxShadow(), color: white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(TishApp_payment, style: boldTextStyle(size: 18)),
                          SizedBox(height: 8),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: mPaymentOption(null, null,
                                      TishApp_1799, TishApp_color_red)),
                              SizedBox(width: 16),
                              Expanded(
                                  flex: 1,
                                  child: mPaymentOption(
                                      TishApp_whatsapp,
                                      TishApp_whatsapp_payment,
                                      TishApp_connect,
                                      TishApp_textColorPrimary)),
                            ],
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          boxShadow: defaultBoxShadow(), color: white),
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(TishApp_credit_cards.toUpperCase(),
                              style: primaryTextStyle()),
                          SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: CachedNetworkImage(
                                        imageUrl: TishApp_ic_hdfc,
                                        height: width * 0.05,
                                        width: width * 0.05),
                                  ),
                                ),
                                TextSpan(
                                    text: TishApp__42xx_4523_xxxx_55xx,
                                    style: primaryTextStyle(
                                        size: 16,
                                        color: TishApp_textColorPrimary)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          boxShadow: defaultBoxShadow(), color: white),
                      margin: EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(TishApp_netbanking.toUpperCase(),
                                  style: primaryTextStyle()),
                              mViewAll(context, TishApp_view_all_banks,
                                  onTap: () {
                                //
                              }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              mNetBankingOption(TishApp_ic_hdfc, TishApp_hdfc),
                              mNetBankingOption(TishApp_ic_rbs, TishApp_rbs),
                              mNetBankingOption(TishApp_ic_citi, TishApp_citi),
                              mNetBankingOption(
                                  TishApp_ic_america, TishApp_america),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
