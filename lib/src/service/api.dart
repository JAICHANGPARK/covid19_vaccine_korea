import 'dart:convert';

import 'package:covid_19_vaccine_korea/src/model/vaccine_center.dart';
import 'package:covid_19_vaccine_korea/src/model/vaccine_count.dart';
import 'package:covid_19_vaccine_korea/src/service/api_key.dart';
import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<VaccineCenter?> fetchVaccineCenter() async {
  try {
    Response response = await Dio().get("https://api.odcloud.kr/api/15077586/v1/centers?serviceKey=${ApiKey.API_KEY}");
    Fimber.d(">>> $response");
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.toString());
      Fimber.d('Number of books about http: $jsonResponse.');
      VaccineCenter vaccineCenter = VaccineCenter.fromJson(jsonDecode(response.toString()));
      // var itemCount = jsonResponse['totalItems'];
      Fimber.d(">>> ${vaccineCenter.currentCount}");
      return vaccineCenter;
    } else {
      Fimber.d('Request failed with status: ${response.statusCode}.');
      return null;
    }
  } catch (e) {
    Fimber.d(e.toString());
  }
}

Future fetchVaccineCenterOld() async {
  var url = Uri.https(
    "api.odcloud.kr",
    '/api/15077586/v1/centers?serviceKey=${ApiKey.API_KEY}',
  );
  print(url.toString());
  // var url = 'https://example.com/whatsit/create';

  var response = await http.get(url);
  // Await the http get response, then decode the json-formatted response.

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    // var itemCount = jsonResponse['totalItems'];
    print('Number of books about http: $jsonResponse.');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future<VaccineCount?> fetchVaccineCount(int start, int endPage, String? baseDate) async {
  if(baseDate == null){
    baseDate =  DateFormat("yyyy-MM-dd 00:00:00").format(DateTime.now());
  }
  var url = Uri.parse("https://api.odcloud.kr/api/15077756/v1/vaccine-stat?page=${start}&perPage=${endPage}"
      "&cond%5BbaseDate%3A%3AEQ%5D=$baseDate&serviceKey=${ApiKey.API_KEY_2}");
  var response = await http
      .get(url);
  print(response.body);
  if (response.statusCode == 200) {
    VaccineCount vaccineCount = VaccineCount.fromJson(jsonDecode(response.body));
    return vaccineCount;
  }else{
    return null;
  }
}

Future<VaccineCount?> fetchVaccineCountBySido(int start, int endPage, String sido) async {
  var url = Uri.parse("https://api.odcloud.kr/api/15077756/v1/vaccine-stat?page=${start}&perPage=${endPage}"
      "&cond%5Bsido%3A%3AEQ%5D=$sido&serviceKey=${ApiKey.API_KEY_2}");
  var response = await http
      .get(url);
  print("시도: ${response.body}");
  if (response.statusCode == 200) {
    VaccineCount vaccineCount = VaccineCount.fromJson(jsonDecode(response.body));
    return vaccineCount;
  }else{
    return null;
  }
}