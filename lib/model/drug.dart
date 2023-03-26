class Drug {
  int id;
  String drugName;

  Drug({required this.id, required this.drugName});

  factory Drug.fromJson(Map<String, dynamic> json) {
    return Drug(id: json['id'], drugName: json['name']);
  }
}
