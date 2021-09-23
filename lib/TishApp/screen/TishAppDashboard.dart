import 'dart:math';

import 'package:TishApp/TishApp/Components/T5SliderWidget.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/viewmodel/PlaceViewModel.dart';
import 'package:TishApp/TishApp/viewmodel/Place_TypeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:TishApp/main.dart';
import 'package:provider/provider.dart';

import 'DisplayItemsScreen.dart';
import 'PlaceDescription.dart';

class TishAppDashboard extends StatefulWidget {
  const TishAppDashboard();

  @override
  _TishAppDashboardState createState() => _TishAppDashboardState();
}

class _TishAppDashboardState extends State<TishAppDashboard> {
  List<Place> PlaceList = [];
  List<Place_Type> placeTypeList = [];

  Future<List<Place>> getPlace() async {
    await Provider.of<PlaceViewModel>(context, listen: false).fetchAll();
    var _placeList =
        Provider.of<PlaceViewModel>(context, listen: false).placeList;
    // PlaceList.addAll(_placeList);
    return _placeList;
    // setState(() {});
  }

  Future<List<Place_Type>> getPlaceType() async {
    await Provider.of<Place_TypeViewModel>(context, listen: false)
        .fetchPlace_TypeData();
    var _placeList = Provider.of<Place_TypeViewModel>(context, listen: false)
        .place_type_List;
    return _placeList;
    // placeTypeList.addAll(_placeList);
    // setState(() {});
  }

  @override
  void initState() {
    // getPlace();
    super.initState();
  }

  int generateRandomNumber(int lower, int higher) {
    Random random = new Random();
    int temp = random.nextInt(higher);
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<Widget> list = [];
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 24.0),
            child: Row(
              children: [
                Text(
                  'Suggested Places',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0),
                )
              ],
            ),
          ),
          FutureBuilder(
              future: getPlace(),
              builder: (context, AsyncSnapshot<List<Place>?> snapshot) {
                if (snapshot.data != null) {
                  for (Place item in snapshot.data!) {
                    Widget temp = GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TishAppDescription(
                                      place: item,
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Container(
                          constraints:
                              BoxConstraints(maxHeight: 250, maxWidth: 350),
                          height: height,
                          width: width * 0.85,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: item.medias.length != 0
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(
                                          item.medias[generateRandomNumber(
                                              0, item.medias.length)],
                                          height: 250,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.asset(
                                          "images/imageTest.jpeg",
                                          height: 250,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Colors.transparent.withOpacity(0.6),
                                      Colors.black.withOpacity(0.1),
                                      Colors.transparent.withOpacity(0.6),
                                    ]),
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      '${item.Name}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0),
                                    ),
                                  )),
                            ],
                          ),
                        )),
                      ),
                    );
                    list.add(temp);
                  }
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}' + "CHECK YOUR INTERNET");
                  }
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(60)),
                    height: 250,
                    child: PageView.builder(
                        allowImplicitScrolling: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return T5CarouselSlider(
                              items: list,
                              enlargeCenterPage: false,
                              viewportFraction: 0.9);
                        }),
                  );
                } else
                  return Center(
                    child: const CircularProgressIndicator(),
                  );
              }),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 24.0),
            child: Row(
              children: [
                Text(
                  'Browse types',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0),
                )
              ],
            ),
          ),
          FutureBuilder(
              future: getPlaceType(),
              builder: (context, AsyncSnapshot<List<Place_Type>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}' + "CHECK YOUR INTERNET");
                  }
                  return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DisplayItemScreen(
                                          type: snapshot.data!
                                              .elementAt(index)
                                              .Type)));
                                },
                                child: Center(
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100.0)),
                                          elevation: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(00.0),
                                            child: Icon(
                                              Icons.ac_unit,
                                              size: 50,
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(00.0),
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            snapshot.data!
                                                .elementAt(index)
                                                .Type
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )));
                      });
                } else
                  return Center(
                    child: const CircularProgressIndicator(),
                  );
              }),
          // TextButton(
          //   onPressed: () {},
          //   child: Text("Show More"),
          // ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 24.0, bottom: 24.0),
            child: Row(
              children: [
                Text(
                  'Explore',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0),
                )
              ],
            ),
          ),
          FutureBuilder(
              future: getPlace(),
              builder: (context, AsyncSnapshot<List<Place>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}' + "CHECK YOUR INTERNET");
                  }
                  snapshot.data!.shuffle();
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // double rating = 0;
                        // for (var item
                        //     in snapshot.data!.elementAt(index).reviews) {
                        //   rating += double.parse(item.Rating.toString());
                        // }
                        // if (rating != 0)
                        //   rating /=
                        //       snapshot.data!.elementAt(index).reviews.length;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TishAppDescription(
                                          place:
                                              snapshot.data!.elementAt(index),
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 20,
                                        spreadRadius: 1)
                                  ]),
                              constraints:
                                  BoxConstraints(maxHeight: 300, maxWidth: 450),
                              height: height,
                              width: width * 0.85,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 220,
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    alignment: Alignment.center,
                                    child:
                                        snapshot.data![index].medias.length != 0
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Image.network(
                                                  snapshot.data![index].medias[
                                                      generateRandomNumber(
                                                          0,
                                                          snapshot.data![index]
                                                              .medias.length)],
                                                  height: 300,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Image.asset(
                                                  "images/imageTest.jpeg",
                                                  height: 300,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.transparent.withOpacity(0.6),
                                          Colors.black.withOpacity(0.1),
                                          Colors.transparent.withOpacity(0.6),
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 201),
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30)),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${snapshot.data!.elementAt(index).Name}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22.0),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: snapshot.data![index]
                                                                .averageReviews ==
                                                            0
                                                        ? Colors.grey
                                                        : Colors.green[700],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0,
                                                            top: 2.0,
                                                            bottom: 2.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          '${snapshot.data![index].averageReviews == 0 ? '-' : snapshot.data![index].averageReviews}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15.0),
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.white,
                                                          size: 15,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${snapshot.data!.elementAt(index).place_type.Type}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        );
                      });
                } else
                  return Center(
                    child: const CircularProgressIndicator(),
                  );
              }),
        ],
      ),
    );
  }
}
