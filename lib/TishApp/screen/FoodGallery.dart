import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:TishApp/TishApp/utils/TishAppDataGenerator.dart';
import 'package:TishApp/TishApp/utils/TishAppString.dart';

import '../utils/TishAppColors.dart';

class TishAppGallery extends StatefulWidget {
  static String tag = '/TishAppGallery';

  @override
  TishAppGalleryState createState() => TishAppGalleryState();
}

class TishAppGalleryState extends State<TishAppGallery> {
  late List<images> mAmbienceList;
  late List<images> mTishAppList;
  List<images>? mViewImagesList;
  late List<images> mUserPhotosList;

  @override
  void initState() {
    super.initState();
    mAmbienceList = addAmbiencePhotosData().cast<images>();
    mTishAppList = addTishAppPhotosData().cast<images>();
    mViewImagesList = addViewImagesData().cast<images>();
    mUserPhotosList = addUserPhotosData().cast<images>();
  }

  @override
  Widget build(BuildContext context) {
    //changeStatusColor(TishApp_app_background);
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(150),
              child: new Container(
                color: Colors.white,
                child: new SafeArea(
                  child: Container(
                      color: TishApp_app_background,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: TishApp_icon_color,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            child: TabBar(
                              labelPadding: EdgeInsets.only(left: 16, right: 0),
                              indicatorWeight: 3.3,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorColor: TishApp_colorAccent,
                              labelColor: TishApp_textColorPrimary,
                              isScrollable: true,
                              unselectedLabelColor: TishApp_textColorSecondary,
                              tabs: [
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    TishApp_all_photo,
                                    style: boldTextStyle(size: 16),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    TishApp_ambience,
                                    style: boldTextStyle(size: 16),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    TishApp_TishApp,
                                    style: boldTextStyle(size: 16),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    TishApp_user_photos,
                                    style: boldTextStyle(size: 16),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    color: TishApp_app_background,
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(TishApp_ambience, style: primaryTextStyle()),
                          SizedBox(
                            height: 8,
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemCount: mAmbienceList.length,
                            itemBuilder: (context, index) {
                              return Media(mAmbienceList[index], index);
                            },
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(TishApp_TishApp, style: primaryTextStyle()),
                          SizedBox(
                            height: 8,
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemCount: mTishAppList.length,
                            itemBuilder: (context, index) {
                              return Media(mTishAppList[index], index);
                            },
                          ),
                          SizedBox(height: 24),
                          Text(TishApp_user_photos, style: primaryTextStyle()),
                          SizedBox(height: 8),
                          GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemCount: mUserPhotosList.length,
                            itemBuilder: (context, index) {
                              return Media(mUserPhotosList[index], index);
                            },
                          ),
                          SizedBox(height: 24),
                        ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: mAmbienceList.length,
                    itemBuilder: (context, index) {
                      return Media(mAmbienceList[index], index);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: mTishAppList.length,
                    itemBuilder: (context, index) {
                      return Media(mTishAppList[index], index);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: mUserPhotosList.length,
                    itemBuilder: (context, index) {
                      return Media(mUserPhotosList[index], index);
                    },
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

// ignore: must_be_immutable
class Media extends StatelessWidget {
  late images model;

  Media(images model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(12.0),
        child: CachedNetworkImage(
          imageUrl: model.image,
          fit: BoxFit.fill,
          height: width * 0.15,
          width: width * 0.25,
        ),
      ),
    );
  }
}
