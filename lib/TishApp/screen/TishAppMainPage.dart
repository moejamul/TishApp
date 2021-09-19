import 'package:TishApp/TishApp/Services/Logout/LogoutRepository.dart';
import 'package:TishApp/TishApp/screen/SearchPage.dart';
import 'package:TishApp/TishApp/screen/TishAppDashboard.dart';
import 'package:TishApp/TishApp/screen/TishAppProfilePage.dart';
import 'package:TishApp/TishApp/viewmodel/Place_TypeViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:TishApp/TishApp/Components/SideMenu.dart';
import 'package:TishApp/TishApp/model/FoodModel.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/utils/TishAppColors.dart';
import 'package:TishApp/TishApp/utils/TishAppDataGenerator.dart';
import 'package:TishApp/TishApp/utils/TishAppImages.dart';
import 'package:TishApp/TishApp/utils/TishAppString.dart';
import 'package:TishApp/TishApp/utils/TishAppWidget.dart';
import 'package:TishApp/TishApp/viewmodel/PlaceViewModel.dart';
import 'package:provider/provider.dart';
import 'FoodBookCart.dart';
import 'PlaceDescription.dart';

class TishAppMainPage extends StatefulWidget {
  @override
  TishAppMainPageState createState() => TishAppMainPageState();
}

// ignore: must_be_immutable
class TishAppMainPageState extends State<TishAppMainPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late List<DashboardCollections> mCollectionList;

  int _currentIndex = 0;
  final List<Widget> _children = [TishAppDashboard(), ProfilePage()];

  @override
  void initState() {
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              if (await LogoutRepository().LogoutRepo()) {
                Navigator.of(context).pushReplacementNamed('/welcome');
              }
            },
            icon: Icon(Icons.logout)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/search');
              },
              icon: Icon(Icons.search))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex:
              _currentIndex, // this will be set when a new tab is tapped
          onTap: onTabTapped, // new
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]),
      body: _children[_currentIndex],
    );
  }
}

// ignore: must_be_immutable
class Item extends StatelessWidget {
  late Place model;

  Item(Place model) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          TishAppDescription(model.Place_ID).launch(context);
        },
        child: Container(
            // decoration:
            //     BoxDecoration(boxShadow: defaultBoxShadow(), color: white),
            child: Column(children: [Placeholder()])));
  }
}
