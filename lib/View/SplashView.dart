import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skysync/View/weather_home_view.dart';
import 'package:skysync/common/customeButton.dart';
import 'package:skysync/utls/allColor.dart';
import 'package:skysync/utls/all_Image.dart';

class Splashview extends StatelessWidget {
  const Splashview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Allcolor.fastcolor,
                  Allcolor.secondcolort,
                  Allcolor.thardcolor,
                ],
                tileMode: TileMode.clamp,
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: 50.0,
            left: 10,
            right: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Image.asset(AllImage.weatherpic, height: 400, width: 400),
                SizedBox(height: 40),
                Text(
                  "Sky Sync ",
                  style: GoogleFonts.nunito(
                    fontSize: 50.0,
                    color: Allcolor.whitecolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "ForeCasts",
                  style: GoogleFonts.nunito(
                    fontSize: 45,
                    color: Allcolor.whitecolor,
                  ),
                ),
                SizedBox(height: 120),
                Customebutton(
                  onTap: () {
                    Get. to(WeatherHomeView());
                  },
                  color: Allcolor.purplecolor,
                  text: "Get Start",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
