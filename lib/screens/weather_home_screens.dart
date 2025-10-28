import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherHomeScreens extends StatefulWidget {
  WeatherHomeScreens({super.key});

  @override
  State<WeatherHomeScreens> createState() => _WeatherHomeScreensState();
}

class _WeatherHomeScreensState extends State<WeatherHomeScreens> {
  Position? currentposition;
  Map<String, dynamic>? weatherapp;
  Map<String, dynamic>? forcuatapp;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    currentposition = await Geolocator.getCurrentPosition();
    print(
      "latitude: ${currentposition!.latitude}, longitude: ${currentposition!.longitude}",
    );

    getcurrentweather();
    getforcustweather();
  }

  getcurrentweather() async {
    String weatherurl =
        "https://api.openweathermap.org/data/2.5/weather?lat=${currentposition!.latitude}&lon=${currentposition!.longitude}&appid=9cb7350152e16a1b968c0a2caf9c57c0&units=metric";

    var response = await http.get(Uri.parse(weatherurl));

    print("Response: ${response.body}");

    forcuatapp = Map<String, dynamic>.from(jsonDecode(response.body));

    setState(() {});
  }

  getforcustweather() async {
    String forcustrurl =
       " https://pro.openweathermap.org/data/2.5/forecast/climate?lat=${currentposition!.latitude}&lon=${currentposition!.longitude}&appid=9cb7350152e16a1b968c0a2caf9c57c0";
    var response = await http.get(Uri.parse(forcustrurl));

    print("Response: ${response.body}");

    weatherapp = Map<String, dynamic>.from(jsonDecode(response.body));

    setState(() {});
  }

  /// Function to format local time from API data
  String formatWeatherTime(Map<String, dynamic> data) {
    int dt = data["dt"];
    int timezoneOffset = data["timezone"];
    // Convert UTC timestamp to DateTime
    DateTime utcTime = DateTime.fromMillisecondsSinceEpoch(
      dt * 1000,
      isUtc: true,
    );
    // Apply timezone offset
    DateTime locationTime = utcTime.add(Duration(seconds: timezoneOffset));
    return DateFormat('hh:mm a, dd MMM yyyy').format(locationTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: weatherapp == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  flex: 15,
                  child: Container(
                    width: double.infinity,

                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xff1f4d90),
                          Color(0xff6587bb),
                          Color(0xff334c72),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "📍 ${weatherapp!["name"]}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              const SizedBox(height: 5),
                              Icon(Icons.notification_add),
                              SizedBox(width: 10),
                              Icon(Icons.menu),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${formatWeatherTime(weatherapp!)}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Image.network(
                                "https://openweathermap.org/img/wn/${weatherapp!["weather"][0]["icon"]}@4x.png",
                                color: Colors.deepOrange,
                                scale: 1.0,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${weatherapp!["main"]["temp"]}",
                                style: TextStyle(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "height : ${weatherapp!["main"]["temp_min"]}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Low: ${weatherapp!["main"]["temp_max"]}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsetsGeometry.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.black54,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 15),

                        Expanded(
                          child: Text(
                            '''
                     humidity:${weatherapp!["main"]["humidity"]}''',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          margin: EdgeInsetsGeometry.symmetric(vertical: 10),
                          height: double.infinity,
                          width: 3,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            '''Wind: ${weatherapp!["wind"]["speed"]} ''',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          margin: EdgeInsetsGeometry.symmetric(vertical: 10),
                          height: double.infinity,
                          width: 3,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  flex: 7,
                  child: Container(

                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(8),
                      itemCount: forcuatapp!["list"].lenght,

                      itemBuilder: (context, index)
                      {

                        return Container(
                          width: 100,

                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.brown,
                          ),
                          child: Column(children: [
                            Row(children: [
                              Text(" ${forcuatapp![""]}")
                            ],)

                          ],),
                        );
                      },
                    ),
                  ),
                ),

              ],
            ),
    );
  }
}
