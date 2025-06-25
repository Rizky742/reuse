class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String accessToken;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        phoneNumber: json['phone_number'] ?? '',
        address: json['address'] ?? '',
        email: json['email'] ?? '',
        accessToken: json['accessToken'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'accessToken': accessToken,
    };
  }
}
