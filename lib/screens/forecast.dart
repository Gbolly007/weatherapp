import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/bloc/weather_state.dart';

import '../constants.dart';

class ForcastScreen extends StatelessWidget {
  ForcastScreen({Key? key}) : super(key: key);
  String formatTimestamp(int timestamp) {
    var format = new DateFormat('d MMM, hh:mm a');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    var weekday = date.weekday;
    String dayText = "";

    switch(weekday) {
      case 1:
        dayText = "Mon";
        break;
      case 2:
        dayText = "Tue";
        break;
      case 3:
        dayText = "Wed";
        break;
      case 4:
        dayText = "Thu";
        break;
      case 5:
        dayText = "Fri";
        break;
      case 6:
        dayText = "Sat";
        break;
      case 7:
        dayText = "Sun";
        break;
      default:
        dayText= "";
    }

    return dayText;
  }

  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoaded) {
          return Column(
            children: [
              Container(
                color: forecastColor,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.menu,color: Colors.white,),
                          Icon(Icons.search,color: Colors.white,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                state.weather.cityName!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: fontfamilytext,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                dte(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: fontfamilytext,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                capitalize(state.weather.description!),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: fontfamilytext,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            state.weather.getIconData(),
                            color: Colors.white,
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        state.weather.temperature!.celsius.toStringAsFixed(0) +
                            '°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: fontfamilytext,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: state.weather.forecast!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          state.weather.getIconData(),
                          size: 40,
                        ),
                        Text(
                            formatTimestamp(state.weather.forecast![index].time!)
                                .toString()),
                        Text(state.weather.forecast![index].maxTemperature!.celsius
                            .toStringAsFixed(0) +
                            '°/' +
                            state.weather.forecast![index].minTemperature!.celsius
                                .toStringAsFixed(0)+
                            '°',style:weatherValueStyle ),
                        Text(capitalize(state.weather.forecast![index].description!)
                          ,style: weatherDataStyle,),
                      ],
                    ),

                  ),
                ),
              ),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}