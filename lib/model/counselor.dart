class Counselor {
  int id;
  String email;
  String password;
  String name;
  String birth;
  String address;
  String gender;
  String? profileUrl;
  bool confirm;

  Counselor(
      {required this.id,
      required this.email,
      required this.password,
      required this.name,
      required this.address,
      required this.birth,
      required this.gender,
      this.profileUrl,
      required this.confirm});
}
