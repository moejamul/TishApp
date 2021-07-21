// TODO add TishApp entity models

// class Place {
//   var name;
//   var image;
//   var rating;
//   var review;

//   Place({this.name, this.rating, this.image, this.review});

//   factory Place.fromJson(Map<String, dynamic> json) {
//     return Place(
//       name: json['name'],
//       image: json['image'],
//       rating: json['rating'],
//       review: json['review'],
//     );
//   }
// }

class Place {
  var userId;
  var id;
  var title;
  var completed;

  Place({this.userId, this.title, this.id, this.completed});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}

class ViewPlace {
  var name;
  List<images> image;
  var rating;
  var review;
  var rs;
  var sector;
  var kms;
  var offer;
  var info;

  ViewPlace(
    this.name,
    this.image,
    this.rating,
    this.review,
    this.rs,
    this.sector,
    this.kms,
    this.offer,
    this.info,
  );
}

class images {
  var image;

  images(this.image);
}

class ReviewModel {
  var review;
  var rate;
  var image;
  var duration;

  ReviewModel(this.image, this.review, this.rate, this.duration);
}
