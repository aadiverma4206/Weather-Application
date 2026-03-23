import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class ApiService {
  static Future<WeatherModel> fetchWeather(String city) async {
    // Delhi coordinates (example)
    final url =
        "https://api.open-meteo.com/v1/forecast?latitude=28.61&longitude=77.23&current=temperature_2m";

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    return WeatherModel(
      city: city,
      temp: data["current"]["temperature_2m"].toDouble(),
      condition: "Clear",
    );
  }
}