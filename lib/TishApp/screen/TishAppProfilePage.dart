import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: width * 0.05,
            ),
            // Center(
            //   child: Container(
            //     decoration:
            //         BoxDecoration(borderRadius: BorderRadius.circular(30)),
            //     child: null,
            //   ),
            // ),
            Row(
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  width: width * 0.5,
                  height: 50,
                  child: Center(
                    child: Column(
                      children: [Text('Followers'), Text('30')],
                    ),
                  ),
                ),
                Container(
                  width: width * 0.5,
                  height: 50,
                  child: Center(
                    child: Column(
                      children: [Text('Followings'), Text('300')],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
