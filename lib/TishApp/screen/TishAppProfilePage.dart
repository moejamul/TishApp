import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
          height: 55,
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          width: width * 0.85,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height:
                      height * 0.2 < width * 0.2 ? width * 0.2 : height * 0.2,
                  width:
                      width * 0.2 < height * 0.2 ? height * 0.2 : width * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(300),
                      color: Colors.red),
                  child: Placeholder(),
                ),
                SizedBox(
                  height: width * 0.05,
                ),
                UpgradeToProButton(width: width),
                SizedBox(
                  height: width * 0.05,
                ),
                Row(
                  children: [
                    ProfileRowButton(number: '30', text: 'Followers'),
                    ProfileRowButton(number: '300', text: 'Followings'),
                    ProfileRowButton(
                        number: '300', text: 'Followings', last: true),
                  ],
                ),
                SizedBox(
                  height: width * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: width * 0.01,
                ),
                Text(
                    '"On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains."'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
