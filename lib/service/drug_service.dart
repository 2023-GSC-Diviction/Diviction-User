import 'dart:convert';

import 'package:diviction_user/model/network_result.dart';
import 'package:diviction_user/network/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/drug.dart';

class DrugService {
  final String? _baseUrl = dotenv.env['BASE_URL'];

  Future<List<Drug>> getDrugs() async {
    var response = await DioClient().get('$_baseUrl/drug/list', {}, true);
    if (response.result == Result.success) {
      List<Drug> drugs = response.response
          .map((post) => Drug.fromJson(post))
          .cast<Drug>()
          .toList();
      return drugs;
    } else {
      throw Exception('Failed to load drugs');
    }
  }

  Future saveDrug(Drug drug) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int id = prefs.getInt('id')!;
    var response = await DioClient().post('$_baseUrl/drugofmember/save',
        {'memberId': id, 'drugId': drug.id}, true);
    if (response.result == Result.success) {
      prefs.setString('drug', drug.drugName);
      return response.response;
    } else {
      throw Exception('Failed to save drug');
    }
  }
}
