class User {
  User({required this.id, required this.phone, required this.name});

  final String id;
  final String phone;
  final String name;

  static User loginResponse(Map<String, dynamic> json) {
    return User(
        id: json["customerId"]["id"],
        phone: json["phone"],
        name: json["name"] ?? "User");
  }
}
