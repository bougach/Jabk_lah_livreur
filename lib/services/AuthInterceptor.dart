import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<dynamic> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
    if (token != null) {
      options.headers['Authorization'] = token;
    }
    return super.onRequest(options, handler);
  }
  void main(){


  }


}
