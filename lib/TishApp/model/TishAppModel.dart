// TODO add TishApp entity models

class Place {
  var Place_ID;
  var Name;
  var Location;
  var Description;
  var Created_at;
  var Updated_at;
  Place_Type place_type;
  var averageReviews;
  List<dynamic> reviews;
  var medias;
  var user;
  List<dynamic> earnedBadges;

  Place(
      {this.Place_ID,
      this.Name,
      this.Location,
      this.Description,
      this.Created_at,
      this.Updated_at,
      required this.place_type,
      this.averageReviews,
      required this.earnedBadges,
      this.user,
      required this.reviews,
      this.medias});

  factory Place.fromJson(Map<String, dynamic> json) {
    double rating = 0;
    for (var item in json['reviews']) {
      rating += double.parse(item['rating'].toString());
    }
    if (rating != 0) rating /= json['reviews'].length;
    Place temp = Place(
        Place_ID: json['place_ID'],
        Name: json['name'],
        Location: json['location'],
        Description: json['description'],
        Created_at: json['created_at'],
        Updated_at: json['updated_at'],
        place_type: Place_Type.fromJson(json['place_Type']),
        reviews: (json['reviews'].map((e) => Review.fromJson(e))).toList(),
        user: json['user'],
        averageReviews: rating,
        earnedBadges: json['earned_Badges'] != null?
            json['earned_Badges'].map((e) => Place_Badge.fromJson(e)).toList():[],
        // reviews: json['reviews'],
        medias: json['medias']);
    return temp;
  }
}

class Place_Type {
  var Place_Type_ID;
  var Type;
  Place_Type({this.Place_Type_ID, this.Type});

  factory Place_Type.fromJson(Map<String, dynamic> json) {
    return Place_Type(
      Place_Type_ID: json['place_Type_ID'],
      Type: json['type'],
    );
  }
}

class Place_Badge {
  var Badge_ID;
  var path;
  var title;
  Place_Badge({this.Badge_ID, this.path, this.title});

  factory Place_Badge.fromJson(Map<String, dynamic> json) {
    return Place_Badge(
        Badge_ID: json['badge_ID'], path: json['path'], title: json['title']);
  }
}

class Badge {
  var Badge_ID;
  var Icon;
  var Badge_Type_ID;

  Badge({this.Badge_ID, this.Icon, this.Badge_Type_ID});

  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
        Badge_ID: json['badge_ID'],
        Icon: json['icon'],
        Badge_Type_ID: json['badge_Type_ID']);
  }
}

class Badge_Type {
  var Badge_Type_ID;
  var Type;

  Badge_Type({this.Badge_Type_ID, this.Type});

  factory Badge_Type.fromJson(Map<String, dynamic> json) {
    return Badge_Type(Badge_Type_ID: json['Badge_Type_ID'], Type: json['Type']);
  }
}

class User_Badge {
  var Badge_ID;
  var User_ID;
  var Earned_At;

  User_Badge({this.Badge_ID, this.User_ID, this.Earned_At});

  factory User_Badge.fromJson(Map<String, dynamic> json) {
    return User_Badge(
        Badge_ID: json['Badge_ID'],
        User_ID: json['User_ID'],
        Earned_At: json['Earned_At']);
  }
}

class UserFavoritePlaces {
  var User_ID;
  Place place;

  UserFavoritePlaces({this.User_ID, required this.place});

  factory UserFavoritePlaces.fromJson(Map<String, dynamic> json) {
    return UserFavoritePlaces(
        User_ID: json['user'], place: Place.fromJson(json['place']));
  }
}

class User {
  var Username;
  var Email;
  var User_ID;
  List<dynamic> favorite_Places;
  var places;
  List<dynamic> reviews;

  User(
      {this.Username,
      this.Email,
      this.User_ID,
      required this.favorite_Places,
      this.places,
      required this.reviews});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        Username: json['username'],
        Email: json['email'],
        User_ID: json['user_ID'],
        favorite_Places: json['favorite_Places'] != null
            ? json['favorite_Places']
                .map((e) => UserFavoritePlaces.fromJson(e))
                .toList()
            : [],
        places: json['places'] == null ? null : json['places'],
        reviews: json['reviews'] != null
            ? json['reviews'].map((e) => Review.fromJson(e)).toList()
            : []);
  }
}

class Review {
  var Review_ID;
  var Message;
  var Rating;
  var Created_At;
  var Updated_At;
  var Reviewed_Place;
  dynamic user;

  Review(
      {this.Review_ID,
      this.Message,
      this.Rating,
      this.Created_At,
      this.Updated_At,
      this.Reviewed_Place,
      required this.user});

  factory Review.fromJson(Map<String, dynamic> json) {
    Review temp = Review(
        Review_ID: json['review_ID'],
        Message: json['message'],
        Rating: json['rating'],
        Created_At: json['created_at'].toString(),
        Updated_At: json['updated_at'].toString(),
        Reviewed_Place: json['reviewed_Place'],
        user: json['user'] == null ? null : User.fromJson(json['user']));
    return temp;
  }
}

class Media {
  var Media_ID;
  var Media_Type_ID;
  var Place_ID;

  Media({this.Media_ID, this.Media_Type_ID, this.Place_ID});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
        Media_ID: json['Media_ID'],
        Media_Type_ID: json['Media_Type_ID'],
        Place_ID: json['Place_ID']);
  }
}

class Media_Type {
  var Media_Type_ID;
  var Type;

  Media_Type({this.Media_Type_ID, this.Type});

  factory Media_Type.fromJson(Map<String, dynamic> json) {
    return Media_Type(Media_Type_ID: json['Media_Type_ID'], Type: json['Type']);
  }
}
