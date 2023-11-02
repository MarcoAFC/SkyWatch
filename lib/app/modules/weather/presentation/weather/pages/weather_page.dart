import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skywatch/app/core/widgets/failure_widget.dart';
import 'package:skywatch/app/core/widgets/text/text_subtitle.dart';
import 'package:skywatch/app/core/widgets/text/text_title.dart';

import 'package:skywatch/app/modules/weather/presentation/weather/pages/bloc/weather_bloc.dart';
import 'package:skywatch/app/modules/weather/presentation/weather/pages/bloc/weather_event.dart';
import 'package:skywatch/app/modules/weather/presentation/weather/pages/bloc/weather_state.dart';
import 'package:skywatch/app/modules/weather/presentation/weather/widgets/weather_card_widget.dart';

class WeatherPage extends StatelessWidget {
  WeatherPage({
    Key? key,
    required this.bloc,
  }) : super(key: key){
    bloc.add(GetWeatherEvent(lat: '41.8781', lon: '-87.6298'));
  }
  final WeatherBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextTitle(text: "Current Weather"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            BlocBuilder<WeatherBloc, WeatherState>(
                bloc: bloc,
                builder: (context, snapshot) {
                  if (snapshot is WeatherSuccessState) {
                    return WeatherCardWidget(
                        weather: snapshot.weather, name: "Chicago");
                  }
                  if (snapshot is WeatherFailureState) {
                    return FailureWidget(text: snapshot.failure.message);
                  }
                  if (snapshot is WeatherLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const SizedBox.shrink();
                }),
            const SizedBox(
              height: 24.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/weather/forecast');
                },
                child: const TextSubtitle(text: "See forecast"))
          ],
        ),
      ),
    );
  }
}
