import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/bloc/weather_state.dart';

import '../constants.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({Key? key}) : super(key: key);

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
          return ListView(
            children: [
              Container(
                color: kGeneralColor,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              WeatherIconWidget(icn: FontAwesomeIcons.temperatureLow,),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    feelslikeText,
                                    style: weatherDataStyle
                                  ),
                                  Text(state.weather.feelsLike!.celsius
                                      .toStringAsFixed(0)+
                                      '°C',
                                    style: weatherValueStyle,)
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              WeatherIconWidget(icn: FontAwesomeIcons.tint,),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(humidityText,style: weatherDataStyle),
                                  Text(state.weather.humidity!.toStringAsFixed(0)+
                                      ' %',style: weatherValueStyle,)
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(

                            children: [
                              WeatherIconWidget(icn: FontAwesomeIcons.wind,),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(windText,style: weatherDataStyle),
                                  Text(state.weather.windSpeed.toString()+
                                  ' km/h',style: weatherValueStyle,)
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              WeatherIconWidget(icn: FontAwesomeIcons.stopwatch,),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(pressureText,style: weatherDataStyle),
                                  Text(state.weather.pressure.toString()+
                                      ' Pa',style: weatherValueStyle,)
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
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

class WeatherIconWidget extends StatelessWidget {
  const WeatherIconWidget({

    required this.icn
  });

  final IconData icn;

  @override
  Widget build(BuildContext context) {
    return Icon(icn,
        size: 25.0, color: Colors.grey[800]);
  }
}
