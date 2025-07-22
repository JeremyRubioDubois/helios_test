class User {
  final String fullName;
  final String email;
  final String phone;
  final String pictureUrl;

  User({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.pictureUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final picture = json['picture'];

    return User(
      fullName: '${name['first']} ${name['last']}',
      email: json['email'],
      phone: json['phone'],
      pictureUrl: picture['large'],
    );
  }
}
