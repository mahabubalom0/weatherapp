import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:skysync/View/allforecastview.dart';
import 'package:skysync/utls/all_Image.dart';
import '../utls/allColor.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherHomeView extends StatefulWidget {
  const WeatherHomeView({super.key});

  @override
  State<WeatherHomeView> createState() => _WeatherHomeViewState();
}

class _WeatherHomeViewState extends State<WeatherHomeView> {
  Position? currentposition;
  _determinePosition() async {
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
      "Latatute ${currentposition!.latitude} Longatitute${currentposition!.longitude}",
    );
    currentweather();
    forcustweather();
  }

  Map<String, dynamic>? weatherMap;
  Map<String, dynamic>? forcustMap;
  currentweather() async {
    String weatherurl =
        "https://api.openweathermap.org/data/2.5/weather?lat=${currentposition!.latitude}&lon=${currentposition!.longitude}&appid=83c0ca273fda6a20b453ce84758606a1";
    var responce = await http.get(Uri.parse(weatherurl));
    try {
      if (responce.statusCode == 200) {
        setState(() {
          weatherMap = Map<String, dynamic>.from(jsonDecode(responce.body));
        });
      }
    } catch (e) {
      print(e.toString());
    }
    print(weatherurl);
    print("Weather is responce${responce.body}");
  }

  forcustweather() async {
    String forcusturl =
        "https://api.openweathermap.org/data/2.5/forecast?lat=${currentposition!.latitude}&lon=${currentposition!.longitude}&appid=83c0ca273fda6a20b453ce84758606a1";
    print(forcusturl);

    var responce = await http.get(Uri.parse(forcusturl));
    try {
      if (responce.statusCode == 200) {
        setState(() {
          forcustMap = Map<String, dynamic>.from(jsonDecode(responce.body));
        });
        Get.snackbar(
          "",
          "Your data has been successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Allcolor.purplecolor,
          borderRadius: 25.0,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Allcolor.fastcolor,
              Allcolor.secondcolort,
              Allcolor.thardcolor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 20.0,
              child: weatherMap == null
                  ? Padding(
                      padding: EdgeInsetsGeometry.all(30),
                      child: Center(
                        child: Text(
                          "Loading.....",
                          style: GoogleFonts.radioCanada(
                            fontSize: 21.0,
                            color: Allcolor.whitecolor,
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Image.network(
                          "https://openweathermap.org/img/wn/${weatherMap!["weather"][0]["icon"]}@2x.png",
                        ),
                        Text(
                          "${(weatherMap!["main"]["temp"] - 273.15).toStringAsFixed(1)}°C",
                          style: GoogleFonts.inter(
                            fontSize: 40.0,
                            color: Allcolor.whitecolor,
                          ),
                        ),
                        Text(
                          "Location:${weatherMap!["name"]},${weatherMap!["sys"]["country"]}",
                          style: GoogleFonts.inter(
                            fontSize: 25.0,
                            color: Allcolor.whitecolor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Min : ${(weatherMap!["main"]["temp_min"] - 273.15).toStringAsFixed(1)}°C",
                              style: GoogleFonts.inter(
                                fontSize: 20.0,
                                color: Allcolor.whitecolor,
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              "Max : ${(weatherMap!["main"]["temp_max"] - 273.15).toStringAsFixed(1)}°C",
                              style: GoogleFonts.inter(
                                fontSize: 20.0,
                                color: Allcolor.whitecolor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        Text(
                          Jiffy.parse(
                            DateTime.now().toString(),
                          ).format(pattern: ' h:mm a,  do MMMM  yyyy'),
                          style: GoogleFonts.inter(
                            fontSize: 21.0,
                            color: Allcolor.whitecolor,
                          ),
                        ),
                      ],
                    ),
            ),

            // ✅ RomeOne Image
            Positioned(
              bottom: 350,
              left: 0,
              right: 0,
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/romeone.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // ✅ Bottom Panel
            Positioned(
              bottom: 1,
              left: 0,
              right: 0,
              child: Container(
                height: 360.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Allcolor.thardcolor,
                      Allcolor.fastcolor,
                      Allcolor.fastcolor,
                    ],
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today",
                            style: GoogleFonts.inter(
                              fontSize: 20.0,
                              color: Allcolor.whitecolor,
                            ),
                          ),
                          Text(
                            "July, 21",
                            style: GoogleFonts.inter(
                              fontSize: 21,
                              color: Allcolor.whitecolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(endIndent: 30.0, indent: 30.0),
                    SizedBox(
                      height: 220,
                      child: forcustMap == null
                          ? Center(
                              child: Padding(
                                padding: EdgeInsetsGeometry.all(10),
                                child: Text(
                                  "loading....",
                                  style: GoogleFonts.iansui(
                                    fontSize: 21.0,
                                    color: Allcolor.whitecolor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: 10,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var item = forcustMap!['list'][index];

                                String formatTime(
                                  int timestamp,
                                  int timezoneOffset,
                                ) {
                                  DateTime date =
                                      DateTime.fromMillisecondsSinceEpoch(
                                        timestamp * 1000,
                                        isUtc: true,
                                      ).add(Duration(seconds: timezoneOffset));

                                  return "${date.hour % 12 == 0 ? 12 : date.hour % 12}:"
                                      "${date.minute.toString().padLeft(2, '0')} "
                                      "${date.hour >= 12 ? "PM" : "AM"}";
                                }

                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  width: 80,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Allcolor.fastcolor,
                                        Allcolor.thardcolor,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        " ${(item!["main"]["temp"] - 273.15).toStringAsFixed(1)}°C",
                                        style: GoogleFonts.inter(
                                          fontSize: 21.0,
                                          color: Allcolor.whitecolor,
                                        ),
                                      ),
                                      Image.network(
                                        "https://openweathermap.org/img/wn/${item!["weather"][0]["icon"]}@2x.png",
                                      ),
                                      Text(
                                        formatTime(
                                          item["dt"],
                                          forcustMap!["city"]["timezone"] ?? 0,
                                        ),
                                        style: GoogleFonts.alkatra(
                                          fontSize: 17.0,
                                          color: Allcolor.whitecolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 298.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(Allforecastview());
                        },
                        child: Text(
                          "See All   ",
                          style: GoogleFonts.actor(
                            fontSize: 21.0,
                            color: Allcolor.whitecolor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _determinePosition();
    super.initState();
  }
}
