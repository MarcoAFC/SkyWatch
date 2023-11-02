import 'package:flutter/material.dart';
import 'package:skywatch/app/core/widgets/text/text_body.dart';
import 'package:skywatch/app/core/widgets/text/text_subtitle.dart';
import 'package:skywatch/app/modules/weather/domain/entities/forecast.dart';

class ForecastCardWidget extends StatelessWidget {
  final Forecast forecast;

  const ForecastCardWidget({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color(0xFF0099FF),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextSubtitle(text: forecast.weatherConditions),
                  const SizedBox(
                    height: 4.0,
                  ),
                  TextBody(
                    text: '${forecast.minTemperature} ºC ~ ${forecast.maxTemperature} ºC ',
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  TextBody(
                    text: forecast.description,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Image.network(
              "https://openweathermap.org/img/wn/${forecast.icon}.png",
              errorBuilder: (context, _, __) {
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
