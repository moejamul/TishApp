import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppColors.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppString.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppWidget.dart';

import '../utils/TishAppColors.dart';

class TishAppAddAddress extends StatefulWidget {
  static String tag = '/TishAppAddAddress';

  @override
  TishAppAddAddressState createState() => TishAppAddAddressState();
}

class TishAppAddAddressState extends State<TishAppAddAddress> {
  String? _selectedLocation = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TishApp_white,
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      TishAppEditTextStyle(TishApp_hint_full_name),
                      SizedBox(height: 16),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child:
                                  TishAppEditTextStyle(TishApp_hint_pin_code)),
                          SizedBox(width: 16),
                          Expanded(
                              child: TishAppEditTextStyle(TishApp_hint_city)),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: TishAppEditTextStyle(TishApp_hint_state)),
                          SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: TishApp_view_color,
                                    width: 1,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                value: _selectedLocation,
                                items: <String>['Home', 'Work']
                                    .map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: primaryTextStyle(
                                            size: 16,
                                            color: TishApp_textColorSecondary)),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedLocation = newValue;
                                  });
                                },
                              )),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      TishAppEditTextStyle(TishApp_hint_address),
                      SizedBox(height: 16),
                      TishAppEditTextStyle(TishApp_hint_mobile_no),
                      SizedBox(height: 16),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: TishApp_colorPrimary,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: defaultBoxShadow()),
                        child: Text(TishApp_add_address,
                                style: primaryTextStyle(color: TishApp_white))
                            .center(),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
