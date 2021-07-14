
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/models/search_weather.dart';
import 'package:weather_app/models/weather.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;
  WeatherRepository({required this.weatherApiClient});

  Future<Weather> getWeather(
      {required double latitude, required double longitude}) async {
    String? cityName;
    if (cityName == null) {
      cityName = await weatherApiClient.getCityNameFromLocation(
          latitude: latitude, longitude: longitude);
    }
    var weather = await weatherApiClient.getWeatherData(cityName);
    var weathers = await weatherApiClient.get7Day(
        latitude: latitude, longitude: longitude);
    weather.forecast = weathers;
    // getMinMax(weathers);
    return weather;
  }

  Future<SearchWeather> getSearchWeather({required String city}) async{
    var weather = await weatherApiClient.getSearchWeatherData(city);

    var weathers = await weatherApiClient.getSearch7Day(
        latitude: weather.lat, longitude: weather.lat);

    weather.forecast = weathers;

    return weather;
  }



}