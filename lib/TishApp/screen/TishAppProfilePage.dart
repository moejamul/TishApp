import 'dart:io';

import 'package:TishApp/TishApp/Components/Widgets.dart';
import 'package:TishApp/TishApp/Services/Place/UserFavoritePlacesRepository.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/viewmodel/PlaceViewModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences prefs;
  String name = "";

  Future<List<Place>> getPlace() async {
    await Provider.of<PlaceViewModel>(context, listen: false).fetchAll();
    var _placeList =
        await Provider.of<PlaceViewModel>(context, listen: false).placeList;
    return _placeList;
  }

  Future<List<UserFavoritePlaces>> getFavoritePlaces() async {
    var list =
        await User_Favorite_PlacesRepository().fetchAllUser_Favorite_Places();
    return list;
  }

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
    return Row(
      children: [
        ProfileRowButton(number: '30', text: 'Followers'),
        ProfileRowButton(number: '300', text: 'Followings'),
        ProfileRowButton(number: '300', text: 'Followings', last: true),
      ],
    );
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          width: width * 0.95,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //   height: width * 0.05,
                // ),
                // ProfilePicture(
                //     width: width,
                //     height: height,
                //     context: context,
                //     file: image),
                // SizedBox(
                //   height: width * 0.05,
                // ),
                // UpgradeToProButton(width: width),
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
                AboutText(width, height),
                SizedBox(
                  height: width * 0.05,
                ),
                Text(
                  'Favorites',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                FutureBuilder(
                    future: getFavoritePlaces(),
                    builder: (context,
                        AsyncSnapshot<List<UserFavoritePlaces>> snapshot) {
                      if (!snapshot.data!.isEmpty) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text(
                                '${snapshot.error}' + "CHECK YOUR INTERNET");
                          }
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60)),
                            height: 250,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return HorizontalRowPlace(
                                      context, snapshot.data!);
                                }),
                          );
                        } else {
                          return Center(
                              child: const CircularProgressIndicator());
                        }
                      } else {
                        return Row(
                          children: [
                            Spacer(),
                            Text("No Favorite places"),
                            Spacer()
                          ],
                        );
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
