import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:TishApp/TishApp/utils/TishAppDataGenerator.dart';
import 'package:TishApp/TishApp/utils/TishAppString.dart';
import 'package:TishApp/TishApp/utils/TishAppWidget.dart';

import 'TishAppDashboard.dart';

class TishAppCreateAccount extends StatefulWidget {
  static String tag = '/TishAppCreateAccount';

  @override
  TishAppCreateAccountState createState() => TishAppCreateAccountState();
}

class TishAppCreateAccountState extends State<TishAppCreateAccount> {
  late List<images> mList;

  @override
  void initState() {
    super.initState();
    mList = addUserPhotosData().cast<images>();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: TishApp_white,
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
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TishApp_create_your_account_and_nget_99_money,
                    style: boldTextStyle(size: 24), maxLines: 2),
                Text(TishApp_its_s_super_quick, style: primaryTextStyle()),
              ],
            ).paddingOnly(left: 16, right: 16),
            SizedBox(height: 30.0),
            SizedBox(
              height: width * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 16),
                    child: CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(mList[index].image),
                        radius: 45),
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: TishApp_colorPrimary)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16.0),
                          isDense: true,
                          hintText: TishApp_hint_mobile_no,
                          border: InputBorder.none),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        TishAppDashboard().launch(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(14.0),
                        decoration: gradientBoxDecoration(
                            radius: 50,
                            gradientColor1: TishApp_color_blue_gradient1,
                            gradientColor2: TishApp_color_blue_gradient2),
                        child: Icon(Icons.arrow_forward, color: TishApp_white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
