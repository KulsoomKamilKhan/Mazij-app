import 'dart:convert';

import 'package:Mazaj/data/models/statistics_model.dart';
import 'package:http/http.dart' as http;

class StatisticsRepository {
  static const base = "http://bhavikakaliya.pythonanywhere.com/users/user/stats/";

  Future<Statistics> GetStats() async {
    Uri local = Uri.parse(base);
    var response = await http.get(local);
    var statList = jsonDecode(response.body);
    Statistics statistics = Statistics.fromJson(statList);
    if (response.statusCode == 200) {
      return statistics;
    } else {
      throw Exception('Failed to load stats');
    }
  }
}
