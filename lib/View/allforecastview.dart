import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skysync/utls/allColor.dart';
import 'package:skysync/utls/all_Image.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class Allforecastview extends StatefulWidget {
  const Allforecastview({super.key});

  @override
  State<Allforecastview> createState() => _AllforecastviewState();
}

class _AllforecastviewState extends State<Allforecastview> {
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
      " All forcast Latatute ${currentposition!.latitude} Longatitute${currentposition!.longitude}",
    );
    forecast();
  }

  Map<String, dynamic>? forcustMap;
  forecast() async {
    String allforcusturl =
        "https://api.openweathermap.org/data/2.5/forecast?lat=${currentposition!.latitude}&lon=${currentposition!.longitude}&appid=83c0ca273fda6a20b453ce84758606a1";
    var response = await http.get(Uri.parse(allforcusturl));
    print(" forcast data ${response.body}");
    try {
      if (response.statusCode == 200) {
        forcustMap = Map<String, dynamic>.from(jsonDecode(response.body));
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AllImage.skypic),
                fit: BoxFit.cover,
              ),
            ),
          ),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.withOpacity(0.2),
                    Colors.black.withOpacity(0.4),
                  ],
                ),
              ),

              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: forcustMap == null
                          ? Center(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  gradient: LinearGradient(
                                    colors: [
                                      Allcolor.fastcolor.withAlpha(180),
                                      Allcolor.secondcolort.withAlpha(180),
                                      Allcolor.thardcolor.withAlpha(180),
                                    ],
                                  ),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(68.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "description......",
                                        style: GoogleFonts.iansui(
                                          fontSize: 21.0,
                                          color: Allcolor.whitecolor,
                                        ),
                                      ),
                                      Text(
                                        "Humidity......",
                                        style: GoogleFonts.iansui(
                                          fontSize: 21.0,
                                          color: Allcolor.whitecolor,
                                        ),
                                      ),
                                      Text(
                                        "Pressure......",
                                        style: GoogleFonts.iansui(
                                          fontSize: 21.0,
                                          color: Allcolor.whitecolor,
                                        ),
                                      ),
                                      Text(
                                        "feels_like......",
                                        style: GoogleFonts.iansui(
                                          fontSize: 21.0,
                                          color: Allcolor.whitecolor,
                                        ),
                                      ),
                                      Text(
                                        "sea_level......",
                                        style: GoogleFonts.iansui(
                                          fontSize: 21.0,
                                          color: Allcolor.whitecolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                gradient: LinearGradient(
                                  colors: [
                                    Allcolor.fastcolor.withAlpha(180),
                                    Allcolor.secondcolort.withAlpha(180),
                                    Allcolor.thardcolor.withAlpha(180),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 10,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${forcustMap!['list'][1]['weather'][0]['description']}",
                                                    style: GoogleFonts.aBeeZee(
                                                      fontSize: 21.0,
                                                      color:
                                                          Allcolor.whitecolor,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Humidity is : ${forcustMap!['list'][0]['main']['humidity']}%",
                                                    style: GoogleFonts.iansui(
                                                      fontSize: 21.0,
                                                      color:
                                                          Allcolor.whitecolor,
                                                    ),
                                                  ),

                                                  Text(
                                                    "pressure is : ${forcustMap!['list'][0]['main']['pressure']}hPa",
                                                    style: GoogleFonts.iansui(
                                                      fontSize: 21.0,
                                                      color:
                                                          Allcolor.whitecolor,
                                                    ),
                                                  ),
                                                  Text(
                                                    "feels_like is : ${(forcustMap!['list'][0]['main']['feels_like'] - 273.15).toStringAsFixed(2)}°C",
                                                    style: GoogleFonts.iansui(
                                                      fontSize: 21.0,
                                                      color:
                                                          Allcolor.whitecolor,
                                                    ),
                                                  ),
                                                  Text(
                                                    "sea_level ia : ${forcustMap!['list'][0]['main']['sea_level']}hpa",
                                                    style: GoogleFonts.iansui(
                                                      fontSize: 21.0,
                                                      color:
                                                          Allcolor.whitecolor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 200,
                                      width: 1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Allcolor.whitecolor,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            "https://openweathermap.org/img/wn/${forcustMap!["list"][1]["weather"][0]['icon']}@2x.png",

                                            width: 180.0,
                                            fit: BoxFit.cover,
                                          ),

                                          Text(
                                            "Temp Is : ${(forcustMap!['list'][0]['main']['temp'] - 273.15).toStringAsFixed(1)}°C",
                                            style: GoogleFonts.iansui(
                                              fontSize: 21.0,
                                              color: Allcolor.whitecolor,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      flex: 11,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          gradient: LinearGradient(
                            tileMode: TileMode.mirror,
                            colors: [
                              Allcolor.fastcolor.withAlpha(180),
                              Allcolor.thardcolor.withAlpha(180),
                              Allcolor.secondcolort.withAlpha(180),
                            ],
                          ),
                        ),
                        child: forcustMap == null
                            ? Center(
                                child: Text(
                                  "Loading...",
                                  style: GoogleFonts.radioCanada(
                                    fontSize: 21.0,
                                    color: Allcolor.whitecolor,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: forcustMap!['list'].length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,

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
                                        ).add(
                                          Duration(seconds: timezoneOffset),
                                        );

                                    return "${date.hour % 12 == 0 ? 12 : date.hour % 12}:"
                                        "${date.minute.toString().padLeft(2, '0')} "
                                        "${date.hour >= 12 ? "PM" : "AM"}";
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10,
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          20.0,
                                        ),
                                        gradient: LinearGradient(
                                          colors: [
                                            Allcolor.thardcolor,
                                            Allcolor.secondcolort,
                                            Allcolor.fastcolor,
                                          ],
                                          tileMode: TileMode.clamp,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 12,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Temp :${(item['main']['temp'] - 273.15).toStringAsFixed(2)}°C",
                                                    style: GoogleFonts.iansui(
                                                      fontSize: 21.0,
                                                      color:
                                                          Allcolor.whitecolor,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Speed :${(item['wind']['speed']).toStringAsFixed(2)}m/s",
                                                    style: GoogleFonts.iansui(
                                                      fontSize: 21.0,
                                                      color:
                                                          Allcolor.whitecolor,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Time :${formatTime(item["dt"], forcustMap!["city"]["timezone"] ?? 0)}",
                                                    style: GoogleFonts.iansui(
                                                      fontSize: 21.0,
                                                      color:
                                                          Allcolor.whitecolor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Expanded(
                                              flex: 7,
                                              child: Column(
                                                children: [
                                                  Image.network(
                                                    "https://openweathermap.org/img/wn/${forcustMap!["list"][1]["weather"][0]['icon']}@4x.png",
                                                    height: 110,
                                                    width: 200,
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
