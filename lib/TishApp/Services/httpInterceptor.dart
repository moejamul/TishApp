import 'package:http_interceptor/http_interceptor.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("jwt");
    data.headers["Accept"] = "application/json";
    data.headers["access_token"] = 'Bearer $token';
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print(data.body.toString());
    print(data.statusCode);
    return data;
  }
}
