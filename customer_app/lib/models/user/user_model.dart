class User {
  User({required this.id, required this.phone, required this.name});

  final int id;
  final String phone;
  final String name;

  static User loginResponse(Map<String, dynamic> json) {
    return User(
        id: json["passenger"]["id"] ?? "1",
        phone: json["passenger"]["phone"] ?? "00000000",
        name: json["passenger"]["name"] ?? "Passenger");
  }
}
