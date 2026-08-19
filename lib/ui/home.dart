import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/api_service.dart';
import 'Components/future_forecast_list.dart';
import 'Components/hourly_weather_list.dart';
import 'Components/today_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();

  final _textController = TextEditingController();
  String _searchText = "auto:ip";

  void _showTextInputDialog(BuildContext context) {
     showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Search Location"),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: "Search City"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  setState(() {
                    _searchText = _textController.text;
                  });
                }
                _textController.clear();
                Navigator.pop(context);
              },
              child: const Text("Search"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Flutter Weather App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _showTextInputDialog(context);
            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _searchText = "auto:ip";
              });
            },
            icon: const Icon(Icons.my_location, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: apiService.getWeatherData(_searchText),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModel? weatherModel = snapshot.data;
              return SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      TodayWeather(weatherModel: weatherModel),
                      const SizedBox(height: 10),
                      const Text(
                        "Weather By Hours",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            Hour? hour = weatherModel
                                ?.forecast
                                ?.forecastday?[0]
                                .hour?[index];
                            return HourlyWeatherList(hour: hour);
                          },
                          itemCount:
                              weatherModel
                                  ?.forecast
                                  ?.forecastday?[0]
                                  .hour
                                  ?.length ??
                              0,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Next 7 Days Weather",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final forecastday= weatherModel?.forecast?.forecastday?[index];
                          return FutureForecastListItem(forecastday: forecastday);
                        },
                        itemCount:
                            weatherModel?.forecast?.forecastday?.length ?? 0,
                      ),
                    ],
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Error has occurred or City not found",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
