import 'dart:convert';

import 'package:covid_19_vaccine_korea/src/model/vaccine_center.dart';
import 'package:covid_19_vaccine_korea/src/service/api_key.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

void getHttp() async {
  try {
    Response response = await Dio().get("http://www.google.com");
    print(response);
  } catch (e) {
    print(e);
  }
}

Future<VaccineCenter?> fetchVaccineCenterV2() async {
  try {
    Response response = await Dio().get(
        "https://api.odcloud.kr/api/15077586/v1/centers?serviceKey=${ApiKey.API_KEY}");
    print(response);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.toString());
      print('Number of books about http: $jsonResponse.');
      VaccineCenter vaccineCenter = VaccineCenter.fromJson(jsonDecode(response.toString()));
      // var itemCount = jsonResponse['totalItems'];
      print(vaccineCenter.currentCount);
      return vaccineCenter;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  } catch (e) {
    print(e);
  }

}

Future fetchVaccineCenter() async {
  var baseUrl =
      "https://api.odcloud.kr/api/15077586/v1/centers?serviceKey=8wT9G7eD%2BJCQbT%2FxtyXjoAXk9bdAOc9qQ7063cXg2pAuwt3OUxM3vo4xR%2Bw%2BCrtHN%2B48iZCTEQkSla3rAmX3ig%3D%3D";
  var url = Uri.https(
    "api.odcloud.kr",
    '/api/15077586/v1/centers?serviceKey=8wT9G7eD%2BJCQbT%2FxtyXjoAXk9bdAOc9qQ7063cXg2pAuwt3OUxM3vo4xR%2Bw%2BCrtHN%2B48iZCTEQkSla3rAmX3ig%3D%3D',
    //   {'serviceKey': '''8wT9G7eD%2BJCQbT%2FxtyXjoAXk9bdAOc9qQ7063cXg2pAuwt3OUxM3vo4xR%2Bw%2BCrtHN%2B48iZCTEQkSla3rAmX3ig%3D%3D''',
    // "page" : "1",
    // "perPage" : "10"},
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
