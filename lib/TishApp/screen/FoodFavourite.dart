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

class TishAppFavourite extends StatefulWidget {
  static String tag = '/TishAppFavourite';

  @override
  TishAppFavouriteState createState() => TishAppFavouriteState();
}

class TishAppFavouriteState extends State<TishAppFavourite> {
  late List<TishAppDish> mList1;

  @override
  void initState() {
    super.initState();
    mList1 = addTishAppDishData();
  }

  @override
  Widget build(BuildContext context) {
    //changeStatusColor(TishApp_app_background);
    return Scaffold(
      backgroundColor: TishApp_app_background,
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16),
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75),
                itemCount: mList1.length,
                itemBuilder: (context, index) {
                  return Favourite(mList1[index], index);
                },
              ),
            ),
          )
        ],
      )),
    );
  }
}

// ignore: must_be_immutable
class Favourite extends StatelessWidget {
  late TishAppDish model;

  Favourite(TishAppDish model, int pos) {
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
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            child: CachedNetworkImage(
              imageUrl: model.image,
              height: width * 0.3,
              width: width,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model.name, style: primaryTextStyle(), maxLines: 1),
                Text(model.type,
                    style: primaryTextStyle(color: TishApp_textColorSecondary)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text(model.price), Quantitybtn()],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
