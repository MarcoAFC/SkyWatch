import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skywatch/app/core/widgets/failure_widget.dart';
import 'package:skywatch/app/core/widgets/text/text_title.dart';
import 'package:skywatch/app/modules/weather/presentation/forecast/pages/bloc/forecast_bloc.dart';
import 'package:skywatch/app/modules/weather/presentation/forecast/pages/bloc/forecast_event.dart';
import 'package:skywatch/app/modules/weather/presentation/forecast/pages/bloc/forecast_state.dart';
import 'package:skywatch/app/modules/weather/presentation/forecast/widgets/forecast_carousel_widget.dart';

class ForecastPage extends StatelessWidget {
  ForecastPage({super.key, required this.bloc}) {
    bloc.add(GetForecastEvent(lat: '41.8781', lon: '-87.6298'));
  }
  final ForecastBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextTitle(text: "Forecast"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: BlocBuilder<ForecastBloc, ForecastState>(
            bloc: bloc,
            builder: (context, snapshot) {
              if (snapshot is ForecastSuccessState) {
                return ForecastCarouselWidget(items: snapshot.forecast);
              }
              if (snapshot is ForecastFailureState) {
                return FailureWidget(text: snapshot.failure.message);
              }
              if (snapshot is ForecastLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }
}
