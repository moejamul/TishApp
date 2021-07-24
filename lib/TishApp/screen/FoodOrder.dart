import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/TishApp/model/FoodModel.dart';
import 'package:prokit_flutter/TishApp/model/TishAppModel.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppDataGenerator.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppString.dart';
import '../utils/TishAppColors.dart';

class TishAppOrder extends StatefulWidget {
  static String tag = '/TishAppOrder';

  @override
  TishAppOrderState createState() => TishAppOrderState();
}

class TishAppOrderState extends State<TishAppOrder> {
  late List<TishAppDish> mList2;

  @override
  void initState() {
    super.initState();
    mList2 = orderData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TishApp_white,
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            16.height,
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: mList2.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Order(mList2[index], index);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Order extends StatelessWidget {
  late TishAppDish model;

  Order(TishAppDish model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 30,
                  backgroundImage: CachedNetworkImageProvider(model.image),
                ),
                SizedBox(width: 10),
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
        ],
      ),
    );
  }
}
