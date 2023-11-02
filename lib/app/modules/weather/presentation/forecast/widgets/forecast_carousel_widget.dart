import 'package:flutter/material.dart';
import 'package:skywatch/app/modules/weather/domain/entities/forecast.dart';
import 'package:skywatch/app/modules/weather/presentation/forecast/widgets/forecast_card_widget.dart';

class ForecastCarouselWidget extends StatelessWidget {
  const ForecastCarouselWidget({super.key, required this.items});
  final List<Forecast> items;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: PageView.builder(
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        padEnds: false,
        controller: PageController(
          viewportFraction: 0.5,
          initialPage: 0
        ),
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ForecastCardWidget(forecast: items[index]),
          );
        }),
    );
  }
}