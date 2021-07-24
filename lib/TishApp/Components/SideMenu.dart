import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/TishApp/screen/FoodAddAddress.dart';
import 'package:prokit_flutter/TishApp/screen/FoodFavourite.dart';
import 'package:prokit_flutter/TishApp/screen/FoodOrder.dart';
import 'package:prokit_flutter/TishApp/screen/TishAppLogin.dart';
import 'package:prokit_flutter/TishApp/screen/TishAppProfilePage.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppColors.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppImages.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppString.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppWidget.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppLocation.dart';
import 'package:prokit_flutter/TishApp/viewmodel/authViewModel.dart';
import 'package:provider/provider.dart';

class TishAppSideMenu extends StatefulWidget {
  @override
  TishAppSideMenuState createState() => TishAppSideMenuState();
}

class TishAppSideMenuState extends State<TishAppSideMenu> {
  LocalStorage _localStorage = LocalStorage('UserInfo');
  TishAppLocation location = TishAppLocation();
  Widget mOption(
      var gradientColor1, var gradientColor2, var icon, var value, var tags,
      {var pop = false}) {
    return GestureDetector(
      onTap: () async {
        if (!pop) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => tags));
        } else {
          await Provider.of<AuthViewModel>(context, listen: false).Logout();
          if (Provider.of<AuthViewModel>(context, listen: false)
              .logout_response) {
            print('out');
            Navigator.pushReplacementNamed(context, '/login');
          }
        }
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
                child: Icon(icon, size: 18, color: TishApp_white),
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
        color: TishApp_view_color);

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
                      gradientColor1: TishApp_colorPrimary,
                      gradientColor2: TishApp_colorPrimary,
                      radius: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(TishApp_ic_user1),
                          radius: 40),
                      Text(_localStorage.getItem('name'),
                          style: primaryTextStyle(color: TishApp_white)),
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
                          TishApp_color_blue_gradient1,
                          TishApp_color_blue_gradient2,
                          Icons.favorite_border,
                          TishApp_favourite,
                          TishAppFavourite()),
                      mOption(
                          TishApp_color_orange_gradient1,
                          TishApp_color_orange_gradient2,
                          Icons.add,
                          TishApp_add_address,
                          TishAppAddAddress()),
                      mOption(
                          TishApp_color_yellow_gradient1,
                          TishApp_color_yellow_gradient2,
                          Icons.insert_drive_file,
                          TishApp_orders,
                          TishAppOrder()),
                      mOption(
                          TishApp_color_blue_gradient1,
                          TishApp_color_blue_gradient2,
                          Icons.person_outline,
                          TishApp_profile,
                          ProfilePage()),
                      mOption(
                          TishApp_color_orange_gradient1,
                          TishApp_color_orange_gradient2,
                          Icons.settings_power,
                          TishApp_logout,
                          LoginPage(),
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
                      Text(TishApp_quick_searches, style: primaryTextStyle()),
                      Text(TishApp_cafe,
                          style: primaryTextStyle(
                              color: TishApp_textColorSecondary)),
                      Text(TishApp_hint_search_restaurants,
                          style: primaryTextStyle(
                              color: TishApp_textColorSecondary)),
                      Text(TishApp_bars,
                          style: primaryTextStyle(
                              color: TishApp_textColorSecondary)),
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
