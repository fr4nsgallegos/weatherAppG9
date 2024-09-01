import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  String apiKey = "70866d7ade244a3c9ca20142230509";

  getWeatherInfo() async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=cusco&aqi=no");

    http.Response response = await http.get(url);
    print(response.statusCode);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      // print(response.body);
      print(data["location"]["country"]);
      return data;
    }
    return null;
  }
}
