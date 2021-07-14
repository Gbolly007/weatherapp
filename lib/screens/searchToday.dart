import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/bloc/search_weather_bloc.dart';
import 'package:weather_app/bloc/search_weather_event.dart';
import 'package:weather_app/bloc/search_weather_state.dart';
import 'package:weather_app/models/search_weather.dart';
import 'package:weather_app/screens/today.dart';
import 'package:weather_app/searchField.dart';

import '../constants.dart';

class SearchToday extends StatelessWidget {
  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }

  final TextEditingController txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<SearchWeatherBloc>(context);
    return Scaffold(
      body: ListView(
        children: [
          BlocBuilder<SearchWeatherBloc, SearchWeatherState>(
              builder: (context, state) {
            if (state is WeatherIsNotSearched)
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xfff5f8fd),
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: <Widget>[
                      SearchField(txt: txt),
                      InkWell(
                        onTap: () async {
                          weatherBloc.add(FetchWeather(city: txt.text));
                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            else if (state is WeatherLoading)
              return Center(child: CircularProgressIndicator());
            else if (state is WeatherLoaded)
              return ListView(shrinkWrap: true, children: [
                Container(
                  color: kGeneralColor,
                  height: MediaQuery.of(context).size.height * 0.6,
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
                            GestureDetector(
                                onTap: (){
                                  weatherBloc.add(ResetWeather());
                                },
                                child: Icon(Icons.search,color: Colors.white,))
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
                          state.weather.temperature!.celsius
                                  .toStringAsFixed(0) +
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
                                WeatherIconWidget(
                                  icn: FontAwesomeIcons.temperatureLow,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(feelslikeText,
                                        style: weatherDataStyle),
                                    Text(
                                      state.weather.feelsLike!.celsius
                                              .toStringAsFixed(0) +
                                          '°C',
                                      style: weatherValueStyle,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                WeatherIconWidget(
                                  icn: FontAwesomeIcons.tint,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(humidityText, style: weatherDataStyle),
                                    Text(
                                      state.weather.humidity!
                                              .toStringAsFixed(0) +
                                          ' %',
                                      style: weatherValueStyle,
                                    )
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
                                WeatherIconWidget(
                                  icn: FontAwesomeIcons.wind,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(windText, style: weatherDataStyle),
                                    Text(
                                      state.weather.windSpeed.toString() +
                                          ' km/h',
                                      style: weatherValueStyle,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                WeatherIconWidget(
                                  icn: FontAwesomeIcons.stopwatch,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(pressureText, style: weatherDataStyle),
                                    Text(
                                      state.weather.pressure.toString() + ' Pa',
                                      style: weatherValueStyle,
                                    )
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
              ]);
            else
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: GestureDetector(
                  onTap: (){
                    weatherBloc.add(ResetWeather());
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Text(
                      "Location, not found. Click to search again",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              );
          }),
        ],
      ),
    );
  }
}
