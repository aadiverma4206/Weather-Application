class WeatherModel {
  final String city;
  final double temp;
  final String condition;

  WeatherModel({
    required this.city,
    required this.temp,
    required this.condition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'],
      temp: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'],
    );
  }
}