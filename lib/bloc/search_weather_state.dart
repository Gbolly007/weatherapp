

import 'package:equatable/equatable.dart';
import 'package:weather_app/models/search_weather.dart';

abstract class SearchWeatherState extends Equatable {
  SearchWeatherState();

  @override
  List<Object> get props => [];
}

class WeatherIsNotSearched extends SearchWeatherState{

}

class WeatherIsNotLoaded extends SearchWeatherState{

}

class WeatherEmpty extends SearchWeatherState {}

class WeatherLoading extends SearchWeatherState {}

class WeatherLoaded extends SearchWeatherState {
  final SearchWeather weather;
  WeatherLoaded({required this.weather});

  @override
  List<Object> get props => [weather];
}

class WeatherError extends SearchWeatherState {
  final int errorCode;

  WeatherError({required this.errorCode});

  @override
  List<Object> get props => [errorCode];
}