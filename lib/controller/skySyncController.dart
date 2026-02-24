import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:skysync/utls/apps_component.dart';

class SkySyncController extends GetxController {
  Position? currentposition;
  determinePosition() async {
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
  }

  Map<String, dynamic>? weatherMap;
  Map<String, dynamic>? forcustMap;

  currentweather() async {
    try {
      String weatherurl =
          "https://api.openweathermap.org/data/2.5/weather?lat=${currentposition!.latitude}&lon=${currentposition!.longitude}&units=metric&appid=$apikey";

      var response = await http.get(Uri.parse(weatherurl));

      if (response.statusCode == 200) {
        weatherMap = jsonDecode(response.body);
        update();
      } else {
        print("Server Error: ${response.statusCode}");
      }

    } catch (e) {
      print("Error fetching weather: $e");
    }
  }
}
