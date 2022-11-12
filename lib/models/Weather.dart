class Weather {
  final double temp;
  final double feelslike;
  final double low;
  final double high;
  final String description;

  Weather({
    required this.temp,
    required this.feelslike,
    required this.low,
    required this.high,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toDouble(),
      feelslike: json['main']['feels_like'].toDouble(),
      low: json['main']['temp_min'].toDouble(),
      high: json['main']['temp_max'].toDouble(),
      description: json['weather'][0]['description'].toString(),
    );
  }
}
