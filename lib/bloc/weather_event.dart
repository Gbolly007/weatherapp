import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final double? longitude;
  final double? latitude;

  FetchWeather({ this.longitude, this.latitude})
      : assert(longitude != null || latitude != null);

  @override
  List<Object?> get props => [ longitude, latitude];
}

