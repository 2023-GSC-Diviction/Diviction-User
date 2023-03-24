class NetWorkResult {
  Result result;
  dynamic response;

  NetWorkResult({
    required this.result,
    this.response,
  });

  List<Map<String, dynamic>> toListOfMap() {
    if (result == Result.success) {
      return response.map((item) => item.toJson()).toList();
    } else {
      return [];
    }
  }
}

extension MapExtension on Map<String, dynamic> {
  // toJson() 메소드 구현
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    this.forEach((key, value) {
      data[key] = value;
    });
    return data;
  }
}

enum Result { fail, success, tokenExpired }
