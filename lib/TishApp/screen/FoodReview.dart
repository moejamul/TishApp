import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/utils/TishAppDataGenerator.dart';
import 'package:TishApp/TishApp/utils/TishAppString.dart';

import '../utils/TishAppColors.dart';
import 'FoodRestaurantsDescription.dart';

class TishAppReview extends StatefulWidget {
  static String tag = '/TishAppReview';

  @override
  TishAppReviewState createState() => TishAppReviewState();
}

class TishAppReviewState extends State<TishAppReview> {
  late List<ReviewModel> mReviewList;

  @override
  void initState() {
    super.initState();
    mReviewList = addReviewData().cast<ReviewModel>();
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
            Container(margin: EdgeInsets.only(left: 16, right: 16), child: null
                //  ListView.builder(
                //     scrollDirection: Axis.vertical,
                //     itemCount: mReviewList.length,
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     itemBuilder: (context, index) {
                //       return Review(mReviewList[index], index);
                //     }
                // ),
                )
          ],
        ),
      ),
    );
  }
}
