import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:TishApp/TishApp/Components/BottomShowBar.dart';
import 'package:TishApp/TishApp/screen/FoodAddAddress.dart';

import 'TishAppColors.dart';
import 'TishAppString.dart';
import 'TishAppLocation.dart';

Widget heading(String value) {
  return Container(
    margin: EdgeInsets.all(16),
    child: Text(value.toString().toUpperCase(), style: primaryTextStyle()),
  );
}

BoxDecoration gradientBoxDecoration(
    {double radius = 10,
    Color color = Colors.transparent,
    Color gradientColor2 = TishApp_white,
    Color gradientColor1 = TishApp_white,
    var showShadow = false}) {
  return BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [gradientColor1, gradientColor2]),
    boxShadow: showShadow
        ? [
            BoxShadow(
                color: TishApp_ShadowColor, blurRadius: 10, spreadRadius: 2)
          ]
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

Widget search(BuildContext context) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: TishApp_colorPrimary),
      ),
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.search,
              )),
          Text(TishApp_hint_search_restaurants, style: TextStyle(fontSize: 16)),
        ],
      ),
    ),
  );
}

Widget mAddress(BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: TishApp_colorPrimary_light),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(TishApp_address_dashboard, style: primaryTextStyle()),
        GestureDetector(
          onTap: () {
            mChangeAddress(context);
          },
          child: Text(TishApp_change,
              style: primaryTextStyle(color: TishApp_colorPrimary)),
        ),
      ],
    ),
  );
}

void mChangeAddress(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (_) => BottomShowBar(),
  );
}

Widget mViewAll(BuildContext context, var value, {required Function onTap}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      margin: EdgeInsets.all(16),
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(Icons.arrow_forward,
                      color: TishApp_colorPrimary, size: 18)),
            ),
            TextSpan(
                text: value,
                style: primaryTextStyle(size: 16, color: TishApp_colorPrimary)),
          ],
        ),
      ),
    ),
  );
}

Widget mRating(var value) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
            text: value.toString(),
            style: primaryTextStyle(size: 14, color: TishApp_color_green)),
        WidgetSpan(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(Icons.radio_button_checked,
                color: TishApp_color_green, size: 16),
          ),
        ),
      ],
    ),
  );
}

Padding TishAppEditTextStyle(var hintText) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: TextFormField(
      style: primaryTextStyle(size: 14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(24, 16, 24, 16),
        hintText: hintText,
        filled: true,
        fillColor: TishApp_white,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide:
                const BorderSide(color: TishApp_view_color, width: 1.0)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide:
                const BorderSide(color: TishApp_view_color, width: 1.0)),
      ),
    ),
  );
}

class Quantitybtn extends StatefulWidget {
  @override
  QuantitybtnState createState() => QuantitybtnState();
}

class QuantitybtnState extends State<Quantitybtn> {
  bool visibility = false;
  var count = 1;

  void _changed() {
    setState(() {
      visibility = !visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: visibility,
      child: Container(
        height: width * 0.08,
        alignment: Alignment.center,
        width: width * 0.23,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: TishApp_textColorPrimary)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: width * 0.08,
              height: width * 0.08,
              decoration: BoxDecoration(
                  color: TishApp_textColorPrimary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      topLeft: Radius.circular(4))),
              child: IconButton(
                icon: Icon(Icons.remove, color: TishApp_white, size: 10),
                onPressed: () {
                  setState(() {
                    if (count == 1 || count < 1) {
                      count = 1;
                    } else {
                      count = count - 1;
                    }
                  });
                },
              ),
            ),
            Text("$count",
                style: primaryTextStyle(color: TishApp_textColorPrimary)),
            Container(
              width: width * 0.08,
              height: width * 0.08,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TishApp_textColorPrimary,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(4),
                      topRight: Radius.circular(4))),
              child: IconButton(
                icon: Icon(Icons.add, color: TishApp_white, size: 10),
                onPressed: () {
                  setState(() {
                    count = count + 1;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      replacement: GestureDetector(
        onTap: () {
          _changed();
        },
        child: Container(
          width: width * 0.22,
          height: width * 0.08,
          decoration: BoxDecoration(
              border: Border.all(color: TishApp_textColorPrimary),
              borderRadius: BorderRadius.circular(4)),
          alignment: Alignment.center,
          child: Text(TishApp_add, style: primaryTextStyle()).center(),
        ),
      ),
    );
  }
}

Widget totalRatting(var value) {
  return Row(
    children: <Widget>[
      Icon(Icons.radio_button_checked, color: TishApp_colorAccent, size: 16),
      Icon(Icons.radio_button_checked, color: TishApp_colorAccent, size: 16),
      Icon(Icons.radio_button_checked, color: TishApp_colorAccent, size: 16),
      Icon(Icons.radio_button_unchecked, color: TishApp_colorAccent, size: 16),
      Icon(Icons.radio_button_unchecked, color: TishApp_colorAccent, size: 16),
      SizedBox(width: 4),
      Text(value,
          style: primaryTextStyle(color: TishApp_textColorSecondary, size: 14))
    ],
  );
}

Widget bottomBillDetail(
    BuildContext context, var gColor1, var gColor2, var value,
    {required Function onTap}) {
  return Container(
    height: 100,
    decoration: BoxDecoration(
        boxShadow: defaultBoxShadow(),
        border: Border.all(color: white),
        color: white),
    padding: EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(TishApp_1799, style: primaryTextStyle(size: 18)),
            Text(TishApp_view_bill_details,
                style: primaryTextStyle(color: TishApp_colorPrimary)),
          ],
        ),
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
            decoration: gradientBoxDecoration(
                radius: 50,
                showShadow: true,
                gradientColor1: gColor1,
                gradientColor2: gColor2),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: value,
                      style: primaryTextStyle(size: 16, color: TishApp_white)),
                  WidgetSpan(
                    child: Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(Icons.arrow_forward,
                            color: TishApp_white, size: 18)),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
