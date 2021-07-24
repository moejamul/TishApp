import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/TishApp/screen/FoodAddAddress.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppColors.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppString.dart';

class BottomShowBar extends StatefulWidget {
  const BottomShowBar({Key? key}) : super(key: key);

  @override
  _BottomShowBarState createState() => _BottomShowBarState();
}

class _BottomShowBarState extends State<BottomShowBar> {
  List<Widget> AddressList = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              color: TishApp_white),
          height: MediaQuery.of(context).size.width * 1.0,
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(TishApp_search_location, style: primaryTextStyle()),
                  IconButton(
                    onPressed: () {
                      finish(context);
                    },
                    icon: Icon(Icons.close, color: TishApp_textColorSecondary),
                  )
                ],
              ),
              SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: defaultBoxShadow(spreadRadius: 3.0)),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: TishApp_white,
                    hintText: TishApp_hint_search_restaurants,
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.only(
                        left: 26.0, bottom: 8.0, top: 8.0, right: 50.0),
                  ),
                ),
                alignment: Alignment.center,
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  Location location = new Location();
                  location.getLocation().then((value) => {
                        AddressList.add(ListTile(
                          title: Text(
                              'Longitude: ${value.longitude} || Latitude: ${value.latitude}'),
                        ))
                      });
                  setState(() {
                    for (var item in AddressList) {
                      print(item);
                    }
                    AddressList = AddressList;
                  });
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.my_location,
                                color: TishApp_colorPrimary, size: 18)),
                      ),
                      TextSpan(
                          text: TishApp_use_current_location,
                          style: TextStyle(
                              fontSize: 16, color: TishApp_colorPrimary)),
                    ],
                  ),
                ),
              ),
              Container(
                  height: 0.5,
                  color: TishApp_view_color,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 16, bottom: 16)),
              GestureDetector(
                onTap: () {
                  TishAppAddAddress().launch(context);
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.add,
                                color: TishApp_colorPrimary, size: 18)),
                      ),
                      TextSpan(
                          text: TishApp_add_address,
                          style: TextStyle(
                              fontSize: 16, color: TishApp_colorPrimary)),
                    ],
                  ),
                ),
              ),
              Container(
                  height: 0.5,
                  color: TishApp_view_color,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 16, bottom: 16)),
              Text(TishApp_recent_location, style: primaryTextStyle()),
              Text(TishApp_location,
                  style: primaryTextStyle(color: TishApp_textColorSecondary)),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView(
                  children: AddressList.map((e) => e).toList(),
                ),
              ) //TODO
            ],
          ),
        ),
      ),
    );
  }
}
