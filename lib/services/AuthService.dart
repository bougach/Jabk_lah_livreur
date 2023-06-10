import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jabklah_livreur/entities/AdminAuthRequest.dart';
import 'package:jabklah_livreur/services/AuthInterceptor.dart';


class AuthService {

  Future<AuthenticationResponse> authenticate(AdminAuthRequest request) async {

    try {
      final response = await http.post(
        Uri.parse('https://jabak-lah-app.herokuapp.com/api/auth/authenticate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request.toJson()),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonBody = jsonDecode(response.body) as Map<String, dynamic>;
        return AuthenticationResponse.fromJson(jsonBody);
      } else {
        throw Exception('Failed to authenticate');
      }
    } catch (e) {
      throw Exception('Failed to authenticate: $e');
    }
  }


}
