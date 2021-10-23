import 'dart:math';

import 'package:TishApp/TishApp/Components/T5SliderWidget.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/screen/PlaceDescription.dart';
import 'package:TishApp/TishApp/viewmodel/PlaceViewModel.dart';
import 'package:flutter/material.dart';

Widget ProfilePicture(
    {required double width,
    required double height,
    required BuildContext context,
    required var file}) {
  return Container(
    child: Stack(
      children: [
        CircleAvatar(
          child: Image.asset(file),
          radius: 100,
        ),
        PopupMenuButton(
          itemBuilder: (BuildContext bc) => [
            PopupMenuItem(child: Text("New Chat"), value: "/newchat"),
            PopupMenuItem(
                child: Text("New Group Chat"), value: "/new-group-chat"),
            PopupMenuItem(child: Text("Settings"), value: "/settings"),
          ],
          onSelected: (route) {
            print(route.toString());
            // Note You must create respective pages for navigation
            Navigator.pushNamed(context, route.toString());
          },
        ),
      ],
    ),
  );
}

Widget HorizontalRowItem() {
  return Container(
    width: 200,
    height: 250,
    child: Card(
      child: Column(
        children: [
          Placeholder(
            fallbackHeight: 125,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Image',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '"On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget HorizontalRowPlaceItem(Place p) {
  return Card(
    child: Column(
      children: [
        Placeholder(
          fallbackHeight: 125,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    p.Name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    p.Place_ID.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                p.Description,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget HorizontalRow() {
  return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 250,
      child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: List.generate(10, (index) => HorizontalRowItem())));
}

  int generateRandomNumber(int lower, int higher) {
    Random random = new Random();
    int temp = random.nextInt(higher);
    return temp;
  }

Widget HorizontalRowPlace(BuildContext context, List<UserFavoritePlaces> list) {
  return Container(
      height: 230,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (context, index) {
            List<Widget> WidgetList = [];
            
            for (var item in list) {
                String bucketName = item.place.medias.length!=0?item.place.medias[generateRandomNumber(0,item.place.medias.length)]['bucketName']:'null';
                String objectName = item.place.medias.length!=0?item.place.medias[generateRandomNumber(0,item.place.medias.length-1)]['objectName']:'null';

              Widget temp = 
              GestureDetector(
                onDoubleTap: (){},
                onTap: (){
                                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TishAppDescription(
                                      PlaceID: item.place.Place_ID,
                                    )));
                },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: bucketName != 'null'?FutureBuilder(
                                            future: PlaceViewModel().fetchPlaceImage(bucketName,objectName),
                                            builder: (context,AsyncSnapshot<String> snapshot){
                                              // return Text("data");
                                              return Image.network(
                                              snapshot.data.toString(),
                                              height: 250,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            );
                                            },
                                          ):Image.asset(
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
                                      '${item.place.Name}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0),
                                    ),
                                  )),],
                ),
              ));
              WidgetList.add(temp);
            }
            return T5CarouselSlider(
              items: WidgetList,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              viewportFraction: 0.85,
            );
          }));
}
