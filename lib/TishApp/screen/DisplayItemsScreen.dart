import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:TishApp/TishApp/viewmodel/PlaceViewModel.dart';
import 'package:flutter/material.dart';

import 'PlaceDescription.dart';

class DisplayItemScreen extends StatefulWidget {
  final String type;
  const DisplayItemScreen({required this.type});

  @override
  _DisplayItemScreenState createState() => _DisplayItemScreenState();
}

class _DisplayItemScreenState extends State<DisplayItemScreen> {
  @override
  Widget build(BuildContext context) {
    print(this.widget.type);
    return Scaffold(
        appBar: AppBar(
          title: Text(this.widget.type),
        ),
        body: FutureBuilder(
            future: PlaceViewModel().fetchByType(this.widget.type),
            builder: (context, AsyncSnapshot<List<Place>> snapshot) {
              if(snapshot.connectionState == ConnectionState.done)
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TishAppDescription(
                                        PlaceID: snapshot.data!.elementAt(index).Place_ID,
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                              child: Row(
                            children: [
                              Text(snapshot.data!.elementAt(index).Name),
                              Spacer(),
                              Icon(Icons.arrow_right)
                            ],
                          )),
                        ),
                      );
                    });
                else {
                  return Center(child: CircularProgressIndicator(),);
                }
            }));
  }
}
