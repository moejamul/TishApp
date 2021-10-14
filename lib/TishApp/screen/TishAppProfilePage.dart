import 'dart:io';

import 'package:TishApp/TishApp/Components/Widgets.dart';
import 'package:TishApp/TishApp/Services/Place/UserFavoritePlacesRepository.dart';
import 'package:TishApp/TishApp/Services/User/UserRepository.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/utils/TishAppWidget.dart';
import 'package:TishApp/TishApp/viewmodel/PlaceViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  late SharedPreferences prefs;
  int likedPlacesNum = 0;
  int reviewsNum = 0;
  int AvgRating = 0;
  String name = "";

  Widget AboutText(double width, double height) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: width * 0.01,
        ),
        Text(
            '"On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains."')
      ],
    );
  }

  Widget ProfileRowButton(
      {required String text, required String number, bool last = false}) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              border: !last
                  ? Border(right: BorderSide(color: Colors.black))
                  : null),
          height: 60,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  number,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(text)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget UpgradeToProButton({double? width}) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {},
      child: Container(
        width: width! * 0.3,
        constraints: BoxConstraints(maxWidth: 275),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.lightBlue,
        ),
        height: 50,
        child: Center(
          child: Text(
            'Upgrade To Pro',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget ProfileRow() {
    return                FutureBuilder(
                    future: UserRepository().fetchUserByEmail(),
                    builder: (context, AsyncSnapshot<User> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text(
                              '${snapshot.error}' + "CHECK YOUR INTERNET");
                        }
                        List<UserFavoritePlaces> userFavoritePlacesList = [];
                        List<Review> reviewsList = [];
                        for (var item in snapshot.data!.favorite_Places) {
                          userFavoritePlacesList.add(item);
                        }
                        likedPlacesNum = userFavoritePlacesList.length;
                        for (var item in snapshot.data!.reviews) {
                          reviewsList.add(item);
                        }
                        int avgrating = 0;
                        for (var item in reviewsList) {
                          avgrating += int.parse(item.Rating.toString());
                        }
                        reviewsNum = reviewsList.length;
                        AvgRating = avgrating~/reviewsNum;
    return Row(
      children: [
        ProfileRowButton(number: likedPlacesNum.toString(), text: 'Liked Places'),
        ProfileRowButton(number: reviewsNum.toString(), text: 'Number of Reviews'),
        ProfileRowButton(number: AvgRating.toString(), text: 'Avg. Rating', last: true),
      ],
    );
                      } else {
                        return Center(child: const CircularProgressIndicator());
                      }

                    });
  }

  var image = '';

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name')!.toString();
    // user = await UserRepository().fetchUserByEmail();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          // width: width * 0.95,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(name),
                ),
                SizedBox(
                  height: width * 0.05,
                ),
                ProfileRow(),
                SizedBox(
                  height: width * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AboutText(width, height),
                ),
                SizedBox(
                  height: width * 0.05,
                ),
                Text(
                  'Favorites',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                FutureBuilder(
                    future: UserRepository().fetchUserByEmail(),
                    builder: (context, AsyncSnapshot<User> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text(
                              '${snapshot.error}' + "CHECK YOUR INTERNET");
                        }
                        List<UserFavoritePlaces> userFavoritePlacesList = [];
                        List<Review> reviewsList = [];
                        for (var item in snapshot.data!.favorite_Places) {
                          userFavoritePlacesList.add(item);
                        }
                        likedPlacesNum = userFavoritePlacesList.length;
                        for (var item in snapshot.data!.reviews) {
                          reviewsList.add(item);
                        }
                        int avgrating = 0;
                        for (var item in reviewsList) {
                          avgrating += int.parse(item.Rating.toString());
                        }
                        reviewsNum = reviewsList.length;
                        AvgRating = avgrating~/reviewsNum;
                          reviewsList.sort((a,b) => b.Updated_At.toString().compareTo(a.Updated_At.toString()));
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  HorizontalRowPlace(
                                      context, userFavoritePlacesList),
                                                      SizedBox(
                  height: width * 0.05,
                ),
                                                      Text(
                  'Latest comments',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                                  reviewsList.length != 0
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: 5,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            CircleAvatar(),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          12.0),
                                                              child: Text(
                                                                "${snapshot.data!
                                                                    .Username} on ${snapshot.data!.reviews
                                                                      .elementAt(
                                                                          index).Reviewed_Place['name']}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: Row(
                                                            children: [
                                                              totalRatting(
                                                                  reviewsList
                                                                      .elementAt(
                                                                          index)
                                                                      .Rating),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0),
                                                                child: Text(reviewsList
                                                                    .elementAt(
                                                                        index)
                                                                    .Updated_At
                                                                    .toString()
                                                                    .split(
                                                                        "T")[0]),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 12.0),
                                                          child: Container(
                                                            width: width - 24,
                                                            child: Text(
                                                              reviewsList
                                                                  .elementAt(
                                                                      index)
                                                                  .Message
                                                                  .toString()
                                                                  .trim(),
                                                              maxLines: 5,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })
                                      : Center(
                                          child: Text("No Reviews Available"))
                                ],
                              );
                            });
                      } else {
                        return Center(child: const CircularProgressIndicator());
                      }

                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
