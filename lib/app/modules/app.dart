import 'package:flutter/material.dart';
import 'package:skywatch/app/modules/app_dependencies.dart';
import 'package:skywatch/app/modules/main_screen/presentation/pages/main_page.dart';
import 'package:skywatch/app/modules/video/presentation/pages/camera/camera_page.dart';
import 'package:skywatch/app/modules/video/presentation/pages/videos/video_list_page.dart';
import 'package:skywatch/app/modules/weather/presentation/forecast/pages/forecast_page.dart';
import 'package:skywatch/app/modules/weather/presentation/weather/pages/weather_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/' : (context) =>  const MainPage(),
        '/weather': (context) => WeatherPage(bloc: DependencyHandler().get(),),
        '/weather/forecast': (context) => ForecastPage(bloc: DependencyHandler().get(),),
        '/camera': (context) => const CameraPage(),
        '/video_list': (context) => VideoListPage(bloc: DependencyHandler().get(),),
      },
    );
  }
}