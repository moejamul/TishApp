import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'ReviewService.dart';

class ReviewRepository {
  ReviewService _ReviewService = ReviewService();

  Future<List<Review>> fetchAllReviews() async {
    List<Review> list = [];
    dynamic response = await _ReviewService.getAll();
    for (var item in response) {
      list.add(item);
    }
    return list;
  }

  Future<bool> AddReviewToPlace(String UserEmail, int PlaceID, int Rating, String Message) async {
    bool response = await _ReviewService.AddReview(UserEmail, PlaceID, Rating, Message);
    return response;
  }
}
