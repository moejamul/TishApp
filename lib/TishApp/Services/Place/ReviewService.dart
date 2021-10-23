import 'package:TishApp/TishApp/Settings/AppSettings.dart';
import 'package:TishApp/TishApp/Settings/DioSettings.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class ReviewService {
  Settings settings = Settings();
  final String _baseUrl = Settings().backend_url;

  Future<dynamic> getAll() async {
    var responseJson;
    Dio dio = await DioSettings.getDio();
    try {
      final response = await dio.get((_baseUrl + '/reviews'));
      print(response.statusCode);
      responseJson = returnResponse(response);
    } on Exception catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  Future<bool> AddReview(
      String email, int PlaceID, int Rating, String Message) async {
    Dio dio = await DioSettings.getDio();
    try {
      final response = await dio.post((_baseUrl + '/reviews/$email/$PlaceID'),
          data: {"Message": Message, "Rating": Rating});
      print(response.statusCode);
      if (response.statusCode == 201) {
        return true;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return true;
  }

  @visibleForTesting
  dynamic returnResponse(var response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = (response.data);
        return responseJson;
      case 400:
        throw Exception(response.body.toString());
      case 401:
      case 403:
        throw Exception(response.body.toString());
      case 500:
      default:
        throw Exception('Error occured while communication with server' +
            ' with status code : ${response.statusCode}');
    }
  }
}
