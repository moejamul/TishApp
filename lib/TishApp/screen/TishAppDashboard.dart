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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<Widget> list = [];
    return Scaffold(
      body: ListView(
        children: [
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
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'images/imageTest.jpeg',
                                  height: 250,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.transparent.withOpacity(0.6),
                                    Colors.black.withOpacity(0.1),
                                    Colors.transparent.withOpacity(0.6),
                                  ]),
                                ),
                              ),
                              Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                          return T5CarouselSlider(items: list);
                        }),
                  );
                } else
                  return Center(
                    child: const CircularProgressIndicator(),
                  );
              }),
          Divider(),
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
          TextButton(
            onPressed: () {},
            child: Text("Show More"),
          ),
          Divider(),
          FutureBuilder(
              future: getPlace(),
              builder: (context, AsyncSnapshot<List<Place>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}' + "CHECK YOUR INTERNET");
                  }
                  snapshot.data!.shuffle();
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(60)),
                    height: (250 * snapshot.data!.length).toDouble() + 100,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
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
                                constraints: BoxConstraints(
                                    maxHeight: 250, maxWidth: 250),
                                height: height,
                                width: width * 0.85,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      decoration:
                                          BoxDecoration(shape: BoxShape.circle),
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        'images/imageTest.jpeg',
                                        height: 250,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.transparent.withOpacity(0.6),
                                          Colors.black.withOpacity(0.1),
                                          Colors.transparent.withOpacity(0.6),
                                        ]),
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${snapshot.data!.elementAt(index).Name} $index',
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
                        }),
                  );
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
