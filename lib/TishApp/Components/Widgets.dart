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
        Icon(Icons.remove)
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

Widget HorizontalRow() {
  return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 250,
      child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: List.generate(10, (index) => HorizontalRowItem())));
}
