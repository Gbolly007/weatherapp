import 'package:equatable/equatable.dart';

abstract class SearchWeatherEvent extends Equatable {
  SearchWeatherEvent();
}

class FetchWeather extends SearchWeatherEvent{
  final String? city;

  FetchWeather({ this.city})
      : assert(city != null);

  @override
  List<Object?> get props => [ city];
}

class ResetWeather extends SearchWeatherEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}