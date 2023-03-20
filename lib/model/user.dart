class User {
  int? id;
  String email;
  String password;
  String name;
  String birth;
  String address;
  String gender;
  String profile_img_url;

  User(
      {
      this.id,
      required this.email,
      required this.password,
      required this.name,
      required this.address,
      required this.birth,
      required this.gender,
      required this.profile_img_url});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'address': address,
        'birth': birth,
        'gender': 'MAIL',
        'profile_img_url': profile_img_url,
      };
}
