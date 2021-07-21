import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/TishApp/screen/FoodAddAddress.dart';
import 'package:prokit_flutter/TishApp/screen/FoodFavourite.dart';
import 'package:prokit_flutter/TishApp/screen/FoodLogin.dart';
import 'package:prokit_flutter/TishApp/screen/FoodOrder.dart';
import 'package:prokit_flutter/TishApp/screen/FoodProfile.dart';
import 'package:prokit_flutter/TishApp/utils/FoodColors.dart';
import 'package:prokit_flutter/TishApp/utils/FoodImages.dart';
import 'package:prokit_flutter/TishApp/utils/FoodString.dart';
import 'package:prokit_flutter/TishApp/utils/FoodWidget.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppLocation.dart';

class FoodSideMenu extends StatefulWidget {
  @override
  FoodSideMenuState createState() => FoodSideMenuState();
}

class FoodSideMenuState extends State<FoodSideMenu> {
  LocalStorage _localStorage = LocalStorage('UserInfo');
  TishAppLocation location = TishAppLocation();
  Widget mOption(
      var gradientColor1, var gradientColor2, var icon, var value, var tags,
      {var pop = false}) {
    return GestureDetector(
      onTap: () {
        finish(context);
        pop
            ? Navigator.pop(context)
            : Navigator.push(
                context, MaterialPageRoute(builder: (context) => tags));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [gradientColor1, gradientColor2]),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(icon, size: 18, color: food_white),
              ),
            ),
            SizedBox(width: 16),
            Text(
              value,
              style: primaryTextStyle(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var mView = Container(
        width: MediaQuery.of(context).size.width,
        height: 0.5,
        color: food_view_color);

    return SafeArea(
      child: SizedBox(
        width: width * 0.85 < 340 ? width * 0.85 : 340,
        height: MediaQuery.of(context).size.height,
        child: Drawer(
          elevation: 8,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  width: width,
                  decoration: gradientBoxDecoration(
                      gradientColor1: food_colorPrimary,
                      gradientColor2: food_colorPrimary,
                      radius: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(food_ic_user1),
                          radius: 40),
                      Text(_localStorage.getItem('name'),
                          style: primaryTextStyle(color: food_white)),
                      Text(_localStorage.getItem('email'),
                          style: primaryTextStyle(color: white))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 24, 16),
                  child: Column(
                    children: <Widget>[
                      mOption(
                          food_color_blue_gradient1,
                          food_color_blue_gradient2,
                          Icons.favorite_border,
                          food_lbl_favourite,
                          FoodFavourite()),
                      mOption(
                          food_color_orange_gradient1,
                          food_color_orange_gradient2,
                          Icons.add,
                          food_lbl_add_address,
                          FoodAddAddress()),
                      mOption(
                          food_color_yellow_gradient1,
                          food_color_yellow_gradient2,
                          Icons.insert_drive_file,
                          food_lbl_orders,
                          FoodOrder()),
                      mOption(
                          food_color_blue_gradient1,
                          food_color_blue_gradient2,
                          Icons.person_outline,
                          food_lbl_profile,
                          FoodProfile()),
                      mOption(
                          food_color_orange_gradient1,
                          food_color_orange_gradient2,
                          Icons.settings_power,
                          food_lbl_logout,
                          FoodLogIn(),
                          pop: true),
                    ],
                  ),
                ),
                mView,
                Container(
                  width: width,
                  padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(food_lbl_quick_searches, style: primaryTextStyle()),
                      Text(food_lbl_cafe,
                          style:
                              primaryTextStyle(color: food_textColorSecondary)),
                      Text(food_hint_search_restaurants,
                          style:
                              primaryTextStyle(color: food_textColorSecondary)),
                      Text(food_lbl_bars,
                          style:
                              primaryTextStyle(color: food_textColorSecondary)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
