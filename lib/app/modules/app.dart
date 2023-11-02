import 'package:flutter/material.dart';
import 'package:skywatch/app/modules/main_screen/presentation/pages/main_page.dart';
import 'package:skywatch/app/modules/video/presentation/pages/camera_page.dart';
import 'package:skywatch/app/modules/weather/presentation/forecast/pages/forecast_page.dart';
import 'package:skywatch/app/modules/weather/presentation/weather/pages/weather_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/' : (context) =>  const MainPage(),
        '/weather': (context) => const WeatherPage(),
        '/weather/forecast': (context) => const ForecastPage(),
        '/camera': (context) => const CameraPage(),
      },
    );
  }
}