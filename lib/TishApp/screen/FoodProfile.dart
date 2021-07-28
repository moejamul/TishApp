import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:TishApp/TishApp/utils/TishAppImages.dart';
import 'package:TishApp/TishApp/utils/TishAppString.dart';
import 'package:TishApp/TishApp/utils/TishAppWidget.dart';

class TishAppProfile extends StatefulWidget {
  static String tag = '/TishAppProfile';

  @override
  TishAppProfileState createState() => TishAppProfileState();
}

class TishAppProfileState extends State<TishAppProfile> {
  @override
  Widget build(BuildContext context) {
    //changeStatusColor(TishApp_app_background);
    String? _selectedLocation = 'Female';
    return Scaffold(
      backgroundColor: TishApp_white,
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    16.height,
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(TishApp_ic_user1),
                            radius: 50),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: TishApp_white),
                          width: 30,
                          height: 30,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(4),
                            child: Icon(Icons.edit, size: 20),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: TishAppEditTextStyle(
                                      TishApp_hint_first_name)),
                              SizedBox(width: 16),
                              Expanded(
                                  child: TishAppEditTextStyle(
                                      TishApp_hint_last_name))
                            ],
                          ),
                          SizedBox(height: 16),
                          Container(
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
                              items: <String>['Female', 'Male']
                                  .map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: primaryTextStyle(size: 12)),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedLocation = newValue;
                                });
                              },
                            )),
                          ),
                          SizedBox(height: 16),
                          TishAppEditTextStyle(TishApp_hint_mobile_no),
                          SizedBox(height: 16),
                          TishAppEditTextStyle(TishApp_hint_email),
                          SizedBox(height: 16),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: TishApp_colorPrimary,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: defaultBoxShadow()),
                            child: Text(TishApp_save_profile.toUpperCase(),
                                style: primaryTextStyle(color: white)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
