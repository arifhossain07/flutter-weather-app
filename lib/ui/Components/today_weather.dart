import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import '../../model/weather_model.dart';
import 'package:intl/intl.dart';

class TodayWeather extends StatelessWidget {
  final WeatherModel? weatherModel;
  const TodayWeather({super.key, this.weatherModel});

  WeatherType getWeatherType(Current? current) {
    if (current?.isDay == 1) {
      if (current?.condition?.text?.toLowerCase() == "Sunny") {
        return WeatherType.sunny;
      }
      if (current?.condition?.text?.toLowerCase() == "Clear") {
        return WeatherType.sunny;
      }
      if (current?.condition?.text?.toLowerCase() == "Partly cloudy") {
        return WeatherType.cloudy;
      }
      if (current?.condition?.text?.toLowerCase() == "Overcast") {
        return WeatherType.cloudy;
      }
      if (current?.condition?.text?.toLowerCase() == "Mist") {
        return WeatherType.lightSnow;
      }
      if (current?.condition?.text?.toLowerCase() == "thunder") {
        return WeatherType.thunder;
      }
      if (current?.condition?.text?.toLowerCase() == "rain") {
        return WeatherType.heavyRainy;
      }
      if (current?.condition?.text?.toLowerCase() == "showers") {
        return WeatherType.middleSnow;
      }
      if (current?.condition?.text?.toLowerCase() == "cloudy") {
        return WeatherType.cloudy;
      }
    } else {
      if (current?.condition?.text?.toLowerCase() == "Sunny") {
        return WeatherType.sunny;
      }
      if (current?.condition?.text?.toLowerCase() == "Clear") {
        return WeatherType.sunnyNight;
      }
      if (current?.condition?.text?.toLowerCase() == "Partly cloudy") {
        return WeatherType.cloudyNight;
      }
      if (current?.condition?.text?.toLowerCase() == "Overcast") {
        return WeatherType.cloudy;
      }
      if (current?.condition?.text?.toLowerCase() == "Mist") {
        return WeatherType.lightSnow;
      }
      if (current?.condition?.text?.toLowerCase() == "thunder") {
        return WeatherType.thunder;
      }
      if (current?.condition?.text?.toLowerCase() == "rain") {
        return WeatherType.heavyRainy;
      }
      if (current?.condition?.text?.toLowerCase() == "showers") {
        return WeatherType.middleSnow;
      }
      if (current?.condition?.text?.toLowerCase() == "cloudy") {
        return WeatherType.cloudyNight;
      }
    }

    return WeatherType.sunny;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        WeatherBg(
          weatherType: getWeatherType(weatherModel?.current),
          width: width,
          height: 300,
        ),
        SizedBox(
          width: width,
          height: 300,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "${weatherModel?.location?.name ?? "Unknown"}, ${weatherModel?.location?.country ?? "Unknown"}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      weatherModel?.current?.lastUpdated != null
                          ? DateFormat.yMMMMEEEEd().format(
                        DateTime.parse(weatherModel!.current!.lastUpdated!),
                      )
                          : "Unknown",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white10,
                    ),
                    child: Image.network(
                      "https:${weatherModel?.current?.condition?.icon ?? "Unknown"}",
                    ),
                  ),
                  Spacer(),

                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              weatherModel?.current?.tempC
                                      ?.round()
                                      .toString() ??
                                  "Unknown",
                              style: TextStyle(
                                fontSize: 70,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                height: 1.0,
                              ),
                            ),
                          ),
                          Text(
                            "o",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        weatherModel?.current?.condition?.text ?? "Unknown",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Feels Like",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              "${weatherModel?.current?.feelslikeC?.round() ?? "Unknown"}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Wind",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              "${weatherModel?.current?.windKph?.round() ?? "Unknown"} km/h",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Humidity",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              "${weatherModel?.current?.humidity?.round() ?? "Unknown"}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Visibility",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              "${weatherModel?.current?.visKm?.round() ?? "Unknown"} km",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
