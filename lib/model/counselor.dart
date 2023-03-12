class Counselor {
  String email;
  String password;
  String name;
  String birth;
  String address;
  String gender;
  String? profileUrl;
  bool confirm;

  Counselor(
      {required this.email,
      required this.password,
      required this.name,
      required this.address,
      required this.birth,
      required this.gender,
      this.profileUrl,
      required this.confirm});

  factory Counselor.fromJson(Map<String, dynamic> json) {
    return Counselor(
        email: json['email'],
        password: json['password'],
        name: json['name'],
        address: json['address'],
        birth: json['birth'],
        gender: json['gender'],
        confirm: json['confirm']);
  }
}
