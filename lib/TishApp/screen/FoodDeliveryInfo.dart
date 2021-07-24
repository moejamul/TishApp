import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppColors.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppImages.dart';
import 'package:prokit_flutter/TishApp/utils/TishAppString.dart';

class TishAppDeliveryInfo extends StatefulWidget {
  static String tag = '/TishAppDeliveryInfo';

  @override
  TishAppDeliveryInfoState createState() => TishAppDeliveryInfoState();
}

class TishAppDeliveryInfoState extends State<TishAppDeliveryInfo> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: TishApp_view_color,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            MapSample(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 400,
                decoration:
                    BoxDecoration(boxShadow: defaultBoxShadow(), color: white),
                margin: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Container(
                      transform: Matrix4.translationValues(0.0, -24.0, 0.0),
                      child: Stack(
                        children: <Widget>[
                          Image.asset(TishApp_ic_fab_back,
                              width: width * 0.15, height: width * 0.15),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              TishApp_ic_delivery,
                              width: width * 0.08,
                              height: width * 0.08,
                              alignment: Alignment.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(TishApp_est_TishApp_delivery_time.toUpperCase(),
                        style: primaryTextStyle()),
                    SizedBox(height: 10),
                    Text(TishApp__30_min, style: primaryTextStyle(size: 18)),
                    Text(TishApp_duration,
                        style: primaryTextStyle(
                            color: TishApp_textColorSecondary)),
                    SizedBox(height: 10),
                    Text(TishApp_3_4_km_away,
                        style: primaryTextStyle(size: 18)),
                    Text(TishApp_distance,
                        style: primaryTextStyle(
                            color: TishApp_textColorSecondary)),
                    SizedBox(height: 10),
                    Text(TishApp__4_5_km_hr, style: primaryTextStyle(size: 18)),
                    Text(TishApp_avg_speed,
                        style: primaryTextStyle(
                            color: TishApp_textColorSecondary)),
                    Container(
                      height: 0.5,
                      color: TishApp_view_color,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 10, bottom: 4),
                    ),
                    Text(TishApp_rate_this_delivery,
                        style: primaryTextStyle(color: TishApp_colorPrimary)),
                    SizedBox(height: 8),
                    // RatingBar(
                    //   initialRating: 5,
                    //   minRating: 1,
                    //   itemSize: 40,
                    //   direction: Axis.horizontal,
                    //   itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    //   itemBuilder: (context, _) => Icon(
                    //     Icons.star,
                    //     color: TishApp_color_yellow,
                    //     size: 30,
                    //   ),
                    //   onRatingUpdate: (rating) {},
                    // ),
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

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('Restaurant'),
        icon: Icon(Icons.restaurant),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
