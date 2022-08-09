class User {
  User({required this.id, required this.phone, required this.name});

  final int id;
  final String phone;
  final String name;

  static User loginResponse(Map<String, dynamic> json) {
    return User(
        id: json["passenger"]["id"],
        phone: json["passenger"]["phone"],
        name: json["passenger"]["name"] ?? "Passenger");
  }
}
