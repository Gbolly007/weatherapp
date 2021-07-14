

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/bloc/search_weather_event.dart';
import 'package:weather_app/bloc/search_weather_state.dart';

import 'package:weather_app/models/search_weather.dart';

import 'package:weather_app/repository/weather_repository.dart';

class SearchWeatherBloc extends Bloc<SearchWeatherEvent, SearchWeatherState>{

  final WeatherRepository weatherRepository;

  SearchWeatherBloc({required this.weatherRepository}) : super(WeatherIsNotSearched());




  @override
  Stream<SearchWeatherState> mapEventToState(SearchWeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final SearchWeather weather = await weatherRepository.getSearchWeather(
          city: event.city!,

        );
        yield WeatherLoaded(weather: weather);
      } catch (exception) {
        print(exception);
        if (exception is HTTPException) {
          yield WeatherError(errorCode: exception.code);
        } else {
          yield WeatherError(errorCode: 500);
        }
      }
    } else if(event is ResetWeather){
      yield WeatherIsNotSearched();
    }
  }

}