class AdminAuthRequest {
  String username;
  String password;

  AdminAuthRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'password': password,
    };
  }
}

class AuthenticationResponse {
  String token;

  AuthenticationResponse({required this.token});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticationResponse(token: json['token'] as String);
  }
}
