import 'package:flutter/material.dart';

class Weather {
  int? id;
  int? time;
  int? sunrise;
  int? sunset;
  int? humidity;
  int? pressure;

  String? description;
  String? iconCode;
  String? main;
  String? cityName;

  double? windSpeed;

  Temperature? temperature;
  Temperature? maxTemperature;
  Temperature? minTemperature;
  Temperature? feelsLike;
  List<Weather>? forecast;

  Weather({
    this.id,
    this.time,
    this.sunrise,
    this.sunset,
    this.humidity,
    this.pressure,
    this.description,
    this.iconCode,
    this.main,
    this.cityName,
    this.windSpeed,
    this.temperature,
    this.maxTemperature,
    this.minTemperature,
    this.feelsLike,
    this.forecast,
  });

  static Weather fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return Weather(
      id: weather['id'],
      time: json['dt'],
      description: weather['description'],
      iconCode: weather['icon'],
      main: weather['main'],
      cityName: json['name'],
      temperature: Temperature(intToDouble(json['main']['temp'])),
      maxTemperature: Temperature(intToDouble(json['main']['temp_max'])),
      minTemperature: Temperature(intToDouble(json['main']['temp_min'])),
      feelsLike: Temperature(intToDouble(json['main']['feels_like'])),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      windSpeed: intToDouble(json['wind']['speed']),
    );
  }

  static List<Weather> from7DayJson(json) {
    final weathers = <Weather>[];
    for (final item in json) {
      weathers.add(
        Weather(
          maxTemperature: Temperature(intToDouble(item['temp']['max'])),
          minTemperature: Temperature(intToDouble(item['temp']['min'])),
          time: item['dt'],
          iconCode: item['weather'][0]['icon'],
          main: item['weather'][0]['main'],
          description: item['weather'][0]['description'],
        ),
      );
    }
    return weathers;
  }

  IconData getIconData() {
    switch (this.iconCode) {
      case '01d':
        return WeatherIcons.clear_day;
      case '01n':
        return WeatherIcons.clear_night;
      case '02d':
        return WeatherIcons.few_clouds_day;
      case '02n':
        return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d':
        return WeatherIcons.shower_rain_day;
      case '09n':
        return WeatherIcons.shower_rain_night;
      case '10d':
        return WeatherIcons.rain_day;
      case '10n':
        return WeatherIcons.rain_night;
      case '11d':
        return WeatherIcons.thunder_storm_day;
      case '11n':
        return WeatherIcons.thunder_storm_night;
      case '13d':
        return WeatherIcons.snow_day;
      case '13n':
        return WeatherIcons.snow_night;
      case '50d':
        return WeatherIcons.mist_day;
      case '50n':
        return WeatherIcons.mist_night;
      default:
        return WeatherIcons.clear_day;
    }
  }
}

intToDouble(dynamic val) {
  if (val.runtimeType == double) {
    return val;
  } else if (val.runtimeType == int) {
    return val.toDouble();
  } else {
    throw new Exception("value is not of type 'int' or 'double' got type '" +
        val.runtimeType.toString() +
        "'");
  }
}

class _IconData extends IconData {
  const _IconData(int codePoint)
      : super(
    codePoint,
    fontFamily: 'WeatherIcons',
  );
}

enum TemperatureUnit { kelvin, celsius, fahrenheit }

class Temperature {
  final double _kelvin;

  Temperature(this._kelvin);

  double get kelvin => _kelvin;

  double get celsius => _kelvin - 273.15;

  double get fahrenheit => _kelvin * (9 / 5) - 459.67;

  double as(TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.kelvin:
        return this.kelvin;
      case TemperatureUnit.celsius:
        return this.celsius;
      case TemperatureUnit.fahrenheit:
        return this.fahrenheit;
    }
  }
}

class WeatherIcons {
  static const IconData clear_day = const _IconData(0xf00d);
  static const IconData clear_night = const _IconData(0xf02e);

  static const IconData few_clouds_day = const _IconData(0xf002);
  static const IconData few_clouds_night = const _IconData(0xf081);

  static const IconData clouds_day = const _IconData(0xf07d);
  static const IconData clouds_night = const _IconData(0xf080);

  static const IconData shower_rain_day = const _IconData(0xf009);
  static const IconData shower_rain_night = const _IconData(0xf029);

  static const IconData rain_day = const _IconData(0xf008);
  static const IconData rain_night = const _IconData(0xf028);

  static const IconData thunder_storm_day = const _IconData(0xf010);
  static const IconData thunder_storm_night = const _IconData(0xf03b);

  static const IconData snow_day = const _IconData(0xf00a);
  static const IconData snow_night = const _IconData(0xf02a);

  static const IconData mist_day = const _IconData(0xf003);
  static const IconData mist_night = const _IconData(0xf04a);
}