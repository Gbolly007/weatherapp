
import 'package:weather_app/api/weather_api.dart';
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

//   Set getMinMax(List<Weather> weathers) {
//     final allmaxTemps = [];
//     final allminTemps = [];
//     final maxTemps = [];
//     final minTemps = [];
//     for (final item in weathers) {
//       allmaxTemps.add(item.maxTemperature);
//       allminTemps.add(item.minTemperature);
//     }
//     Map<int, List> hours = {
//       0: [0, 2],
//       1: [3, 5],
//       2: [6, 8],
//       3: [9, 11],
//       4: [12, 14],
//       5: [15, 17],
//       6: [18, 20],
//       7: [21, 23],
//     };

//     hours.forEach((key, value) {
//       for (var i = value[0]; i < value[1]; i++) {
//         maxTemps.add(allmaxTemps
//             .getRange(value[0], value[1])
//             .toList()
//             .reduce((current, next) {
//           return current.celsius.toInt() > next.celsius.toInt()
//               ? current
//               : next;
//         }));
//         minTemps.add(allminTemps
//             .getRange(value[0], value[1])
//             .toList()
//             .reduce((current, next) {
//           return current.celsius.toInt() < next.celsius.toInt()
//               ? current
//               : next;
//         }));
//         break;
//       }
//     });

// // Goes through all the max temps for day 1 and adds max/min to the list
//     // maxTemps.add(allmaxTemps.getRange(0, 7).toList().reduce((current, next) {
//     //   return current.celsius.toInt() > next.celsius.toInt() ? current : next;
//     // }));
//     // minTemps.add(allminTemps.getRange(0, 7).toList().reduce((current, next) {
//     //   return current.celsius.toInt() < next.celsius.toInt() ? current : next;
//     // }));

//     return {maxTemps, minTemps};
//   }
}