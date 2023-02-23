class User {
  int id;
  String email;
  String password;
  String name;
  String birth;
  String address;
  String gender;
  String? profileUrl;

  User(
      {required this.id,
      required this.email,
      required this.password,
      required this.name,
      required this.address,
      required this.birth,
      required this.gender,
      this.profileUrl});
}
