import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
                        child: forcustMap == null
                            ? Center(child: CircularProgressIndicator())
                            : Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${forcustMap!['list'][1]['weather'][0]['description']}",
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 21.0,
                                        color: Allcolor.whitecolor,
                                      ),
                                    ),
                                    Image.network(
                                      "https://openweathermap.org/img/wn/${forcustMap!["list"][1]["weather"][0]['icon']}@2x.png",
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      flex: 11,
                      child:  Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                gradient: LinearGradient(tileMode: TileMode.mirror,
                                  colors: [
                                    Allcolor.fastcolor.withAlpha(180),
                                    Allcolor.thardcolor.withAlpha(180),
                                    Allcolor.secondcolort.withAlpha(180),
                                  ],
                                ),
                              ),
                              child: ListView.builder(
                                itemCount: forcustMap!['list'].length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,

                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 8.0,
                                      left: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 190.0,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20.0,
                                            ),
                                            gradient: LinearGradient(
                                              colors: [
                                                Allcolor.fastcolor,
                                                Allcolor.secondcolort,
                                                Allcolor.thardcolor,
                                              ],
                                              tileMode: TileMode.mirror,
                                              end: AlignmentGeometry
                                                  .bottomCenter,
                                              begin:
                                                  AlignmentGeometry.topCenter,
                                              transform: GradientRotation(25.0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 15.0),
                                        Container(
                                          height: 190.0,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20.0,
                                            ),
                                            gradient: LinearGradient(
                                              colors: [
                                                Allcolor.fastcolor,
                                                Allcolor.secondcolort,
                                                Allcolor.thardcolor,
                                              ],
                                              tileMode: TileMode.mirror,
                                              end: AlignmentGeometry
                                                  .bottomCenter,
                                              begin:
                                                  AlignmentGeometry.topCenter,
                                              transform: GradientRotation(25.0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 15.0),
                                        Container(
                                          height: 190.0,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20.0,
                                            ),
                                            gradient: LinearGradient(
                                              colors: [
                                                Allcolor.fastcolor,
                                                Allcolor.secondcolort,
                                                Allcolor.thardcolor,
                                              ],
                                              tileMode: TileMode.mirror,
                                              end: AlignmentGeometry
                                                  .bottomCenter,
                                              begin:
                                                  AlignmentGeometry.topCenter,
                                              transform: GradientRotation(25.0),
                                            ),
                                          ),
                                        ),
                                      ],
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
