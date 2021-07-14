import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/screens/forecast.dart';
import 'package:weather_app/screens/today.dart';

import 'api/weather_api.dart';
import 'bloc/weather_bloc.dart';
import 'bloc/weather_event.dart' as we;
import 'bloc/search_weather_bloc.dart';
import 'bloc/search_weather_event.dart';
import 'constants.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (context) => WeatherBloc(
            weatherRepository: WeatherRepository(
              weatherApiClient:
              WeatherApiClient(httpClient: http.Client(), apiKey: apiKey),
            ),
          ),
        ),
        BlocProvider(
            create: (context) => SearchWeatherBloc(
                weatherRepository: WeatherRepository(
                  weatherApiClient: WeatherApiClient(
                      httpClient: http.Client(), apiKey: apiKey),
                ))),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        home: MyStatefulWidget(),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    _fetchWeatherWithLocation().catchError((error) {
      print(error);
    });
  }

  _fetchWeatherWithLocation() async {
    var permissionResult = await Permission.locationWhenInUse.status;

    switch (permissionResult) {
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        print('location permission denied');
        _showLocationDeniedDialog();
        break;

      case PermissionStatus.denied:
        await Permission.locationWhenInUse.request();
        _fetchWeatherWithLocation();
        break;

      case PermissionStatus.limited:
      case PermissionStatus.granted:
        print('getting location');
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low,
            timeLimit: Duration(seconds: 2));

        print(position.toString());

        _weatherBloc.add(we.FetchWeather(
          longitude: position.longitude,
          latitude: position.latitude,
        ));
        break;
    }
  }

  void _showLocationDeniedDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Location is disabled :(',
                style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              TextButton(
                child: Text('Enable!'),
                style: TextButton.styleFrom(
                  elevation: 1,
                ),
                onPressed: () {
                  openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    TodayScreen(),
    ForcastScreen(),
    ForcastScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottomNavColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: todayText,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wysiwyg_outlined),
            label: weeklyText,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: shareText,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: activecolor,
        onTap: _onItemTapped,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
