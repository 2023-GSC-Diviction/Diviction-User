import 'dart:convert';

import 'package:diviction_user/model/network_result.dart';
import 'package:diviction_user/network/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/drug.dart';

class DrugService {
  final String? _baseUrl = dotenv.env['BASE_URL'];

  Future<List<Drug>> getDrugs() async {
    var response = await DioClient().get('$_baseUrl/drug/list', {}, true);
    if (response.result == Result.success) {
      List<Drug> drugs =
          response.response.map((post) => Drug.fromJson(post)).toList();
      return drugs;
    } else {
      throw Exception('Failed to load drugs');
    }
  }
}
