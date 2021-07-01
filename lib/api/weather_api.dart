import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class WeatherApiClient {
  static const baseUrl = 'http://api.openweathermap.org';
  final apiKey;
  final http.Client httpClient;

  WeatherApiClient({required this.httpClient, this.apiKey})
      : assert(apiKey != null);

  Uri _buildUri(String endpoint, Map<String, dynamic> queryParameters) {
    var query = {'appid': apiKey};
    query = query..addAll(queryParameters);

    var uri = Uri(
      scheme: 'http',
      host: 'api.openweathermap.org',
      path: 'data/2.5/$endpoint',
      queryParameters: query,
    );

    print('fetching $uri');

    return uri;
  }

  Future<String> getCityNameFromLocation(
      {required double latitude, required double longitude}) async {
    final uri = _buildUri('weather', {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
    });

    final res = await this.httpClient.get(uri);

    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }

    final weatherJson = json.decode(res.body);
    return weatherJson['name'];
  }

  Future<List<Weather>> get7Day(
      {required double latitude, required double longitude}) async {
    final uri = _buildUri('onecall', {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'exclude': 'hourly,current,minutely,alerts'
    });

    final res = await this.httpClient.get(uri);

    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }

    final weatherJson = json.decode(res.body);
    return Weather.from7DayJson(weatherJson['daily']);
  }

  Future<Weather> getWeatherData(String cityName) async {
    final uri = _buildUri('weather', {'q': cityName});

    final res = await this.httpClient.get(uri);

    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }

    final weatherJson = json.decode(res.body);
    return Weather.fromJson(weatherJson);
  }
}

class HTTPException implements Exception {
  final int code;
  final String message;

  HTTPException(this.code, this.message);

  @override
  String toString() {
    return 'HTTPException{code: $code, message: $message}';
  }
}
