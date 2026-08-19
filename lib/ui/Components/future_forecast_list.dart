import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/weather_model.dart';

class FutureForecastListItem extends StatelessWidget {
  final Forecastday? forecastday;
  const FutureForecastListItem({super.key, required this.forecastday});

  @override
  Widget build(BuildContext context) {
    if (forecastday == null) return const SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.all(8),
      width: double.infinity,

      child: Row(
        children: [
          Image.network("https:${forecastday?.day?.condition?.icon}", width: 50),
          const SizedBox(width: 5),
          Expanded(
            flex: 2,
            child: Text(
              DateFormat.MMMEd().format(
                DateTime.parse(forecastday?.date ?? "Unknown"),
              ),
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              forecastday?.day?.condition?.text.toString() ?? "",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              "^${forecastday?.day?.maxtempC?.round()}°/${forecastday?.day?.mintempC?.round()}°",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
