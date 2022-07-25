class LoginResponse {
  LoginResponse({required this.token, required this.refreshToken});

  String token;
  String refreshToken;

  static LoginResponse? loginResponse(Map<String, dynamic>? json) {
    if (json == null) return null;
    return LoginResponse(
      token: json["token"],
      refreshToken: json["refreshToken"],
    );
  }
}

class LoginRequest {
  String username;
  String password;

  LoginRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() => {"username": username, "password": password};
}

class RegisterRequest {
  String name;
  String username;
  String password;
  String confirmPassword;

  RegisterRequest({
    required this.name,
    required this.username,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() =>
      {"email": username, "title": name, "password": password};

  static int? registerSuccessful(Map<String, dynamic>? json) {
    if (json == null) return null;
    return json["status"];
  }
}
